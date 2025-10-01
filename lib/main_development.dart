import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mddblog/app.dart';
import 'package:mddblog/src/controllers/auth_controller.dart';
import 'package:mddblog/theme/controller/theme_controller.dart';
import 'package:mddblog/src/services/deep_link_service.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  Get.put(NavbarController());
  Get.put(AuthController());
  Get.put(ThemeController());
  await DeepLinkHandler().initDeepLinks();
  runApp(const App());
}
