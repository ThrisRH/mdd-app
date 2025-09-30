import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/models/auth_model.dart';
import 'package:mddblog/src/services/auth_service.dart';
import 'package:mddblog/theme/element/app_colors.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var isLoading = false.obs;
  var errorMessage = "".obs;

  // User detail
  final userDetail = Rxn<UserInfoResponse>();

  // Giá trị ô input
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  final AuthenticationService _authenticationService = AuthenticationService();
  final storage = const FlutterSecureStorage();
  @override
  void onInit() {
    super.onInit();
    _loadToken();
  }

  void _loadToken() async {
    final token = await loadJwt();
    isLoggedIn.value = token != null;
    if (token != null) {
      fetchUserDetail();
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
      final token = await loadJwt();
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

  // Hàm đăng ký
  Future<void> signUp() async {
    var username = usernameController.text.trim();
    var email = emailController.text.trim();
    var password = passwordController.text.trim();

    if (username == "" || email == "" || password == "") {
      errorMessage.value = "Không được để trống!";
      return;
    }
    final response = await _authenticationService.signUp(
      username,
      email,
      password,
    );
    if (!response) {
      errorMessage.value = "Tên đăng nhập hoặc email không phù hợp";
      return;
    }
    final token = await loadJwt();
    isLoggedIn.value = token != null;
    Get.snackbar(
      "Success",
      "Đăng ký thành công thành công",
      backgroundColor: AppColors.primary,
    );
    Get.offNamed("/login");
  }

  Future<void> logout() async {
    await removeJwt();
    await storage.delete(key: "accessToken");
    isLoggedIn.value = false;
    userDetail.value = null;

    Get.offNamed("/home");
  }

  void clearInput() {
    emailController.clear();
    passwordController.clear();
    usernameController.clear();
    errorMessage.value = "";
  }

  // Hàm fetch user detail
  Future<void> fetchUserDetail() async {
    isLoading.value = true;
    try {
      if (isLoggedIn.value) {
        final jwtToken = await loadJwt();
        if (jwtToken != null) {
          final response = await _authenticationService.getMe(jwtToken);
          userDetail.value = response;
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
