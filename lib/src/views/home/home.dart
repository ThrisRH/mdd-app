// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/controllers/blog-controller.dart';
import 'package:mddblog/controllers/overlay-controller.dart';
import 'package:mddblog/src/views/home/widgets/banner.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/main/error.dart';
import 'package:mddblog/src/widgets/main/loading.dart';
import 'package:mddblog/src/widgets/main/pagination_bar.dart';
import 'package:mddblog/src/widgets/post/post-card.dart';

class Home extends GetWidget<BlogController> {
  Home({super.key});

  final overlayController = Get.find<OverlayController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: MDDNavbar(onMenuTap: overlayController.toggleOverlay),
          body: RefreshIndicator(
            onRefresh: () async {
              controller.fetchPage(controller.currentPage.value);
            },
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(child: BannerSection()),

                Obx(() {
                  // Body
                  if (controller.isLoading.value) {
                    return SliverFillRemaining(child: Center(child: Loading()));
                  }
                  if (controller.blogs.isEmpty) {
                    return SliverFillRemaining(
                      child: ErrorNotificationWithMessage(
                        errorMessage: controller.errorMessage.value,
                      ),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      // Tiêu đề
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Center(
                          child: Text(
                            "Blogs",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Danh sách blog
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children:
                              controller.blogs.map((blog) {
                                return PostCard(
                                  blogData: blog,
                                  onTap:
                                      () =>
                                          controller.openBlogsDetail(blog.slug),
                                );
                              }).toList(),
                        ),
                      ),

                      // Thanh phân trang
                      PaginationBar(
                        totalPages: controller.totalPages.value,
                        onPageSelected: (page) {
                          if (page != controller.currentPage.value) {
                            controller.fetchPage(page);
                          }
                        },
                        currentPage: controller.currentPage.value,
                      ),

                      // Footer
                      Footer(),
                    ]),
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
