import 'package:flutter/material.dart';

class CustomTextTheme {
  static const _textColorLight = Color(
    0xFF000000,
  ); // Light Theme Default Text Color
  static const _textColorDark = Color(
    0xFFFFFFFF,
  ); // Light Theme Default Text Color

  static TextTheme get textThemeLight {
    return _textTheme(textColor: _textColorLight);
  }

  static TextTheme get textThemeDark {
    return _textTheme(textColor: _textColorDark);
  }

  // Private Method For Text Theme so that we can change the vale for Both Dark And Light Theme
  static TextTheme _textTheme({required Color textColor}) {
    return TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lora',
        color: textColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lora',
        color: textColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lora',
        color: textColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
        color: textColor,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
        color: textColor,
      ),
    );
  }
}
