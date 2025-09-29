import 'package:flutter/material.dart';

class SectionWrapper extends StatelessWidget {
  final Widget child;
  const SectionWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Divider(
              height: 1,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
