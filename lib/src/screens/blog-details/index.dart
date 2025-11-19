// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/controllers/overlay-controller.dart';
import 'package:mddblog/models/blog-details-model.dart';
import 'package:mddblog/models/blog-model.dart';
import 'package:mddblog/models/comment-model.dart';
import 'package:mddblog/services/blog-service.dart';
import 'package:mddblog/services/comment-service.dart';
import 'package:mddblog/src/screens/home/sections/banner.dart';
import 'package:mddblog/src/widgets/layout/phone-body.dart';
import 'package:mddblog/src/widgets/layout/scroll-wrapper.dart';
import 'package:mddblog/src/widgets/main/error.dart';
import 'package:mddblog/src/widgets/main/loading.dart';
import 'package:mddblog/src/screens/blog-details/sections/leave-comment.dart';
import 'package:mddblog/src/screens/blog-details/sections/blog-detail.dart';
import 'package:mddblog/src/screens/blog-details/sections/relative-post.dart';
import 'package:mddblog/src/screens/blog-details/sections/share-with.dart';
import 'package:mddblog/utils/toast.dart';

// Controller
class BlogDetailsController extends GetxController {
  final BlogService _blogService = BlogService();
  final CommentService _commentService = CommentService();
  late String blogSlug;

  var blogDetail = Rxn<BlogDetails>();
  var relativeBlogs = <BlogData>[].obs;
  var comments = <CommentContent>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    blogSlug = Get.arguments['slug'] as String;

    fetchBlogPage(blogSlug);
  }

  Future<void> fetchBlogPage(String slug) async {
    isLoading.value = true;
    try {
      final detailRes = await _blogService.getBlogsBySlug(slug);
      blogDetail.value = detailRes.data;

      final detail = blogDetail.value;
      if (detail != null) {
        await Future.wait([
          if (detail.categoryData != null)
            fetchRelativeBlogs(detail.categoryData.documentId),
          if (detail.documentId != null) fetchComments(detail.documentId),
        ]);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchRelativeBlogs(String cateId) async {
    try {
      final res = await _blogService.getBlogsByCate(cateId);
      relativeBlogs.assignAll(res.data);
    } catch (e) {
      SnackbarNotification.showError(
        "Không thể tải bài viết liên quan.",
        title: "Lỗi",
      );
    }
  }

  // Comment

  Future<void> fetchComments(String blogId) async {
    try {
      final res = await _commentService.getComment(blogId);
      comments.assignAll(res.comments);
    } catch (e) {
      SnackbarNotification.showError("Không thể tải bình luận.", title: "Lỗi");
    }
  }

  Future<bool> sendComment(
    String blogId,
    String readerId,
    String comment,
  ) async {
    if (blogId == "" || readerId == "" || comment == "") {
      SnackbarNotification.showError(
        title: "Comment thất bại!",
        "Không được để trống!",
      );
      return false;
    }

    if (comment.length < 8) {
      SnackbarNotification.showError(
        title: "Comment thất bại!",
        "Comment quá ngắn!!",
      );
      return false;
    }

    final response = await _commentService.sendComment(
      readerId,
      comment,
      blogId,
    );
    if (!response) {
      SnackbarNotification.showError(
        title: "Comment thất bại!",
        "Gửi comment không thành công!",
      );
      return false;
    }
    return true;
  }
}

class BlogDetailsPage extends GetWidget<BlogDetailsController> {
  BlogDetailsPage({super.key});

  final overlayController = Get.find<OverlayController>();

  @override
  Widget build(BuildContext context) {
    return PhoneBody(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchBlogPage(controller.blogSlug);
        },
        child: ScrollViewWrapper(
          children: [
            BannerSection(),

            // // Body
            Obx(() {
              final detail = controller.blogDetail.value;
              final relativePosts = controller.relativeBlogs;
              final comments = controller.comments;

              if (controller.isLoading.value) {
                return Center(child: Loading());
              }
              if (detail == null) {
                return Center(
                  child: SingleChildScrollView(
                    child: ErrorNotificationWithMessage(
                      errorMessage: 'No results found',
                    ),
                  ),
                );
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
                    LeaveComment(
                      comments,
                      blogId: detail.documentId,
                      blogSlug: detail.slug,
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
