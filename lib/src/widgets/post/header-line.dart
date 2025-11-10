import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderLine extends StatelessWidget {
  final Widget child;
  const HeaderLine({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 4,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior:
                Clip.none, // Cho phép tràn viền, => SVG right -10 sẽ không bị cắt mất
            children: [
              Divider(
                thickness: 2,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              Positioned(
                right: -10,
                child: SvgPicture.asset(
                  "assets/svg/VectorArrow.svg",
                  // ignore: deprecated_member_use
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        Spacer(flex: 1),
        child,
        Spacer(flex: 1),
        Flexible(
          flex: 4,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior:
                Clip.none, // Cho phép tràn viền, => SVG right -10 sẽ không bị cắt mất
            children: [
              Divider(
                thickness: 2,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              Positioned(
                left: -10,
                child: RotatedBox(
                  quarterTurns: 2,
                  child: SvgPicture.asset(
                    "assets/svg/VectorArrow.svg",
                    // ignore: deprecated_member_use
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
