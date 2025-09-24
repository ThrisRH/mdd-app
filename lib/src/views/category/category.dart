import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/controllers/blog_by_cate_controller.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/main/PaginationBar.dart';
import 'package:mddblog/src/widgets/post/PostCard.dart';
import 'package:mddblog/theme/app_text_styles.dart';

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
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Header Bar
                MDDNavbar(onMenuTap: toggleOverlay),
                SizedBox(height: 32),
                Text(controller.cateName, style: AppTextStyles.h0),

                // Body
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
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
                          onTap: () => controller.openBlogsDetail(blog.slug),
                        );
                      },
                    );
                  }),
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
