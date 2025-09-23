import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mddblog/src/config/constants.dart';
import 'package:mddblog/src/models/author_model.dart';
import 'package:mddblog/theme/app_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoCard extends StatelessWidget {
  final AuthorInfo data;
  const InfoCard({super.key, required this.data});

  Future<void> _launchUrl(String url) async {
    if (!url.startsWith("http")) {
      url = "https://$url";
    }

    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget contactIcon(String platform, String url) {
    switch (platform) {
      case "fb":
        return Row(
          children: [
            GestureDetector(
              onTap: () => _launchUrl(url),
              child: SvgPicture.asset(
                "assets/svg/Fb.svg",
                width: 24,
                height: 24,
              ),
            ),
          ],
        );
      case "ig":
        return Row(
          children: [
            GestureDetector(
              onTap: () => _launchUrl(url),
              child: SvgPicture.asset(
                "assets/svg/Ig.svg",
                width: 24,
                height: 24,
              ),
            ),
          ],
        );
      case "x":
        return Row(
          children: [
            GestureDetector(
              onTap: () => _launchUrl(url),
              child: SvgPicture.asset(
                "assets/svg/x.svg",
                width: 24,
                height: 24,
              ),
            ),
          ],
        );
      case "linkedin":
        return Row(
          children: [
            GestureDetector(
              onTap: () => _launchUrl(url),
              child: SvgPicture.asset(
                "assets/svg/linkedin.svg",
                width: 24,
                height: 24,
              ),
            ),
          ],
        );
      default:
        return Text("Unknown");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          SizedBox(
            width: 220,
            height: 220,
            child: ClipOval(
              child: Image.network(
                "$baseUrlNoUrl${data.authorAvatar.url}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text('my ${data.fullname} diary', style: AppTextStyles.h2),
          Text(
            data.authorHobbies.map((item) => item.interest).join(", "),
            style: AppTextStyles.body3,
          ),
          Text(
            data.biography,
            style: AppTextStyles.body3,
            textAlign: TextAlign.center,
          ),
          Row(
            spacing: 14,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...data.contactSocialMedia.map(
                (e) => contactIcon(e.platform, e.url),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
