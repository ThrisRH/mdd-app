import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth_android/local_auth_android.dart';
import 'package:mddblog/config/constants.dart';
import 'dart:convert';
import 'secure-storage.dart';

class BiometricAuthService {
  final LocalAuthentication auth = LocalAuthentication();

  // Kiểm tra thiết bị có hỗ trợ vân tay hay không
  Future<bool> isAvailable() async {
    try {
      final canCheck = await auth.canCheckBiometrics;
      final isSupported = await auth.isDeviceSupported();
      return canCheck && isSupported;
    } catch (e) {
      return false;
    }
  }

  // Gọi xác thực sinh trắc học
  Future<bool> authenticate() async {
    try {
      final isAvailableDevice = await isAvailable();
      if (!isAvailableDevice) {
        return false;
      }

      final didAuthenticate = await auth.authenticate(
        localizedReason: 'Xác thực bằng vân tay để tiếp tục',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Đăng nhập bằng dấu vân tay',
            cancelButton: 'Huỷ',
          ),
        ],
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          sensitiveTransaction: false,
        ),
      );
      return didAuthenticate;
    } catch (error) {
      return false;
    }
  }

  // Tự động đăng nhập bằng refresh token
  Future<bool> loginWithRefreshToken() async {
    final refreshToken = await SecureStorage.getRefreshToken();
    if (refreshToken == null) {
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/local/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body);
        await SecureStorage.saveStrapiToken(data['jwt'], data['refreshToken']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
