import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mddblog/services/auth-service.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = "".obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final fullnameController = TextEditingController();

  final _picker = ImagePicker();

  var selectedImage = Rxn<File>();
  var uploadedImageUrl = RxnString();

  final AuthenticationService authenticationService = AuthenticationService();

  // Hàm đăng ký
  Future<void> signUp() async {
    try {
      isLoading.value = true;
      var username = usernameController.text.trim();
      var email = emailController.text.trim();
      var password = passwordController.text.trim();
      var fullname = fullnameController.text.trim();

      if (username == "" || email == "" || password == "") {
        errorMessage.value = "Không được để trống!";
        return;
      }

      final passwordError = validatePassword(password);
      if (passwordError != null) {
        errorMessage.value = passwordError;
        return;
      }

      final url = await authenticationService.uploadToCloudinary(
        selectedImage.value!,
      );
      if (url != null) {
        uploadedImageUrl.value = url;
      } else {
        errorMessage.value = "Upload thất bại";
        return;
      }

      final response = await authenticationService.signUp(
        username: username,
        fullname: fullname,
        password: password,
        email: email,
        avatarUrl: uploadedImageUrl.value!,
      );

      if (!response['success']) {
        final error = response['error'];
        switch (error) {
          case "email must be a valid email":
            errorMessage.value = "Email không hợp lệ";
            break;
          case "Email or Username are already taken":
            errorMessage.value = "Email hoặc username đã tồn tại";
            break;
        }
        return;
      }

      Get.snackbar("Success", "Đăng ký thành công thành công");

      Get.delete<RegisterController>();
      Get.offNamed("/login");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> requestGalleryPermission() async {
    PermissionStatus status;

    status = await Permission.photos.request();

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    }
    return false;
  }

  // Chọn ảnh
  Future<void> pickImageFromGallery() async {
    bool hasPermission = await requestGalleryPermission();
    if (!hasPermission) return;
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  // Clear input
  void clearInput() {
    emailController.clear();
    passwordController.clear();
    errorMessage.value = "";
    selectedImage.value = null;
  }

  // Hàm valid password
  String? validatePassword(String password) {
    if (password.length < 8) {
      return "Mật khẩu phải có ít nhất 8 ký tự";
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return "Mật khẩu phải có ít nhất một chữ hoa";
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return "Mật khẩu phải có ít nhất một chữ thường";
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return "Mật khẩu phải có ít nhất một chữ số";
    }
    if (!RegExp(r'[!@#\$&*~.,;:<>?%^&()\-_+=]').hasMatch(password)) {
      return "Mật khẩu phải có ít nhất một ký tự đặc biệt";
    }
    return null;
  }

  Future<void> uploadImage() async {
    if (selectedImage.value == null) return;
    isLoading.value = true;
    try {} catch (e) {
      errorMessage.value = "Upload lỗi: $e";
    } finally {
      isLoading.value = false;
    }
  }

  void toSignIn() {
    Get.delete<RegisterController>();
    Get.toNamed("/login");
  }
}
