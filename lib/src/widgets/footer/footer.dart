import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      width: double.infinity,
      height: 46,
      decoration: BoxDecoration(
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Color(0xFFF4F4F4),
      ),
      child: Center(
        child: Text(
          "Copyright © 2024 My MDD Diary",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 15),
        ),
      ),
    );
  }
}
