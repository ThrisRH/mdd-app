import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/models/blog_details_model.dart';
import 'package:mddblog/src/models/blog_model.dart';
import 'package:mddblog/src/models/comment_model.dart';
import 'package:mddblog/src/services/blog_service.dart';
import 'package:mddblog/src/services/comment_service.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/main/error.dart';
import 'package:mddblog/src/widgets/main/loading.dart';
import 'package:mddblog/src/widgets/post/leave_comment.dart';
import 'package:mddblog/src/widgets/post/post_detail.dart';
import 'package:mddblog/src/widgets/post/relative_post.dart';
import 'package:mddblog/src/widgets/post/share_with.dart';

// Controller
class BlogDetailsController extends GetxController {
  final BlogService _blogService = BlogService();
  final CommentService _commentService = CommentService();
  late String blogSlug;

  var blogDetail = Rxn<BlogDetails>();
  var relativeBlogs = <BlogData>[].obs;
  var comments = <CommentContent>[].obs;
  var isDetailLoading = true.obs;
  var isRelativeLoading = true.obs;
  var isCommentLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    blogSlug = Get.arguments['slug'] as String;

    Future.delayed(Duration(seconds: 1), () {
      fetchBlogDetails(blogSlug);
    });

    ever(blogDetail, (detail) {
      if (detail?.categoryData != null) {
        fetchRelativeBlogs(detail!.categoryData.documentId);
      }
      if (detail?.documentId != null) {
        fetchComment(detail!.documentId);
      }
    });
  }

  Future<void> fetchBlogDetails(String slug) async {
    try {
      isDetailLoading.value = true;
      final response = await _blogService.getBlogsBySlug(slug);
      blogDetail.value = response.data;

      if (blogDetail.value?.categoryData != null) {
        fetchRelativeBlogs(blogDetail.value!.categoryData.documentId);
      }
    } catch (error) {
      Get.snackbar("Error", error.toString());
    } finally {
      isDetailLoading.value = false;
    }
  }

  Future<void> fetchRelativeBlogs(String cateId) async {
    try {
      isRelativeLoading.value = true;
      final response = await _blogService.getBlogsByCate(cateId);
      relativeBlogs.assignAll(response.data);
    } catch (error) {
      Get.snackbar("Error", error.toString());
    } finally {
      isRelativeLoading.value = false;
    }
  }

  // Comment

  Future<void> fetchComment(String blogId) async {
    try {
      isCommentLoading.value = true;
      final response = await _commentService.getComment(blogId);
      comments.assignAll(response.comments);
    } finally {
      isCommentLoading.value = false;
    }
  }

  Future<bool> sendComment(
    String blogId,
    String readerId,
    String comment,
  ) async {
    if (blogId == "" || readerId == "" || comment == "") {
      Get.snackbar(
        "Error Comment!",
        "Không được để trống!!",
        colorText: Colors.white,
        backgroundColor: Colors.red.withValues(alpha: 0.4),
      );
      return false;
    }

    if (comment.length < 8) {
      Get.snackbar(
        "Error Comment!",
        "Comment quá ngắn!",
        colorText: Colors.white,
        backgroundColor: Colors.red.withValues(alpha: 0.4),
      );
      return false;
    }

    final response = await _commentService.sendComment(
      readerId,
      comment,
      blogId,
    );
    if (!response) {
      Get.snackbar(
        "Error Comment!",
        "Gửi comment thất bại!!",
        colorText: Colors.white,
        backgroundColor: Colors.red.withValues(alpha: 0.4),
      );
      return false;
    }
    return true;
  }
}

class BlogDetailsPage extends GetWidget<BlogDetailsController> {
  BlogDetailsPage({super.key});

  final RxBool showOverlay = false.obs;

  void toggleOverlay() {
    showOverlay.value = !showOverlay.value;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              controller.fetchBlogDetails(controller.blogSlug);
              controller.fetchComment(controller.blogDetail.value!.documentId);
              controller.fetchRelativeBlogs(
                controller.blogDetail.value!.categoryData.documentId,
              );
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  // Header Bar
                  MDDNavbar(onMenuTap: toggleOverlay),

                  // // Body
                  Obx(() {
                    final detail = controller.blogDetail.value;
                    final relativePosts = controller.relativeBlogs;
                    final comments = controller.comments;

                    if (controller.isDetailLoading.value) {
                      return Center(child: Loading());
                    }
                    if (detail == null) {
                      return ErrorNotification();
                    }

                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsets.only(top: 40),
                      child: Column(
                        spacing: 16,
                        children: [
                          BlogDetailsContainer(detail: detail),
                          ShareWith(),
                          RelativePost(relativePosts),
                          LeaveComment(comments, blogId: detail.documentId),
                        ],
                      ),
                    );
                  }),
                  // Footer
                  Footer(),
                ],
              ),
            ),
          ),
        ),

        // Show ra Overlay nav điều hướng khi showOverlay === true
        Obx(
          () =>
              showOverlay.value
                  ? OverlayToggle(closeOverlay: toggleOverlay)
                  : SizedBox.shrink(),
        ),
      ],
    );
  }
}
