import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/controllers/overlay-controller.dart';
import 'package:mddblog/models/blog-model.dart';
import 'package:mddblog/services/blog-service.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/main/error.dart';
import 'package:mddblog/src/widgets/main/loading.dart';
import 'package:mddblog/src/widgets/main/pagination_bar.dart';
import 'package:mddblog/src/widgets/post/post-card.dart';

class BlogBySearchQueryController extends GetxController {
  final BlogService _blogService = BlogService();

  var blogs = <BlogData>[].obs;
  var isLoading = true.obs;
  var currentPage = RxInt(1);
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
    Get.toNamed('/home/$slug', arguments: {'slug': slug});
  }
}

class BlogBySearchQueryPage extends GetWidget<BlogBySearchQueryController> {
  BlogBySearchQueryPage({super.key});

  final overlayController = Get.find<OverlayController>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              controller.fetchBlogByQuery(
                controller.query,
                controller.currentPage.value,
              );
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  // Header Bar
                  MDDNavbar(onMenuTap: overlayController.toggleOverlay),

                  // Body
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: Loading());
                    }
                    if (controller.blogs.isEmpty) {
                      return ErrorNotification();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 16.0,
                        left: 16.0,
                        top: 32.0,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Kết quả tìm kiếm cho: ${controller.query}",
                            style: Theme.of(context).textTheme.headlineLarge,
                            textAlign: TextAlign.center,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.blogs.length,
                            itemBuilder: (context, index) {
                              final blog = controller.blogs[index];
                              return PostCard(
                                blogData: blog,
                                onTap:
                                    () => controller.openBlogsDetail(blog.slug),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                  // Pagination Area
                  Obx(() {
                    if (controller.blogs.isEmpty) {
                      return SizedBox.shrink();
                    }
                    return PaginationBar(
                      totalPages: controller.totalPages.value,
                      onPageSelected:
                          (page) => {
                            if (page != controller.currentPage.value)
                              {
                                controller.fetchBlogByQuery(
                                  controller.query,
                                  page,
                                ),
                              },
                          },
                      currentPage: controller.currentPage.value,
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
              overlayController.showOverlay.value
                  ? OverlayToggle(closeOverlay: overlayController.closeOverlay)
                  : SizedBox.shrink(),
        ),
      ],
    );
  }
}
