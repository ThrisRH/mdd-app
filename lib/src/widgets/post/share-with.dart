// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs_lite.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mddblog/src/widgets/post/section-wrapper.dart';
import 'package:mddblog/utils/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareWith extends StatelessWidget {
  ShareWith({super.key});

  final List<Map<String, String>> assetIcons = [
    {"iconPath": "assets/svg/Fb.svg", "url": "https://facebook.com"},
    {"iconPath": "assets/svg/x.svg", "url": "https://x.com"},
    {"iconPath": "assets/svg/linkedin.svg", "url": "https://linkendin.com"},
  ];

  Future<void> _openUrl(BuildContext context, String url) async {
    try {
      await launch(url);
    } catch (e) {
      SnackbarNotification.showError(
        title: "Thất bại",
        "Không thể chia sẻ bài viết",
      );
    }
  }

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
          Row(
            children:
                assetIcons.map((icon) {
                  return GestureDetector(
                    onTap: () => _openUrl(context, icon['url']!),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: SvgPicture.asset(
                        icon['iconPath']!,
                        width: 24,
                        height: 24,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
