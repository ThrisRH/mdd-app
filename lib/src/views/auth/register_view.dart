import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/controllers/auth_controller.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/main/button.dart';
import 'package:mddblog/src/widgets/main/input.dart';
import 'package:mddblog/theme/element/app_colors.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final RxBool showOverlay = false.obs;

  void toggleOverlay() {
    showOverlay.value = !showOverlay.value;
  }

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              authController.clearInput();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                spacing: 32,
                children: [
                  // Header Bar
                  MDDNavbar(onMenuTap: toggleOverlay),

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
                            "Create Account",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        SizedBox(height: 12),

                        // Username Field
                        MDDTextInputField(
                          textController: authController.usernameController,
                          label: "Username",
                          hint: "Enter your username",
                          onChange:
                              (value) => {
                                authController.errorMessage.value = "",
                              },
                        ),

                        // Email Field
                        MDDTextInputField(
                          textController: authController.emailController,
                          label: "Email",
                          hint: "Enter your email",
                          onChange:
                              (value) => {
                                authController.errorMessage.value = "",
                              },
                        ),

                        // Password Field
                        MDDPasswordInputField(
                          textController: authController.passwordController,
                          label: "Password",
                          hint: "Enter your password",
                          onChange:
                              (value) => (
                                authController.errorMessage.value = "",
                              ),
                        ),

                        Obx(() {
                          if (authController.errorMessage.value != "") {
                            return Text(
                              authController.errorMessage.value,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: Colors.red),
                            );
                          }
                          return SizedBox.shrink();
                        }),

                        // Sign In Button
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 24,
                          children: [
                            MDDButton(
                              fontSize: 16,
                              color: Colors.white,
                              bgColor:
                                  authController.isLoading.value
                                      ? Colors.grey.shade300
                                      : AppColors.secondary,
                              label: "Sign Up",
                              onTap: () async {
                                authController.signUp();
                              },
                            ),

                            RichText(
                              text: TextSpan(
                                text: "Already have an account? ",
                                style: Theme.of(context).textTheme.bodySmall,
                                children: [
                                  TextSpan(
                                    text: "Sign In!",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.copyWith(
                                      color: AppColors.secondary,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.secondary,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap =
                                              () => authController.toSignIn(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
