import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mddblog/config/constants.dart';
import 'package:mddblog/controllers/blog-controller.dart';
import 'package:mddblog/models/blog-model.dart';
import 'package:mddblog/src/widgets/post/section-wrapper.dart';
import 'package:mddblog/utils/env.dart';

class RelativePost extends StatelessWidget {
  final List<BlogData> relativeBlogs;
  RelativePost(this.relativeBlogs, {super.key});

  final BlogController c = Get.put(BlogController());

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Text(
              "BÀI VIẾT LIÊN QUAN",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
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
                        child: CachedNetworkImage(
                          imageUrl:
                              Env.isDev
                                  ? '$baseUrlNoUrl${item.cover.url}'
                                  : item.cover.url,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        item.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        DateFormat(
                          "dd.MM.yyyy",
                        ).format(DateTime.parse(item.publishedAt)),
                        style: Theme.of(context).textTheme.bodySmall,
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
