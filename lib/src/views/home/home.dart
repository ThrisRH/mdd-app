// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/controllers/blog_controller.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/main/Error.dart';
import 'package:mddblog/src/widgets/main/Loading.dart';
import 'package:mddblog/src/widgets/main/PaginationBar.dart';
import 'package:mddblog/src/widgets/post/PostCard.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class Home extends GetWidget<BlogController> {
  Home({super.key});

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
                SizedBox(height: 32),
                Text("Blogs", style: AppTextStyles.h0),

                Obx(() {
                  // Body
                  if (controller.isLoading.value) {
                    return Center(child: Loading());
                  }
                  if (controller.blogs.isEmpty) {
                    return ErrorNotification();
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ListView.builder(
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
                      ),

                      // Pagination Area
                      PaginationBar(
                        totalPages: controller.totalPages.value,
                        onPageSelected:
                            (page) => {
                              if (page != controller.currentPage.value)
                                {controller.fetchPage(page)},
                            },
                        currentPage: controller.currentPage.value,
                      ),

                      // Footer
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
              showOverlay.value
                  ? OverlayToggle(closeOverlay: toggleOverlay)
                  : SizedBox.shrink(),
        ),
      ],
    );
  }
}
