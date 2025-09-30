import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/controllers/register_controller.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/main/button.dart';
import 'package:mddblog/src/widgets/main/input.dart';
import 'package:mddblog/theme/element/app_colors.dart';

class RegisterPage extends GetWidget {
  RegisterPage({super.key});

  final RxBool showOverlay = false.obs;

  void toggleOverlay() {
    showOverlay.value = !showOverlay.value;
  }

  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                registerController.clearInput();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Column(
                    spacing: 32,
                    children: [
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
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                            SizedBox(height: 12),

                            Center(
                              child: GestureDetector(
                                onTap:
                                    () =>
                                        registerController
                                            .pickImageFromGallery(),
                                child: Container(
                                  width: 128,
                                  height: 128,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade300,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Obx(() {
                                    if (registerController
                                            .selectedImage
                                            .value ==
                                        null) {
                                      return Center(
                                        child: Icon(
                                          Icons.person,
                                          size: 100,
                                          color: Colors.white,
                                        ),
                                      );
                                    }
                                    return CircleAvatar(
                                      backgroundImage: FileImage(
                                        registerController.selectedImage.value!,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),

                            // Fullname Field
                            MDDTextInputField(
                              textController:
                                  registerController.fullnameController,
                              label: "Fullname",
                              hint: "Enter your fullname",
                              onChange:
                                  (value) => {
                                    registerController.errorMessage.value = "",
                                  },
                            ),
                            // Username Field
                            MDDTextInputField(
                              textController:
                                  registerController.usernameController,
                              label: "Username",
                              hint: "Enter your username",
                              onChange:
                                  (value) => {
                                    registerController.errorMessage.value = "",
                                  },
                            ),

                            // Email Field
                            MDDTextInputField(
                              textController:
                                  registerController.emailController,
                              label: "Email",
                              hint: "Enter your email",
                              onChange:
                                  (value) => {
                                    registerController.errorMessage.value = "",
                                  },
                            ),

                            // Password Field
                            MDDPasswordInputField(
                              textController:
                                  registerController.passwordController,
                              label: "Password",
                              hint: "Enter your password",
                              onChange:
                                  (value) => (
                                    registerController.errorMessage.value = "",
                                  ),
                            ),

                            Obx(() {
                              if (registerController.errorMessage.value != "") {
                                return Text(
                                  registerController.errorMessage.value,
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
                                      registerController.isLoading.value
                                          ? Colors.grey.shade300
                                          : AppColors.secondary,
                                  label: "Sign Up",
                                  onTap: () async {
                                    registerController.signUp();
                                  },
                                ),

                                RichText(
                                  text: TextSpan(
                                    text: "Already have an account? ",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
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
                                                  () =>
                                                      registerController
                                                          .toSignIn(),
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
          ),

          // Show ra Overlay nav điều hướng khi showOverlay === true
          Obx(
            () =>
                showOverlay.value
                    ? OverlayToggle(closeOverlay: toggleOverlay)
                    : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
