// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/controllers/blog-controller.dart';
import 'package:mddblog/controllers/overlay-controller.dart';
import 'package:mddblog/src/screens/home/sections/banner.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/layout/phone-body.dart';
import 'package:mddblog/src/widgets/main/error.dart';
import 'package:mddblog/src/widgets/main/loading.dart';
import 'package:mddblog/src/widgets/main/pagination_bar.dart';
import 'package:mddblog/src/widgets/post/post-card.dart';

class Home extends GetWidget<BlogController> {
  Home({super.key});

  final overlayController = Get.find<OverlayController>();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return PhoneBody(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchPage(controller.currentPage.value);
        },
        child: CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            SliverToBoxAdapter(child: BannerSection()),

            // Blog title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Text(
                    "Blogs",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(child: const SizedBox(height: 40)),

            // Blogs list
            Obx(() {
              if (controller.isLoading.value) {
                return const SliverFillRemaining(
                  child: Center(child: Loading()),
                );
              }
              if (controller.blogs.isEmpty) {
                return SliverFillRemaining(
                  child: ErrorNotificationWithMessage(
                    errorMessage: controller.errorMessage.value,
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final blog = controller.blogs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8,
                    ),
                    child: PostCard(
                      blogData: blog,
                      onTap: () => controller.openBlogsDetail(blog.slug),
                    ),
                  );
                }, childCount: controller.blogs.length),
              );
            }),

            SliverToBoxAdapter(
              child: Obx(() {
                if (controller.blogs.isEmpty) {
                  return SizedBox.shrink();
                }
                return PaginationBar(
                  totalPages: controller.totalPages.value,
                  onPageSelected: (page) {
                    if (page != controller.currentPage.value) {
                      controller.fetchPage(page);
                      scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                  currentPage: controller.currentPage.value,
                );
              }),
            ),

            SliverToBoxAdapter(child: Footer()),
          ],
        ),
      ),
    );
  }
}
