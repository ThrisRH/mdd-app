import 'package:flutter/material.dart';
import 'package:mddblog/config/constants.dart';
import 'package:mddblog/models/blog-model.dart';
import 'package:mddblog/src/widgets/main/button.dart';
import 'package:mddblog/src/widgets/post/header-line.dart';
import 'package:intl/intl.dart';
import 'package:mddblog/theme/element/app-colors.dart';
import 'package:mddblog/utils/env.dart';

class PostCard extends StatelessWidget {
  final BlogData blogData;
  final VoidCallback onTap;

  const PostCard({super.key, required this.blogData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          Column(
            spacing: 24,
            children: [
              HeaderLine(
                child: Row(
                  spacing: 6,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      DateFormat(
                        'dd.MM.yyyy',
                      ).format(DateTime.parse(blogData.publishedAt)),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                blogData.title,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(fontSize: 20),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  Env.isDev
                      ? '$baseUrlNoUrl${blogData.cover.url}'
                      : blogData.cover.url,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                blogData.mainContent,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              MDDButton(
                bgColor: AppColors.primary,
                label: "Xem thêm",
                onTap: onTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
