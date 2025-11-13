import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mddblog/controllers/auth-controller.dart';

class AppLifeCycleController extends GetxController
    with WidgetsBindingObserver {
  final Duration timeout = const Duration(seconds: 10);
  Timer? logoutTimer;
  final storage = const FlutterSecureStorage();
  static const pauseKey = 'app_pause_timestamp';

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    checkOnStartup();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    logoutTimer?.cancel();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App vào background — bắt đầu đếm ngược
      onPaused();
    } else if (state == AppLifecycleState.resumed) {
      // App trở lại foreground — hủy timer và kiểm tra thời gian đã trôi qua
      onResumed();
    }
    // Không làm gì ở `inactive` (transient) để tránh logout vì notification/phone-call
  }

  void onPaused() {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;
    storage.write(key: pauseKey, value: now.toString());
    // Bắt một timer để logout nếu app không resume trong timeout
    logoutTimer?.cancel();
    logoutTimer = Timer(timeout, () async {
      await _performLogout();
    });
  }

  void logoutUser() {
    final authController = Get.find<AuthController>();
    authController.logout();
  }

  Future<void> onResumed() async {
    logoutTimer?.cancel();
    // Kiểm tra persisted timestamp để xử lý trường hợp app bị kill trong background
    final tsString = await storage.read(key: pauseKey);
    if (tsString == null) {
      // không có timestamp => không cần logout
      return;
    }

    final pausedAt = DateTime.fromMillisecondsSinceEpoch(
      int.parse(tsString),
      isUtc: true,
    );
    final elapsed = DateTime.now().toUtc().difference(pausedAt);

    // Nếu quá timeout thì logout, ngược lại giữ trạng thái login
    if (elapsed >= timeout) {
      await _performLogout();
    } else {
      // xóa timestamp nếu chưa quá timeout
      await storage.delete(key: pauseKey);
    }
  }

  Future<void> checkOnStartup() async {
    // Gọi khi controller khởi tạo: kiểm tra nếu app được mở lại từ kill state
    final tsString = await storage.read(key: pauseKey);
    if (tsString == null) return;
    final pausedAt = DateTime.fromMillisecondsSinceEpoch(
      int.parse(tsString),
      isUtc: true,
    );
    final elapsed = DateTime.now().toUtc().difference(pausedAt);
    if (elapsed >= timeout) {
      await _performLogout();
    } else {
      // nếu chưa quá timeout, xóa timestamp để không xử lý lại
      await storage.delete(key: pauseKey);
    }
  }

  Future<void> _performLogout() async {
    // Hủy timer
    logoutTimer?.cancel();
    // Xóa timestamp
    await storage.delete(key: pauseKey);
    // Logount
    try {
      if (Get.isRegistered<AuthController>()) {
        final authController = Get.find<AuthController>();
        await authController.logout();
      } else {
        await storage.delete(key: 'access_token');
        await storage.delete(key: 'refresh_token');
      }
      // ignore: empty_catches
    } catch (e) {}
  }
}
