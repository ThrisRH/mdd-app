import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MDDButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double? height;
  final double? fontSize;
  final double? radius;
  final Color? color;
  final Color? bgColor;
  final bool isDisabled;
  const MDDButton({
    super.key,
    required this.label,
    required this.onTap,
    this.height,
    this.fontSize,
    this.radius,
    this.color,
    this.bgColor = Colors.black,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,

      child: Container(
        width: double.infinity,
        height: height ?? 44,
        decoration: BoxDecoration(
          color: bgColor,

          borderRadius: BorderRadius.circular(radius ?? 8),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: color ?? Theme.of(context).colorScheme.onSurface,
              fontSize: fontSize ?? 20,
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const GoogleButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            SvgPicture.asset(
              "assets/svg/google.svg",
              width: 16,
              height: 16,
              // ignore: deprecated_member_use
              color: null,
              // ignore: deprecated_member_use
              colorBlendMode: BlendMode.srcIn,
            ),
            Text(label, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}

class RainbowButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double height;
  final double radius;
  final double fontSize;

  const RainbowButton({
    super.key,
    required this.label,
    required this.onTap,
    this.height = 50,
    this.radius = 12,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFFB3BA), // pastel đỏ
              Color(0xFFFFDFBA), // pastel cam
              Color(0xFFFFFBAA), // pastel vàng
              Color(0xFFBAFFC9), // pastel xanh lá
              Color(0xFFBAE1FF), // pastel xanh dương
              Color(0xFFE1BAFF), // pastel tím
              Color(0xFFFFBAF2), // pastel hồng tím
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.headlineMedium
                ?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 16,
                )
                .copyWith(
                  color: Colors.black,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black.withValues(alpha: 0.2),
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
