import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/controllers/blog-by-cate-controller.dart';
import 'package:mddblog/controllers/overlay-controller.dart';
import 'package:mddblog/src/views/home/widgets/banner.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/layout/phone-body.dart';
import 'package:mddblog/src/widgets/main/loading.dart';
import 'package:mddblog/src/widgets/main/pagination_bar.dart';
import 'package:mddblog/src/widgets/post/list-blog.dart';
import 'package:mddblog/src/widgets/post/post-card.dart';

class Category extends GetWidget<BlogByCateController> {
  Category({super.key});

  final overlayController = Get.find<OverlayController>();

  @override
  Widget build(BuildContext context) {
    return BlogListBody(
      title: controller.cateName,
      onRefresh: () async {
        controller.fetchBlogByCate(
          controller.cateId,
          controller.currentPage.value,
        );
      },
      isLoading: controller.isLoading,
      blogs: controller.blogs,
      currentPage: controller.currentPage,
      totalPages: controller.totalPages,
      onPageSelected:
          (page) => {
            if (page != controller.currentPage.value)
              {controller.fetchBlogByCate(controller.cateId, page)},
          },
      onBlogTap: (blog) => controller.openBlogsDetail(blog.slug),
    );
  }
}
