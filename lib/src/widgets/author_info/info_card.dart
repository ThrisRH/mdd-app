import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mddblog/src/config/constants.dart';
import 'package:mddblog/src/models/author_model.dart';
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

  Widget contactIcon(String platform, String url, BuildContext context) {
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
                color: Theme.of(context).colorScheme.onSurface,
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
                color: Theme.of(context).colorScheme.onSurface,
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
                color: Theme.of(context).colorScheme.onSurface,
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
                color: Theme.of(context).colorScheme.onSurface,
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
          Text(
            'my ${data.fullname} diary',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontSize: 22),
          ),
          Text(
            data.authorHobbies.map((item) => item.interest).join(", "),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            data.biography,
            style: Theme.of(context).textTheme.bodySmall,

            textAlign: TextAlign.center,
          ),
          Row(
            spacing: 14,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...data.contactSocialMedia.map(
                (e) => contactIcon(e.platform, e.url, context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
