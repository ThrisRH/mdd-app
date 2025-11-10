import 'package:flutter/material.dart';

class AboutAvatarContainer extends StatelessWidget {
  final String imageUrl;
  const AboutAvatarContainer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 172,
      height: 172,
      child: ClipOval(child: Image.network(imageUrl, fit: BoxFit.cover)),
    );
  }
}
