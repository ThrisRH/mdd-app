import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarNotification {
  static void showError(String message, {String title = 'Error'}) {
    _showSnackbar(title, message, icon: Icon(Icons.error_outline, color: Colors.redAccent));
  }

  static void showSuccess(String message, {String title = 'Success'}) {
    _showSnackbar(title, message, icon: Icon(Icons.check_circle_outline, color: Colors.greenAccent));
  }

  static void showInfo(String message, {String title = 'Info'}) {
    _showSnackbar(title, message, icon: Icon(Icons.info_outline, color: Colors.blueAccent));
  }

  static void _showSnackbar(String title, String message, {required Widget icon}) {
    // Đảm bảo gọi snackbar sau khi overlay sẵn sàng
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.isSnackbarOpen) Get.closeCurrentSnackbar(); // optional: đóng snackbar trước đó
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey[850]?.withOpacity(0.9),
        colorText: Colors.white,
        icon: icon,
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(16),
        borderRadius: 12,
      );
    });
  }
}
