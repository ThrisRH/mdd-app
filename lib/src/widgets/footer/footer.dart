import 'package:flutter/material.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      width: double.infinity,
      height: 46,
      decoration: BoxDecoration(color: Color(0xFFF4F4F4)),
      child: Center(
        child: Text(
          "Copyright © 2024 My MDD Diary",
          style: AppTextStyles.body3.copyWith(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
