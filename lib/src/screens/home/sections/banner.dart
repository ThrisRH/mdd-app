import 'package:flutter/material.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 190,
          child: Opacity(
            opacity: 0.3,
            child: Image.asset("assets/banner/banner.jpg", fit: BoxFit.cover),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Center(
            child: SizedBox(
              width: 116,
              height: 114,
              child: Image.asset("assets/icons/logo.png", fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
  }
}
