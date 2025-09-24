import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/controllers/blog_controller.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class FavoriteContent extends GetWidget<BlogController> {
  const FavoriteContent({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 363 / 423, // tỉ lệ của SVG gốc
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/FavoriteContentFrame.svg",
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 64,
              bottom: 32,
              right: 24,
              left: 24,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: double.infinity,

              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.favoriteBlogs.isEmpty) {
                  controller.fetchFavorites();
                  return const Text("Không có blog nào");
                }

                return ListView.builder(
                  itemCount: controller.favoriteBlogs.length,
                  itemBuilder: (context, index) {
                    final blog = controller.favoriteBlogs[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => controller.openBlogsDetail(blog.slug),
                          child: Text(
                            "${index + 1}.   ${blog.title}",
                            style: AppTextStyles.body1.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    ); // render blog tùy bạn
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
