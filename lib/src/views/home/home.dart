// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showOverlay = false;

  void toggleOverlay() {
    print("toggle");
    setState(() {
      showOverlay = !showOverlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          // Navbar
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(246),
            child: MDDNavbar(onMenuTap: toggleOverlay, onSearchTap: () {}),
          ),
          body: Center(child: Text("Hello World")),
        ),

        // Show ra Overlay nav điều hướng khi showOverlay === true
        if (showOverlay) OverlayToggle(closeOverlay: toggleOverlay),
      ],
    );
  }
}
