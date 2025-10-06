import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ErrorNotification extends StatelessWidget {
  const ErrorNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          SvgPicture.asset("assets/svg/NotFound.svg"),
          Text(
            "No results found",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley ",
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

class ErrorNotificationWithMessage extends StatelessWidget {
  final String errorMessage;
  const ErrorNotificationWithMessage({required this.errorMessage, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          SvgPicture.asset("assets/svg/NotFound.svg"),
          Text(
            errorMessage,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley ",
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
