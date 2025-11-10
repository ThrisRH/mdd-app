import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutContentSection extends StatelessWidget {
  final String content;
  const AboutContentSection({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Html(data: content, style: {'h1': Style(color: Colors.amber)}),
      ],
    );
  }
}
