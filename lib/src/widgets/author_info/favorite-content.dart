import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mddblog/controllers/blog-controller.dart';

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
                    return Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: 16),
                      child: GestureDetector(
                        onTap: () => controller.openBlogsDetail(blog.slug),
                        child: Text(
                          "${index + 1}.   ${blog.title}",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
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
