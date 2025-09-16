import 'package:flutter/material.dart';

class MDDNavbar extends StatelessWidget {
  final VoidCallback onMenuTap;
  final VoidCallback onSearchTap;
  const MDDNavbar({
    super.key,
    required this.onMenuTap,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            onPressed: onMenuTap,
            icon: Icon(Icons.menu, color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: onSearchTap,
              icon: Icon(Icons.search, color: Colors.white),
            ),
          ],
        ),
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 190,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  "assets/banner/banner.jpg",
                  fit: BoxFit.cover,
                ),
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
                  child: Image.asset(
                    "assets/icons/logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
