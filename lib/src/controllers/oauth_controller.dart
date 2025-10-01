// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:mddblog/src/controllers/auth_controller.dart';
import 'package:mddblog/src/services/secure_storage.dart';

class OauthController extends GetxController {
  var isLoading = false.obs;
  var signInUrl = ''.obs;
  var state = ''.obs;

  @override
  void onInit() {
    super.onInit();
    startAuthFlow();
  }

  Future<void> startAuthFlow() async {
    try {
      isLoading(true);

      signInUrl.value =
          "https://oversilently-calcinable-wilfredo.ngrok-free.dev";
    } catch (e) {
      Get.snackbar('Error', 'Failed to start auth: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> handleDeepLink(String link) async {
    if (link.startsWith('myapp://callback')) {
      final uri = Uri.parse(link);
      final token = uri.queryParameters['accessToken'];
      final userName = uri.queryParameters['name'];
      final userEmail = uri.queryParameters['email'];
      final imageUrl = uri.queryParameters['image'];

      print('token: $token');
      print('userName: $userName');
      print('userEmail: $userEmail');
      print('imageUrl: $imageUrl');

      if (token != null &&
          userName != null &&
          userEmail != null &&
          imageUrl != null) {
        try {
          await SecureStorage.saveTokensOAuth(
            token,
            "",
            userName,
            userEmail,
            imageUrl,
          );
          // Lưu token, idToken rỗng nếu chưa có

          Get.delete<OauthController>();
          Get.delete<AuthController>();
          Get.offNamed('/home');
        } catch (e) {
          Get.snackbar('Error', 'Failed to save token: $e');
        }
      } else {
        Get.snackbar('Error', 'Missing token in callback');
      }
    }
  }
}
