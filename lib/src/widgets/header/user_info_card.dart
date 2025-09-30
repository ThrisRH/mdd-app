import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/config/constants.dart';
import 'package:mddblog/src/controllers/auth_controller.dart';
import 'package:mddblog/src/models/auth_model.dart';
import 'package:mddblog/src/widgets/decoration/dot.dart';

class UserInfoCard extends GetWidget {
  final UserInfoResponse data;
  const UserInfoCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        spacing: 16,
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: ClipOval(
              child: Image.network(
                data.userDetailInfo.avatar != null &&
                        data.userDetailInfo.avatar!.url.isNotEmpty
                    ? "$baseUrlNoUrl${data.userDetailInfo.avatar!.url}"
                    : data.userDetailInfo.avatarUrl,
                errorBuilder:
                    (context, error, stackTrace) => Icon(Icons.person),
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
                  data.userDetailInfo.fullname,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(fontSize: 20),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 6,
                  children: [
                    Text(
                      '@${data.username}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey.shade500
                                : Colors.grey.shade600,
                      ),
                    ),
                    Dot(),
                    Text(
                      data.email,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey.shade500
                                : Colors.grey.shade600,
                      ),
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

class UserInfoCardUnAuth extends GetWidget {
  UserInfoCardUnAuth({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: authController.toSignIn,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          spacing: 16,
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: ClipOval(
                child: Image.asset(
                  "assets/icons/unauth.png",
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
                    'Join with us!',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(fontSize: 20),
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 6,
                    children: [
                      Text(
                        'Đăng nhập vào MDD Blog',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey.shade500
                                  : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
