import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget phoneBody;
  final Widget tabletBody;

  const ResponsiveLayout({
    super.key,
    required this.phoneBody,
    required this.tabletBody,
  });

  static bool isMobile(BuildContext ctx) => MediaQuery.of(ctx).size.width < 425;
  static bool isTablet(BuildContext ctx) =>
      MediaQuery.of(ctx).size.width >= 425;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 425) {
      return phoneBody;
    } else {
      return tabletBody;
    }
  }
}
