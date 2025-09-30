import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/controllers/auth_controller.dart';
import 'package:mddblog/theme/controller/theme_controller.dart';
import 'package:mddblog/src/middleware/auth_middleware.dart';
import 'package:mddblog/src/controllers/author_controller.dart';
import 'package:mddblog/src/controllers/blog_by_cate_controller.dart';
import 'package:mddblog/src/controllers/blog_controller.dart';
import 'package:mddblog/src/routes/app_pages.dart';
import 'package:mddblog/src/views/about/about.dart';
import 'package:mddblog/src/views/author_info/author_info.dart';
import 'package:mddblog/src/views/auth/register_view.dart';
import 'package:mddblog/src/views/auth/sign_in_view.dart';
import 'package:mddblog/src/views/blog_details/blog_details.dart';
import 'package:mddblog/src/views/category/category.dart';
import 'package:mddblog/src/views/faq/faq.dart';
import 'package:mddblog/src/views/home/home.dart';
import 'package:mddblog/src/views/search/search.dart';
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
