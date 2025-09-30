import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/services/author_service.dart';
import 'package:mddblog/src/widgets/main/button.dart';
import 'package:mddblog/theme/element/app_colors.dart';

class SendContentController extends GetxController {
  var email = "".obs;
  var isLoading = false.obs;

  final emailController = TextEditingController(); // 👈 thêm controller

  final AuthorService authorService = AuthorService();

  Future<void> sendContent() async {
    try {
      isLoading.value = true;
      if (email.value.trim().isEmpty) {
        Get.snackbar(
          "Gửi không thành công!",
          "Không được để trống",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          backgroundColor: Colors.red.shade100,
          colorText: Colors.black,
        );
        return;
      } else if (!RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      ).hasMatch(email.value.trim())) {
        Get.snackbar(
          "Gửi không thành công!",
          "Email không hợp lệ",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          backgroundColor: Colors.red.shade100,
          colorText: Colors.black,
        );
        return;
      }

      final response = await authorService.sendContent(email.value);
      if (!response) {
        Get.snackbar(
          "Gửi không thành công!",
          "Email đã tồn tại",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          backgroundColor: Colors.red.shade400,
          colorText: Colors.black,
        );
        return;
      }

      // 👉 Clear input khi thành công
      email.value = "";
      emailController.clear();

      Get.snackbar(
        "Gửi thành công!",
        "Gửi contact cho MDD thành công!",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        backgroundColor: Colors.green.shade400,
        colorText: Colors.black,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

class SendContentSection extends GetWidget {
  SendContentSection({super.key});

  final SendContentController c = Get.put(SendContentController());

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 363 / 274, // tỉ lệ của SVG gốc
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/SendContentFrame.svg",
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 64,
              bottom: 12,
              right: 24,
              left: 24,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                spacing: 12,
                children: [
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.black),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: c.emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => {c.email.value = value},
                      decoration: InputDecoration(
                        hintText: "Nhập email của bạn",
                        hintStyle: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: Color(0xFF8B8B8B)),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),

                  MDDButton(
                    bgColor: AppColors.primary,
                    label: "Đăng ký",
                    onTap: () => c.sendContent(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
