import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/controllers/blog-by-cate-controller.dart';
import 'package:mddblog/controllers/overlay-controller.dart';
import 'package:mddblog/src/views/home/widgets/banner.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/main/loading.dart';
import 'package:mddblog/src/widgets/main/pagination_bar.dart';
import 'package:mddblog/src/widgets/post/post-card.dart';

class Category extends GetWidget<BlogByCateController> {
  Category({super.key});

  final overlayController = Get.find<OverlayController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: MDDNavbar(onMenuTap: overlayController.toggleOverlay),
          body: RefreshIndicator(
            onRefresh: () async {
              controller.fetchBlogByCate(
                controller.cateId,
                controller.currentPage.value,
              );
            },
            child: ListView(
              children: [
                // Banner
                BannerSection(),
                // Body
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Text(
                        controller.cateName,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(height: 40),

                      Obx(() {
                        if (controller.isLoading.value) {
                          return Center(child: Loading());
                        }
                        if (controller.blogs.isEmpty) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height - 400,
                            child: const Center(
                              child: Text("Chưa có bất bài viết nào"),
                            ),
                          );
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
                Obx(() {
                  if (controller.blogs.isEmpty) {
                    return SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      PaginationBar(
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
                      Footer(),
                    ],
                  );
                }),
              ],
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
