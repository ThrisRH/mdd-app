import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/controllers/overlay-controller.dart';
import 'package:mddblog/models/blog-model.dart';
import 'package:mddblog/services/blog-service.dart';
import 'package:mddblog/src/widgets/post/list-blog.dart';

class BlogBySearchQueryController extends GetxController {
  final BlogService _blogService = BlogService();

  var blogs = <BlogData>[].obs;
  var isLoading = true.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  late String query;

  @override
  void onInit() {
    super.onInit();
    query = Get.arguments['query'] as String;
    fetchBlogByQuery(query, currentPage.value);
  }

  // Fetch blog theo Query
  void fetchBlogByQuery(String query, int page) async {
    try {
      isLoading.value = true;
      currentPage.value = page;
      final response = await _blogService.getBlogsByQuery(
        query,
        page: currentPage.value,
      );
      totalPages.value = response.meta.pagination.pageCount;
      blogs.assignAll(response.data);
    } catch (error) {
      return;
    } finally {
      isLoading.value = false;
    }
  }

  void openBlogsDetail(String slug) {
    Get.toNamed('/home/detail/$slug', arguments: {'slug': slug});
  }
}

class BlogBySearchQueryPage extends GetWidget<BlogBySearchQueryController> {
  BlogBySearchQueryPage({super.key});

  final overlayController = Get.find<OverlayController>();
  @override
  Widget build(BuildContext context) {
    return BlogListBody(
      title: "Search Results for: ${controller.query}",
      onRefresh: () async {
        controller.fetchBlogByQuery(
          controller.query,
          controller.currentPage.value,
        );
      },
      isLoading: controller.isLoading,
      blogs: controller.blogs,
      currentPage: controller.currentPage,
      totalPages: controller.totalPages,
      onPageSelected: (page) {
        if (page != controller.currentPage.value) {
          controller.fetchBlogByQuery(controller.query, page);
        }
      },
      onBlogTap: (blog) => controller.openBlogsDetail(blog.slug),
    );
  }
}
