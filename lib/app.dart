import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/controllers/auth_controller.dart';
import 'package:mddblog/src/controllers/theme_controller.dart';
import 'package:mddblog/src/middleware/auth_middleware.dart';
import 'package:mddblog/src/controllers/author_controller.dart';
import 'package:mddblog/src/controllers/blog_by_cate_controller.dart';
import 'package:mddblog/src/controllers/blog_controller.dart';
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

class App extends StatelessWidget {
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
        getPages: [
          GetPage(
            name: '/home',
            page: () => Home(),
            binding: BindingsBuilder(() {
              Get.put(BlogController());
              Get.put(AuthController());
            }),
          ),
          GetPage(
            name: '/home/:slug',
            page: () => BlogDetailsPage(),
            binding: BindingsBuilder(() {
              Get.put(BlogDetailsController());
            }),
            middlewares: [AuthMiddleware()],
          ),
          GetPage(
            name: '/home/search/:query',
            page: () => BlogBySearchQueryPage(),
            binding: BindingsBuilder(() {
              Get.put(BlogBySearchQueryController());
            }),
          ),
          GetPage(
            name: '/author',
            page: () => AuthorInfoPage(),
            binding: BindingsBuilder(() {
              Get.put(AuthorController());
            }),
          ),
          GetPage(
            name: '/about',
            page: () => About(),
            binding: BindingsBuilder(() {
              Get.put(AboutController());
            }),
          ),
          GetPage(
            name: '/faq',
            page: () => FAQ(),
            binding: BindingsBuilder(() {
              Get.put(FaqController());
            }),
          ),
          GetPage(
            name: '/topics/:id',
            page: () => Category(),
            binding: BindingsBuilder(() {
              Get.put(BlogByCateController());
            }),
          ),

          GetPage(name: '/login', page: () => LoginPage()),
          GetPage(name: '/register', page: () => RegisterPage()),
        ],
      ),
    );
  }
}
