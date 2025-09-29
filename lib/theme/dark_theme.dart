import 'package:flutter/material.dart';

import 'element/text_theme.dart';

// ignore: non_constant_identifier_names
ThemeData DarkThemeData() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF1C1C1C),
    textTheme: CustomTextTheme.textThemeDark,

    appBarTheme: const AppBarTheme(centerTitle: true),
    useMaterial3: false,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
      ),
    ),
  );
}
