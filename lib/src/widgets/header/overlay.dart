import 'package:flutter/material.dart';
import 'package:mddblog/src/widgets/header/userInfoCard.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class OverlayToggle extends StatelessWidget {
  final VoidCallback closeOverlay;
  const OverlayToggle({super.key, required this.closeOverlay});

  final double spacing = 32;

  final List<Map<String, String>> menuItems = const [
    {"title": "TRANG CHỦ", "route": "/home"},
    {"title": "GIỚI THIỆU", "route": "/about"},
    {"title": "CHỦ ĐỀ", "route": "/topics"},
    {"title": "HỎI ĐÁP", "route": "/faq"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: GestureDetector(
                onTap: closeOverlay,
                child: Icon(Icons.close, color: Colors.white),
              ),
            ),
            Divider(color: Colors.white.withOpacity(0.2), thickness: 1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thông tin của Blogger
                  SizedBox(height: 32),
                  UserInfoCard(),
                  SizedBox(height: 32),
                  Divider(color: Colors.white.withOpacity(0.2), thickness: 1),
                  SizedBox(height: 32),

                  // Thanh điều hướng
                  ...menuItems.map(
                    (item) => Padding(
                      padding: EdgeInsets.only(bottom: spacing),
                      child: GestureDetector(
                        onTap:
                            () => Navigator.pushNamed(context, item["route"]!),
                        child: Text(item["title"]!, style: AppTextStyles.h2),
                      ),
                    ),
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
