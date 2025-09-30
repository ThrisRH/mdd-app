import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/theme/controller/theme_controller.dart';
import 'package:mddblog/src/routes/app_pages.dart';
import 'package:mddblog/theme/theme.dart';

class App extends GetWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(
      () => GetMaterialApp(
        theme: CustomTheme.lightTheme,
        darkTheme: CustomTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        initialRoute: '/home',
        getPages: AppPages.pages,
      ),
    );
  }
}
