import 'package:flutter/material.dart';
import 'package:mddblog/src/models/about_model.dart';

class AboutContentSection extends StatelessWidget {
  final List<AboutContent> contents;
  const AboutContentSection({super.key, required this.contents});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        ...contents.map((about) => Text(about.children[0].text)),
      ],
    );
  }
}
