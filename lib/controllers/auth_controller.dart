// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mddblog/models/auth_model.dart';
import 'package:mddblog/services/auth_service.dart';
import 'package:mddblog/services/biometric_auth_service.dart';
import 'package:mddblog/services/secure_storage.dart';
import 'package:mddblog/theme/element/app_colors.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var isLoading = false.obs;
  var errorMessage = "".obs;
  var biometricEnabled = false.obs;
  final BiometricAuthService biometricService = BiometricAuthService();
  // User detail
  final userDetail = Rxn<UserInfoResponse>();

  // Giá trị ô input
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthenticationService _authenticationService = AuthenticationService();
  final storage = const FlutterSecureStorage();
  @override
  void onInit() {
    super.onInit();
    _initAuth();
  }

  Future<void> _initAuth() async {
    await _loadToken();
    if (!isLoggedIn.value) {
      await checkBiometricLogin();
    }
  }

  Future<void> checkBiometricLogin() async {
    if (!isLoggedIn.value) {
      final hasRefresh = await SecureStorage.getRefreshToken() != null;
      if (!hasRefresh) return;

      final isAuth = await biometricService.authenticate();
      if (!isAuth) return;

      isLoading.value = true;
      final success = await biometricService.loginWithRefreshToken();
      isLoading.value = false;

      if (success) {
        Get.delete<AuthController>();
        Get.offAllNamed("/home");
      } else {
        print("❌ Biometric login thất bại, yêu cầu login lại");
      }
    }
  }

  Future<void> _loadToken() async {
    if (await SecureStorage.hasToken()) {
      isLoggedIn.value = true;
      print("SignedIn oAuth");
      final jwtToken = await SecureStorage.getTokens();
      final accessToken = jwtToken['access_token'];

      isLoggedIn.value = accessToken != null;
      if (accessToken != null) {
        fetchUserDetail();
      }
    } else {
      print("UnSignedIn");
    }
  }

  // Hàm đăng nhập
  Future<void> signIn() async {
    isLoading.value = true;
    try {
      // id = identifier
      if (emailController.text.trim() == "" ||
          passwordController.text.trim() == "") {
        errorMessage.value = "Không được để trống!";
        return;
      }

      final response = await _authenticationService.signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      if (!response) {
        errorMessage.value = "Tên đăng nhập hoặc mật khẩu không đúng!";
        return;
      }
      final token = await SecureStorage.getTokens();
      isLoggedIn.value = token != null;

      Get.snackbar(
        "Success",
        "Login thành công",
        backgroundColor: AppColors.primary,
      );
      Get.delete<AuthController>();
      Get.offNamed("/home");
    } finally {
      isLoading.value = false;
    }
  }

  // Đăng xuất
  Future<void> logout() async {
    await SecureStorage.clearTokens();
    isLoggedIn.value = false;
    userDetail.value = null;

    Get.offNamed("/home");
  }

  // Clear input
  void clearInput() {
    emailController.clear();
    passwordController.clear();
    errorMessage.value = "";
  }

  // Hàm fetch user detail
  Future<void> fetchUserDetail() async {
    isLoading.value = true;
    try {
      if (isLoggedIn.value) {
        final jwtToken = await SecureStorage.getTokens();
        final accessToken = jwtToken['access_token'];
        final accountType = jwtToken['account_type'];
        print("accessToken: $accessToken");

        if (accessToken != null && accessToken.isNotEmpty) {
          if (accountType == "Strapi") {
            final response = await _authenticationService.getMe(accessToken);
            userDetail.value = response;
            print(userDetail.value);
          } else {
            final name = jwtToken['user_name'];
            final email = jwtToken['user_email'];
            final imageUrl = jwtToken['image_url'];

            userDetail.value ??= UserInfoResponse(
              username: '',
              email: email.toString(),
              userDetailInfo: UserDetailInfo(
                documentId: "",
                fullname: name.toString(),
                avatarUrl: imageUrl.toString(),
              ),
            );
          }
        } else {
          userDetail.value = null; // chưa login
          print(userDetail.value);
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Routing
  void toRegister() {
    Get.delete<AuthController>();
    Get.toNamed("/register");
  }

  void toSignIn() {
    Get.delete<AuthController>();
    Get.toNamed("/login");
  }
}
