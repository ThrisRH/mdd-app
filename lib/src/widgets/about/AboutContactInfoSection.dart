import 'package:flutter/material.dart';
import 'package:mddblog/src/models/about_model.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class AboutContactInfoSection extends StatelessWidget {
  final List<ContactInfo> contacts;
  const AboutContactInfoSection({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          'Liên hệ qua: ',
          style: AppTextStyles.body1.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ...contacts.map((contact) => Text(contact.content)),
      ],
    );
  }
}
