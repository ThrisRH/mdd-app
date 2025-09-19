import 'package:flutter/material.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class UserInfoCard extends StatefulWidget {
  const UserInfoCard({super.key});

  @override
  State<UserInfoCard> createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<UserInfoCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/banner/banner.jpg"),
            ),
          ),
          SizedBox(width: 16),
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "MDD",
                  style: AppTextStyles.h2.copyWith(color: Colors.white),
                ),
                Text(
                  "Coding, Designing, Writing blogs",
                  style: AppTextStyles.body3.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
