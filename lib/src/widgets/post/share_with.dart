// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/state_manager.dart';
import 'package:mddblog/src/widgets/post/section_wrapper.dart';

class ShareWith extends GetWidget {
  const ShareWith({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      child: Row(
        spacing: 12,
        children: [
          Text(
            "CHIA SẼ BÀI VIẾT QUA",
            style: Theme.of(context).textTheme.bodySmall,
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
