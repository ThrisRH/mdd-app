import 'package:flutter/material.dart';
import 'package:mddblog/models/about-model.dart';

class AboutContactInfoSection extends StatelessWidget {
  final List<ContactInfo> contacts;
  const AboutContactInfoSection({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          child: Text(
            'Liên hệ qua: ',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        ...contacts.map(
          (contact) => Text(
            contact.content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
