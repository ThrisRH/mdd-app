import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mddblog/app.dart';
import 'package:mddblog/controllers/app-life_cycle-controller.dart';
import 'package:mddblog/controllers/auth-controller.dart';
import 'package:mddblog/controllers/overlay-controller.dart';
import 'package:mddblog/theme/controller/theme-controller.dart';
import 'package:mddblog/services/deep-link-service.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';

Future<void> main() async {
  const env = String.fromEnvironment('FLAVOR', defaultValue: 'development');

  await dotenv.load(fileName: ".env.$env");

  Get.put(OverlayController());
  Get.put(NavbarController());
  Get.put(AuthController());
  Get.put(ThemeController());
  await DeepLinkHandler().initDeepLinks();
  Get.put(AppLifeCycleController());
  runApp(const App());
}
