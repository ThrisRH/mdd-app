import 'package:get/get.dart';
import 'package:mddblog/src/widgets/main/auth-popup.dart';
import 'package:mddblog/utils/toast.dart';
import '../services/biometric-auth-service.dart';
import '../services/secure-storage.dart';

class BiometricController extends GetxController {
  final BiometricAuthService biometricService = BiometricAuthService();
  var biometricEnabled = false.obs;
  var isAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    biometricEnabled.value = await SecureStorage.getBiometricEnabled();
  }

  Future<void> toggleBiometric(bool enable) async {
    if (enable) {
      // Đăng nhập lại trước khi bật
      final reloginOk = await showReloginDialog();
      if (!reloginOk) {
        SnackbarNotification.showError(
          title: "Thất bại",
          "Xác thực tài khoản không thành công",
        );
        return;
      }
      final ok = await biometricService.authenticate();
      if (ok) {
        biometricEnabled.value = true;
        await SecureStorage.setBiometricEnabled(true);
        SnackbarNotification.showSuccess(
          title: "Đã bật",
          "Đã bật đăng nhập bằng vân tay",
        );
      } else {
        SnackbarNotification.showError(
          title: "Thất bại",
          "Thiết bị không hỗ trợ đăng nhập vân tay",
        );
      }
    } else {
      biometricEnabled.value = false;
      await SecureStorage.setBiometricEnabled(false);
      SnackbarNotification.showSuccess(
        title: "Đã tắt",
        "Đã tắt đăng nhập bằng vân tay",
      );
    }
  }

  Future<bool> tryBiometricLogin() async {
    if (!biometricEnabled.value) return false;
    final ok = await biometricService.authenticate();
    if (ok) {
      isAuthenticated.value = await biometricService.loginWithRefreshToken();
    }
    return isAuthenticated.value;
  }
}
