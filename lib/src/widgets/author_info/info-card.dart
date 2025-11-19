import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mddblog/config/api.dart';
import 'package:mddblog/models/author-model.dart';
import 'package:mddblog/src/widgets/post/image-skeleton.dart';
import 'package:mddblog/utils/env.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoCard extends StatelessWidget {
  final AuthorInfo data;
  InfoCard({super.key, required this.data});

  final Map<String, String> socialIcons = {
    "Facebook": "assets/svg/Fb.svg",
    "Instagram": "assets/svg/Ig.svg",
    "X": "assets/svg/x.svg",
    "LinkedIn": "assets/svg/linkedin.svg",
    "Github": "assets/svg/github.svg",
    "Youtube": "assets/svg/youtube.svg",
  };

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
    final iconPath = socialIcons[platform];

    if (iconPath == null) return const SizedBox();

    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: SvgPicture.asset(
        iconPath,
        width: 24,
        height: 24,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
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
              child: CachedNetworkImage(
                imageUrl:
                    Env.isDev
                        ? "$baseUrlNoUrl${data.authorAvatar.url}"
                        : data.authorAvatar.url,
                placeholder: (context, url) => ImageSkeleton(),
                errorWidget: (context, url, error) => Icon(Icons.error),
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
