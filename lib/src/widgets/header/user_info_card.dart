import 'package:flutter/material.dart';
import 'package:mddblog/src/config/constants.dart';
import 'package:mddblog/src/models/author_model.dart';

class UserInfoCard extends StatelessWidget {
  final AuthorInfo data;
  const UserInfoCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        spacing: 16,
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
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  "my ${data.fullname} diary",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(fontSize: 22),
                ),
                Row(
                  children: [
                    Text(
                      data.authorHobbies
                          .map((item) => item.interest)
                          .join(", "),
                      style: Theme.of(context).textTheme.bodySmall,
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
