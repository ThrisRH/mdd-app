import 'package:get/get.dart';
import 'package:mddblog/controllers/auth-controller.dart';
import 'package:mddblog/controllers/author-controller.dart';
import 'package:mddblog/controllers/blog-by-cate-controller.dart';
import 'package:mddblog/controllers/blog-controller.dart';
import 'package:mddblog/middleware/auth-middleware.dart';
import 'package:mddblog/src/screens/about/index.dart';
import 'package:mddblog/src/screens/auth/google-oauth-view.dart';
import 'package:mddblog/src/screens/auth/register-view.dart';
import 'package:mddblog/src/screens/auth/sign-in-view.dart';
import 'package:mddblog/src/screens/author-info/index.dart';
import 'package:mddblog/src/screens/blog-details/index.dart';
import 'package:mddblog/src/screens/category/index.dart';
import 'package:mddblog/src/screens/faq/index.dart';
import 'package:mddblog/src/screens/home/index.dart';
import 'package:mddblog/src/screens/search/index.dart';

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
      // transitionDuration: Duration.zero,
    ),

    // Blog details
    GetPage(
      name: Routes.blogDetails,
      page: () => BlogDetailsPage(),
      binding: BindingsBuilder(() {
        Get.put(BlogDetailsController());
      }),
      middlewares: [AuthMiddleware()],
      // transitionDuration: Duration.zero,
    ),

    // Search blog
    GetPage(
      name: Routes.blogSearch,
      page: () => BlogBySearchQueryPage(),
      binding: BindingsBuilder(() {
        Get.put(BlogBySearchQueryController());
      }),
      transitionDuration: Duration.zero,
    ),

    // Author
    GetPage(
      name: Routes.author,
      page: () => AuthorInfoPage(),
      binding: BindingsBuilder(() {
        Get.put(AuthorController());
      }),
      // transitionDuration: Duration.zero,
    ),

    // About
    GetPage(
      name: Routes.about,
      page: () => About(),
      binding: BindingsBuilder(() {
        Get.put(AboutController());
      }),
      transitionDuration: Duration.zero,
    ),

    // FAQ
    GetPage(
      name: Routes.faq,
      page: () => FAQ(),
      binding: BindingsBuilder(() {
        Get.put(FaqController());
      }),
      transitionDuration: Duration.zero,
    ),

    // Category
    GetPage(
      name: Routes.category,
      page: () => Category(),
      binding: BindingsBuilder(() {
        Get.put(BlogByCateController());
      }),
      transitionDuration: Duration.zero,
    ),

    // Login
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      transitionDuration: Duration.zero,
    ),

    // Login with google
    GetPage(
      name: Routes.oauthGoogle,
      page: () => GoogleOauthView(),
      transitionDuration: Duration.zero,
    ),

    // Registers
    GetPage(
      name: Routes.register,
      page: () => RegisterPage(),
      transitionDuration: Duration.zero,
    ),
  ];
}
