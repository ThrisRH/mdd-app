import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/services/auth_service.dart';
import 'package:mddblog/src/widgets/main/input.dart';
import 'package:mddblog/theme/element/app_colors.dart';

Future<bool> showReloginDialog() async {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  return await Get.dialog<bool>(
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Dialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 24,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    spacing: 16,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Xác thực lại",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      MDDTextInputField(
                        textController: emailController,
                        label: "Email",
                        hint: "Email",
                      ),

                      MDDPasswordInputField(
                        textController: passwordController,
                        label: "Password",
                        hint: "Password",
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 16,
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(result: false),
                            child: Text(
                              "Hủy",
                              style: TextStyle(color: AppColors.secondary),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final ok = await AuthenticationService().reSignIn(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                              Get.back(result: ok);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                "Xác nhận",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      ) ??
      false;
}
