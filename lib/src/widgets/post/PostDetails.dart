import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:mddblog/src/config/constants.dart';
import 'package:mddblog/src/models/blog_details_model.dart';
import 'package:mddblog/src/widgets/post/headerLine.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class BlogDetailsContainer extends StatelessWidget {
  final BlogDetails detail;
  const BlogDetailsContainer({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                ).format(DateTime.parse(detail.publishedAt)),
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
        Center(
          child: Text(
            detail.title,
            style: AppTextStyles.h3.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 24),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            '$baseUrlNoUrl${detail.cover.url}',
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 24),
        Text(
          detail.mainContent,
          style: AppTextStyles.body2.copyWith(color: Colors.black),
        ),
        SizedBox(height: 24),

        if (detail.optionImage?.isNotEmpty ?? false)
          ...detail.optionImage!.expand(
            (item) => item.images.map(
              (image) => ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  '$baseUrlNoUrl${detail.cover.url}',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        SizedBox(height: 24),
        ...detail.subContent.map((item) {
          return SizedBox(
            width: double.infinity,
            child: Markdown(
              data: item.content,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
              styleSheet: MarkdownStyleSheet(
                h1: AppTextStyles.h1,
                h2: AppTextStyles.h2,
                h3: AppTextStyles.h3,
                h4: AppTextStyles.h4,
                p: AppTextStyles.body2,
              ),
            ),
          );
        }),
      ],
    );
  }
}
