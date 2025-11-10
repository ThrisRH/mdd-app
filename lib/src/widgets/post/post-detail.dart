import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:mddblog/config/constants.dart';
import 'package:mddblog/models/blog-details-model.dart';
import 'package:mddblog/src/widgets/post/header-line.dart';
import 'package:mddblog/utils/env.dart';

class BlogDetailsContainer extends StatelessWidget {
  final BlogDetails detail;
  const BlogDetailsContainer({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                ).format(DateTime.parse(detail.publishedAt)),
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
        Center(
          child: Text(
            detail.title,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontSize: 20),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            Env.isDev ? '$baseUrlNoUrl${detail.cover.url}' : detail.cover.url,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        if (detail.optionImage?.isNotEmpty ?? false)
          ...detail.optionImage!.expand(
            (item) => item.images.map(
              (image) => ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  Env.isDev
                      ? '$baseUrlNoUrl${detail.cover.url}'
                      : detail.cover.url,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        SizedBox(
          child: Text(
            detail.mainContent,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        SizedBox(child: Html(data: detail.subContent)),
      ],
    );
  }
}
