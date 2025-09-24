import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/models/blog_details_model.dart';
import 'package:mddblog/src/models/blog_model.dart';
import 'package:mddblog/src/services/blog_service.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/main/Error.dart';
import 'package:mddblog/src/widgets/main/Loading.dart';
import 'package:mddblog/src/widgets/post/PostDetails.dart';
import 'package:mddblog/src/widgets/post/RelativePost.dart';
import 'package:mddblog/src/widgets/post/ShareWith.dart';

// Controller
class BlogDetailsController extends GetxController {
  final BlogService _blogService = BlogService();
  late String blogSlug;

  var blogDetail = Rxn<BlogDetails>();
  var relativeBlogs = <BlogData>[].obs;
  var isDetailLoading = true.obs;
  var isRelativeLoading = true.obs;

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
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Header Bar
                MDDNavbar(onMenuTap: toggleOverlay),

                // // Body
                Obx(() {
                  final detail = controller.blogDetail.value;
                  final relativePosts = controller.relativeBlogs;

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
