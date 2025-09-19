// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/models/faq_model.dart';
import 'package:mddblog/src/services/faq_service.dart';
import 'package:mddblog/src/widgets/faq/faqCard.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/post/headerLine.dart';
import 'package:mddblog/theme/app_colors.dart';
import 'package:mddblog/theme/app_text_styles.dart';

// Controller
class FaqController extends GetxController {
  final FaqService _faqService = FaqService();

  var faqs = <QuestionAnswer>[].obs;
  var isLoading = true.obs;
  var selectedIndex = RxnInt();

  @override
  void onInit() {
    super.onInit();
    fetchFAQs();
  }

  void fetchFAQs() async {
    try {
      isLoading.value = true;
      final response = await _faqService.getFaqs();
      faqs.assignAll(response.data.questionAnswers);
    } catch (error) {
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void toggleAnswer(int index) {
    if (selectedIndex.value == index) {
      selectedIndex.value = null;
    } else {
      selectedIndex.value = index;
    }
  }
}

class FAQ extends GetWidget<FaqController> {
  FAQ({super.key});

  final RxBool showOverlay = false.obs;

  void toggleOverlay() {
    showOverlay.value = !showOverlay.value;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Header Bar
                MDDNavbar(onSearchTap: () => {}, onMenuTap: toggleOverlay),
                SizedBox(height: 32),

                //  Body
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Câu hỏi thường gặp", style: AppTextStyles.h0),
                      SizedBox(height: 32),

                      // Thanh ngang
                      HeaderLine(
                        child: Row(
                          children: List.generate(8, (index) {
                            return Container(
                              margin: EdgeInsets.only(left: 4, right: 4),
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: 32),

                      // Nội dung FAQ
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          left: 40,
                          right: 40,
                          bottom: 40,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Obx(() {
                          if (controller.isLoading.value) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (controller.faqs.isEmpty) {
                            return Center(child: Text("No FAQs Found!"));
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.faqs.length,
                            itemBuilder: (context, index) {
                              final faq = controller.faqs[index];
                              return Obx(
                                () => FAQCard(
                                  question: faq.question,
                                  answer: faq.answer,
                                  toggleAnswer:
                                      () => controller.toggleAnswer(index),
                                  isSelected:
                                      controller.selectedIndex.value == index,
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                // Footer
                Footer(),
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
