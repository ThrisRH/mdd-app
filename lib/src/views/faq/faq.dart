import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/models/faq_model.dart';
import 'package:mddblog/services/faq_service.dart';
import 'package:mddblog/src/widgets/faq/faq_card.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/main/error.dart';
import 'package:mddblog/src/widgets/main/loading.dart';
import 'package:mddblog/src/widgets/post/header_line.dart';
import 'package:mddblog/theme/element/app_colors.dart';

// Controller
class FaqController extends GetxController {
  final FaqService _faqService = FaqService();

  var faqs = <QuestionAnswer>[].obs;
  var isLoading = true.obs;
  var selectedIndex = RxnInt();
  var errorMessage = "".obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 1), () {
      fetchFAQs();
    });
  }

  void fetchFAQs() async {
    try {
      isLoading.value = true;
      final response = await _faqService.getFaqs();
      faqs.assignAll(response.data.questionAnswers);
    } catch (error) {
      errorMessage.value = "Lỗi kết nối, vui lòng kiểm tra lại đường truyền!";
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
          body: RefreshIndicator(
            onRefresh: () async {
              controller.fetchFAQs();
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
                      spacing: 32,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Câu hỏi thường gặp",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),

                        // Thanh ngang
                        HeaderLine(
                          child: Row(
                            children: List.generate(8, (index) {
                              return Container(
                                margin: EdgeInsets.only(left: 4, right: 4),
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  shape: BoxShape.circle,
                                ),
                              );
                            }),
                          ),
                        ),

                        // Nội dung FAQ
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            left: 40,
                            right: 40,
                            bottom: 40,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Obx(() {
                            if (controller.isLoading.value) {
                              return Center(child: Loading());
                            }
                            if (controller.faqs.isEmpty) {
                              return Center(
                                child: ErrorNotificationWithMessage(
                                  errorMessage: controller.errorMessage.value,
                                ),
                              );
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
