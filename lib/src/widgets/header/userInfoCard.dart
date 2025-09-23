import 'package:flutter/material.dart';
import 'package:mddblog/src/config/constants.dart';
import 'package:mddblog/src/models/author_model.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class UserInfoCard extends StatelessWidget {
  final AuthorInfo data;
  const UserInfoCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: ClipOval(
              child: Image.network(
                "$baseUrlNoUrl${data.authorAvatar.url}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "my ${data.fullname} diary",
                  style: AppTextStyles.h2.copyWith(color: Colors.white),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      data.authorHobbies
                          .map((item) => item.interest)
                          .join(", "),
                      style: AppTextStyles.body3.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
