import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mddblog/controllers/auth-controller.dart';
import 'package:mddblog/controllers/overlay-controller.dart';
import 'package:mddblog/src/views/home/widgets/banner.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/main/button.dart';
import 'package:mddblog/src/widgets/main/input.dart';
import 'package:mddblog/theme/element/app-colors.dart';

class LoginPage extends GetWidget {
  LoginPage({super.key});

  final overlayController = Get.find<OverlayController>();
  final storage = const FlutterSecureStorage();

  final AuthController authController = Get.put(AuthController());
  final InputController inputController = Get.put(InputController());

  // Trạng thái đăng nhập Google
  final RxString googleToken = "".obs;

  Future<void> checkToken() async {
    final token = await storage.read(key: "accessToken");
    if (token != null && token.isNotEmpty) {
      googleToken.value = token;
    } else {
      googleToken.value = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Khi vào page thì kiểm tra token
    checkToken();

    return Stack(
      children: [
        Scaffold(
          appBar: MDDNavbar(onMenuTap: overlayController.toggleOverlay),

          body: RefreshIndicator(
            onRefresh: () async {
              authController.clearInput();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                spacing: 32,
                children: [
                  BannerSection(),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Login to Your Account",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Email + Password login ...
                        MDDTextInputField(
                          textController: authController.emailController,
                          label: "Email",
                          hint: "john.smith@example.com",
                          onChange:
                              (value) => {
                                authController.errorMessage.value = "",
                              },
                        ),

                        MDDPasswordInputField(
                          textController: authController.passwordController,
                          label: "Password",
                          hint: "Enter your password",
                          onChange:
                              (value) => {
                                authController.errorMessage.value = "",
                              },
                        ),

                        Obx(() {
                          if (authController.errorMessage.value == "") {
                            return SizedBox.shrink();
                          }
                          return Text(
                            authController.errorMessage.value,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(color: Colors.red),
                          );
                        }),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 24,
                          children: [
                            Obx(
                              () => MDDButton(
                                color: Colors.white,
                                bgColor:
                                    authController.isLoading.value
                                        ? Colors.grey.shade300
                                        : AppColors.secondary,
                                label: "Sign In",
                                fontSize: 16,
                                isDisabled: authController.isLoading.value,
                                onTap: () async {
                                  authController.signIn();
                                },
                              ),
                            ),

                            RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: Theme.of(context).textTheme.bodySmall,
                                children: [
                                  TextSpan(
                                    text: "Sign Up!",
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
                                              () => authController.toRegister(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Hiển thị login / logout Google dựa vào token
                        GoogleButton(
                          label: 'Login với Google',
                          onTap: () => {Get.toNamed("/oauthGoogle")},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Obx(
          () =>
              overlayController.showOverlay.value
                  ? OverlayToggle(closeOverlay: overlayController.closeOverlay)
                  : SizedBox.shrink(),
        ),
      ],
    );
  }
}
