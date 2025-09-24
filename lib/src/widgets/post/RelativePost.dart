import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mddblog/src/config/constants.dart';
import 'package:mddblog/src/controllers/blog_controller.dart';
import 'package:mddblog/src/models/blog_model.dart';
import 'package:mddblog/src/widgets/post/SectionWrapper.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class RelativePost extends StatelessWidget {
  final List<BlogData> relativeBlogs;
  RelativePost(this.relativeBlogs, {super.key});

  final BlogController c = Get.put(BlogController());

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      child: Obx(() {
        return Column(
          spacing: 16,
          children: [
            ...relativeBlogs.map(
              (item) => GestureDetector(
                onTap: () => c.openBlogsDetail(item.slug),
                child: SizedBox(
                  width: double.infinity,
                  height: 295,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Image.network(
                          "$baseUrlNoUrl${item.cover.url}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        item.title,
                        style: AppTextStyles.h4,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        DateFormat(
                          "dd.MM.yyyy",
                        ).format(DateTime.parse(item.publishedAt)),
                        style: AppTextStyles.body3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
