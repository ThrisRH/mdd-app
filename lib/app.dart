import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/controllers/oauth_controller.dart';
import 'package:mddblog/theme/controller/theme_controller.dart';
import 'package:mddblog/src/routes/app_pages.dart';
import 'package:mddblog/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      themeMode:
          Get.put(ThemeController()).isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,
      initialRoute: '/home',
      getPages: AppPages.pages,
      initialBinding: BindingsBuilder(() {
        // Khởi tạo các controller
        Get.put(ThemeController());
        Get.put(OauthController());
        // Khởi tạo deep link
        _initDeepLinks();
      }),
    );
  }

  void _initDeepLinks() {
    final authController = Get.find<OauthController>();
    final appLinks = AppLinks();

    // Xử lý deep link khi app mở
    appLinks.getInitialLink().then((Uri? uri) {
      if (uri != null) {
        authController.handleDeepLink(uri.toString());
      }
    });

    // Lắng nghe deep link khi app đang chạy
    appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        authController.handleDeepLink(uri.toString());
      }
    });
  }
}
