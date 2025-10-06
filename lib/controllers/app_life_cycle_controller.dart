import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mddblog/controllers/auth_controller.dart';

class AppLifeCycleController extends GetxController
    with WidgetsBindingObserver {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive) {
      logoutUser();
    }
  }

  void logoutUser() {
    final authController = Get.find<AuthController>();
    authController.logout();
  }
}
