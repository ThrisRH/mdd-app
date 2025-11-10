import 'package:get/get.dart';
import 'package:mddblog/controllers/auth-controller.dart';
import 'package:mddblog/controllers/author-controller.dart';
import 'package:mddblog/controllers/blog-by-cate-controller.dart';
import 'package:mddblog/controllers/blog-controller.dart';
import 'package:mddblog/middleware/auth-middleware.dart';
import 'package:mddblog/src/views/about/about.dart';
import 'package:mddblog/src/views/auth/google-oauth-view.dart';
import 'package:mddblog/src/views/auth/sign-in-view.dart';
import 'package:mddblog/src/views/author-info/author-info.dart';
import 'package:mddblog/src/views/auth/register-view.dart';
import 'package:mddblog/src/views/blog-details/blog-details.dart';
import 'package:mddblog/src/views/category/category.dart';
import 'package:mddblog/src/views/faq/faq.dart';
import 'package:mddblog/src/views/home/home.dart';
import 'package:mddblog/src/views/search/search.dart';

part 'app-routes.dart';

class AppPages {
  static const initial = Routes.home;

  static final pages = [
    // Home
    GetPage(
      name: Routes.home,
      page: () => Home(),
      binding: BindingsBuilder(() {
        Get.put(BlogController());
        Get.put(AuthController());
      }),
    ),

    // Blog details
    GetPage(
      name: Routes.blogDetails,
      page: () => BlogDetailsPage(),
      binding: BindingsBuilder(() {
        Get.put(BlogDetailsController());
      }),
      middlewares: [AuthMiddleware()],
    ),

    // Search blog
    GetPage(
      name: Routes.blogSearch,
      page: () => BlogBySearchQueryPage(),
      binding: BindingsBuilder(() {
        Get.put(BlogBySearchQueryController());
      }),
    ),

    // Author
    GetPage(
      name: Routes.author,
      page: () => AuthorInfoPage(),
      binding: BindingsBuilder(() {
        Get.put(AuthorController());
      }),
    ),

    // About
    GetPage(
      name: Routes.about,
      page: () => About(),
      binding: BindingsBuilder(() {
        Get.put(AboutController());
      }),
    ),

    // FAQ
    GetPage(
      name: Routes.faq,
      page: () => FAQ(),
      binding: BindingsBuilder(() {
        Get.put(FaqController());
      }),
    ),

    // Category
    GetPage(
      name: Routes.category,
      page: () => Category(),
      binding: BindingsBuilder(() {
        Get.put(BlogByCateController());
      }),
    ),

    // Login
    GetPage(name: Routes.login, page: () => LoginPage()),

    // Login with google
    GetPage(name: Routes.oauthGoogle, page: () => GoogleOauthView()),

    // Registers
    GetPage(name: Routes.register, page: () => RegisterPage()),
  ];
}
