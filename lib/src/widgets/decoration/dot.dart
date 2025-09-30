import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class Dot extends GetWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade500
                : Colors.grey.shade600,
      ),
    );
  }
}
