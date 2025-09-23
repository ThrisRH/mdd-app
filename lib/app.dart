import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/controllers/author_controller.dart';
import 'package:mddblog/src/views/about/about.dart';
import 'package:mddblog/src/views/auhor_info/author_info.dart';
import 'package:mddblog/src/views/auth/sign_in_view.dart';
import 'package:mddblog/src/views/blog_details/blog_details.dart';
import 'package:mddblog/src/views/category/category.dart';
import 'package:mddblog/src/views/faq/faq.dart';
import 'package:mddblog/src/views/home/home.dart';
import 'package:mddblog/src/views/search/search.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      getPages: [
        GetPage(
          name: '/home',
          page: () => Home(),
          binding: BindingsBuilder(() {
            Get.put(BlogController());
          }),
        ),
        GetPage(
          name: '/home/:slug',
          page: () => BlogDetailsPage(),
          binding: BindingsBuilder(() {
            Get.put(BlogDetailsController());
          }),
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

        GetPage(name: '/auth', page: () => AuthPage()),
      ],
    );
  }
}
