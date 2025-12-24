import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mddblog/app.dart';
import 'package:mddblog/controllers/app-life_cycle-controller.dart';
import 'package:mddblog/controllers/auth-controller.dart';
import 'package:mddblog/controllers/overlay-controller.dart';
import 'package:mddblog/services/notification-service.dart';
import 'package:mddblog/theme/controller/theme-controller.dart';
import 'package:mddblog/services/deep-link-service.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('🔔 Handling a background message: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const env = String.fromEnvironment('FLAVOR', defaultValue: 'development');
  await dotenv.load(fileName: ".env.$env");

  await Firebase.initializeApp();

  String? token = await FirebaseMessaging.instance.getToken();
  print('FCM Token: $token');

  await NotificationService.initialize();

  // Controllers
  Get.put(OverlayController());
  Get.put(NavbarController());
  Get.put(AuthController());
  Get.put(ThemeController());
  await DeepLinkHandler().initDeepLinks();
  Get.put(AppLifeCycleController());

  try {
    await Firebase.initializeApp();
    print(  '✅ Firebase initialized successfully');
  } catch (e) {
    print('❌ Firebase initialization error: $e');
  }

  runApp(const App());
}
