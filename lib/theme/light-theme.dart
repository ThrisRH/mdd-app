import 'package:flutter/material.dart';
import 'package:mddblog/theme/element/text-theme.dart';

// ignore: non_constant_identifier_names
ThemeData LightThemeData() {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: CustomTextTheme.textThemeLight,

    useMaterial3: false,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
      ),
    ),
  );
}
