import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:mddblog/src/config/constants.dart';
import 'package:mddblog/src/models/blog_details_model.dart';
import 'package:mddblog/src/widgets/post/header_line.dart';

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
            '$baseUrlNoUrl${detail.cover.url}',
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Text(detail.mainContent, style: Theme.of(context).textTheme.bodyMedium),

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
        ...detail.subContent.map((item) {
          return SizedBox(
            width: double.infinity,
            child: Markdown(
              data: item.content,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
              styleSheet: MarkdownStyleSheet(
                h1: Theme.of(context).textTheme.headlineMedium,
                h2: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(fontSize: 22),
                h3: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(fontSize: 20),
                h4: Theme.of(context).textTheme.headlineSmall,
                p: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        }),
      ],
    );
  }
}
