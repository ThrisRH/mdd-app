import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mddblog/app.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  Get.put(NavbarController());
  runApp(const App());
}
