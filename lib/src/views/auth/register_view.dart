import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/controllers/auth_controller.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/main/Button.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final RxBool showOverlay = false.obs;

  void toggleOverlay() {
    showOverlay.value = !showOverlay.value;
  }

  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RxBool _obscurePassword = true.obs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Header Bar
                MDDNavbar(onMenuTap: toggleOverlay),
                SizedBox(height: 32),

                //  Body
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Center(
                        child: Text(
                          "Đăng nhập vào Blog",
                          style: AppTextStyles.h1,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Username Field
                      SizedBox(
                        height: 48,
                        child: TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: "Username",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) {
                            _authController.errorMessage.value = "";
                          },
                        ),
                      ),

                      // Email Field
                      SizedBox(
                        height: 48,
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) {
                            _authController.errorMessage.value = "";
                          },
                        ),
                      ),

                      // Password Field
                      Obx(
                        () => SizedBox(
                          height: 48,
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword.value,
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  _obscurePassword.value =
                                      !_obscurePassword.value;
                                },
                              ),
                            ),
                            onChanged: (value) {
                              _authController.errorMessage.value = "";
                            },
                          ),
                        ),
                      ),
                      Obx(() {
                        if (_authController.errorMessage.value != "") {
                          return Text(
                            _authController.errorMessage.value,
                            style: AppTextStyles.body3.copyWith(
                              fontSize: 12,
                              color: Colors.red,
                            ),
                          );
                        }
                        return SizedBox.shrink();
                      }),

                      // Sign In Button
                      MDDButton(
                        isPrimary: false,
                        fontSize: 16,
                        color: Colors.white,
                        label: "Đăng ký",
                        onTap: () async {
                          _authController.signUp(
                            _usernameController.text.trim(),
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                        },
                      ),
                      MDDButton(
                        isPrimary: true,
                        fontSize: 16,
                        label: "Đăng nhập",
                        onTap: () => _authController.toSignIn(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Show ra Overlay nav điều hướng khi showOverlay === true
        Obx(
          () =>
              showOverlay.value
                  ? OverlayToggle(closeOverlay: toggleOverlay)
                  : SizedBox.shrink(),
        ),
      ],
    );
  }
}
