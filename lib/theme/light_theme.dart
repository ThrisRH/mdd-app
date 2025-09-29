import 'package:flutter/material.dart';
import 'package:mddblog/theme/element/text_theme.dart';

// ignore: non_constant_identifier_names
ThemeData LightThemeData() {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: CustomTextTheme.textThemeLight,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
      ),
    ),
  );
}
