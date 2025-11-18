import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/models/faq-model.dart';
import 'package:mddblog/src/views/faq/faq.dart';
import 'package:mddblog/theme/element/app-colors.dart';

class FAQItems extends GetWidget<FaqController> {
  final QuestionAnswer faq;
  final int index;
  const FAQItems({super.key, required this.faq, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FaqController>(
      id: "faq-$index",
      builder: (controller) {
        final isExpanded = controller.selectedIndex.value == index;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                faq.question,
                style: TextStyle(
                  color: isExpanded ? AppColors.secondary : Colors.black,
                  fontWeight: isExpanded ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
              trailing: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.black,
              ),
              onTap: () => controller.toggleAnswer(index),
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Text(
                  faq.answer,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black),
                ),
              ),

            const Divider(height: 1),
          ],
        );
      },
    );
  }
}
