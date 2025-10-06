import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mddblog/app.dart';
import 'package:mddblog/controllers/app_life_cycle_controller.dart';
import 'package:mddblog/controllers/auth_controller.dart';
import 'package:mddblog/theme/controller/theme_controller.dart';
import 'package:mddblog/services/deep_link_service.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';

Future<void> main() async {
  const env = String.fromEnvironment('FLAVOR', defaultValue: 'development');

  await dotenv.load(fileName: ".env.$env");

  Get.put(NavbarController());
  Get.put(AuthController());
  Get.put(ThemeController());
  await DeepLinkHandler().initDeepLinks();
  Get.put(AppLifeCycleController());
  runApp(const App());
}
