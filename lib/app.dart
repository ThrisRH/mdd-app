import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/views/about/about.dart';
import 'package:mddblog/src/views/category/category.dart';
import 'package:mddblog/src/views/faq/faq.dart';
import 'package:mddblog/src/views/home/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
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
      ],
    );
  }
}
