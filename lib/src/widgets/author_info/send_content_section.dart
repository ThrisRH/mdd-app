import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/widgets/main/button.dart';
import 'package:mddblog/theme/element/app_colors.dart';

class SendContentSection extends GetWidget {
  const SendContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 363 / 274, // tỉ lệ của SVG gốc
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/SendContentFrame.svg",
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 64,
              bottom: 12,
              right: 24,
              left: 24,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                spacing: 12,
                children: [
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.black),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Nhập email của bạn",
                        hintStyle: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: Color(0xFF8B8B8B)),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  MDDButton(
                    bgColor: AppColors.primary,
                    label: "Đăng ký",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
