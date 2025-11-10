import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mddblog/theme/element/app-colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 300,
      child: SpinKitThreeInOut(
        color: AppColors.secondary,
        size: 50.0,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
