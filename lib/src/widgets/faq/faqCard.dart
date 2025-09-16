import 'package:flutter/material.dart';
import 'package:mddblog/theme/app_colors.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class FAQCard extends StatelessWidget {
  final String question;
  final String answer;
  final VoidCallback toggleAnswer;
  final bool isSelected;

  const FAQCard({
    super.key,
    required this.question,
    required this.answer,
    required this.toggleAnswer,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  question, // luôn là vị trí đầu tiên
                  style: AppTextStyles.h2.copyWith(
                    color: isSelected ? AppColors.secondary : Colors.black,
                  ),
                  softWrap: true, // named parameter
                ),
              ),
              GestureDetector(
                onTap: toggleAnswer,
                child: Icon(isSelected ? Icons.remove : Icons.add),
              ),
            ],
          ),
          SizedBox(height: 16),
          if (isSelected)
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 16),
              child: Text(
                answer,
                style: AppTextStyles.body2.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
