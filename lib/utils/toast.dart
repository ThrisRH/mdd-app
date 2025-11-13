import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarNotification {
  static void showError(String message, {String title = 'Error'}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey[850]?.withOpacity(0.9),
      colorText: Colors.white,
      icon: Icon(Icons.error_outline, color: Colors.redAccent),
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  static void showSuccess(String message, {String title = 'Success'}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey[850]?.withOpacity(0.9),
      colorText: Colors.white,
      icon: Icon(Icons.check_circle_outline, color: Colors.greenAccent),
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  static void showInfo(String message, {String title = 'Info'}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey[850]?.withOpacity(0.9),
      colorText: Colors.white,
      icon: Icon(Icons.info_outline, color: Colors.blueAccent),
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
