import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/controllers/blog_by_cate_controller.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/main/loading.dart';
import 'package:mddblog/src/widgets/main/pagination_bar.dart';
import 'package:mddblog/src/widgets/post/post_card.dart';

class Category extends GetWidget<BlogByCateController> {
  Category({super.key});

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
              controller.fetchBlogByCate(
                controller.cateId,
                controller.currentPage.value,
              );
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                spacing: 32,
                children: [
                  // Header Bar
                  MDDNavbar(onMenuTap: toggleOverlay),

                  // Body
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Text(
                          controller.cateName,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Obx(() {
                          if (controller.isLoading.value) {
                            return Center(child: Loading());
                          }
                          if (controller.blogs.isEmpty) {
                            return Center(child: Text("No blogs found"));
                          }
                          return ListView.builder(
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
                          );
                        }),
                      ],
                    ),
                  ),
                  // Pagination Area
                  Obx(
                    () => PaginationBar(
                      totalPages: controller.totalPages.value,
                      onPageSelected:
                          (page) => {
                            if (page != controller.currentPage.value)
                              {
                                controller.fetchBlogByCate(
                                  controller.cateId,
                                  page,
                                ),
                              },
                          },
                      currentPage: controller.currentPage.value,
                    ),
                  ),

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
