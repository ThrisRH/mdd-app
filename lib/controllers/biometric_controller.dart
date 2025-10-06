import 'package:get/get.dart';
import 'package:mddblog/src/widgets/main/auth_popup.dart';
import '../services/biometric_auth_service.dart';
import '../services/secure_storage.dart';

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
        Get.snackbar("Thất bại", "Xác thực tài khoản không thành công");
        return;
      }
      final ok = await biometricService.authenticate();
      if (ok) {
        biometricEnabled.value = true;
        await SecureStorage.setBiometricEnabled(true);
        Get.snackbar("Thành công", "Đã bật đăng nhập bằng vân tay");
      } else {
        Get.snackbar("Thất bại", "Xác thực vân tay không thành công");
      }
    } else {
      biometricEnabled.value = false;
      await SecureStorage.setBiometricEnabled(false);
      Get.snackbar("Đã tắt", "Đã tắt đăng nhập bằng vân tay");
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
