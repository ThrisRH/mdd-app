import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/models/faq-model.dart';
import 'package:mddblog/src/views/faq/faq.dart';

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
          children: [
            ListTile(
              title: Text(faq.question),
              trailing: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
              ),
              onTap: () => controller.toggleAnswer(index),
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Text(faq.answer),
              ),

            const Divider(height: 1),
          ],
        );
      },
    );
  }
}
