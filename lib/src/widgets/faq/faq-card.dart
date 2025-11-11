import 'package:flutter/material.dart';
import 'package:mddblog/theme/element/app-colors.dart';

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
      padding: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      child: Column(
        spacing: 12,
        children: [
          GestureDetector(
            onTap: toggleAnswer,
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: Text(
                    question, // luôn là vị trí đầu tiên
                    style:
                        isSelected
                            ? Theme.of(
                              context,
                            ).textTheme.headlineMedium?.copyWith(
                              color: AppColors.secondary,
                              fontSize: 18,
                            )
                            : Theme.of(
                              context,
                            ).textTheme.headlineMedium?.copyWith(fontSize: 18),
                    softWrap: true, // named parameter
                  ),
                ),
                Icon(isSelected ? Icons.remove : Icons.add),
              ],
            ),
          ),

          if (isSelected)
            SizedBox(
              width: double.infinity,
              child: Text(
                answer,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
        ],
      ),
    );
  }
}
