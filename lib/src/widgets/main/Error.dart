import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class ErrorNotification extends StatelessWidget {
  const ErrorNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          SvgPicture.asset("assets/svg/NotFound.svg"),
          Text("No results found", style: AppTextStyles.h1),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley ",
            style: AppTextStyles.body3,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
