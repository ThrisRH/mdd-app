import 'package:flutter/material.dart';
import 'package:mddblog/theme/app_colors.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class MDDButton extends StatelessWidget {
  final bool isPrimary;
  final String label;
  final VoidCallback onTap;
  const MDDButton({
    super.key,
    required this.isPrimary,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),

      child: Container(
        width: double.infinity,
        height: 44,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : AppColors.secondary,

          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.h3.copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
