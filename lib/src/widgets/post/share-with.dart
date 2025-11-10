// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mddblog/src/widgets/post/section-wrapper.dart';

class ShareWith extends StatelessWidget {
  const ShareWith({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      child: Row(
        spacing: 12,
        children: [
          Text(
            "CHIA SẼ BÀI VIẾT QUA",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SvgPicture.asset(
            "assets/svg/Fb.svg",
            width: 24,
            height: 24,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          SvgPicture.asset(
            "assets/svg/x.svg",
            width: 24,
            height: 24,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          SvgPicture.asset(
            "assets/svg/linkedin.svg",
            width: 24,
            height: 24,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ],
      ),
    );
  }
}
