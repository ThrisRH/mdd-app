import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/config/constants.dart';
import 'package:mddblog/src/models/blog_model.dart';
import 'package:mddblog/src/views/home/home.dart';
import 'package:mddblog/src/widgets/main/Button.dart';
import 'package:mddblog/src/widgets/post/headerLine.dart';
import 'package:intl/intl.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class PostCard extends StatelessWidget {
  final BlogData blogData;
  final VoidCallback onTap;

  const PostCard({super.key, required this.blogData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            HeaderLine(
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    DateFormat(
                      'dd.MM.yyyy',
                    ).format(DateTime.parse(blogData.publishedAt)),
                  ),
                  SizedBox(width: 6),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(
              blogData.title,
              style: AppTextStyles.h3.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                '$baseUrlNoUrl${blogData.cover.url}',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 24),
            Text(
              blogData.mainContent,
              style: AppTextStyles.body2.copyWith(color: Colors.black),
            ),
            SizedBox(height: 24),
            MDDButton(isPrimary: true, label: "Xem thêm", onTap: onTap),
          ],
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
