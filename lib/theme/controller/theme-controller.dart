import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/theme/light-theme.dart';
import 'package:mddblog/theme/dark-theme.dart';

class ThemeController extends GetxController {
  // Theme hiện tại
  var isDarkMode = false.obs;

  ThemeData get theme => isDarkMode.value ? DarkThemeData() : LightThemeData();

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    // Update toàn bộ app
    Get.changeTheme(isDarkMode.value ? DarkThemeData() : LightThemeData());
  }
}
