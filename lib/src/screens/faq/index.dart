import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/controllers/overlay-controller.dart';
import 'package:mddblog/models/faq-model.dart';
import 'package:mddblog/services/faq-service.dart';
import 'package:mddblog/src/screens/faq/sections/faq-items.dart';
import 'package:mddblog/src/screens/home/sections/banner.dart';
import 'package:mddblog/src/widgets/layout/phone-body.dart';
import 'package:mddblog/src/widgets/layout/scroll-wrapper.dart';
import 'package:mddblog/src/widgets/main/error.dart';
import 'package:mddblog/src/widgets/main/loading.dart';
import 'package:mddblog/src/widgets/post/header-line.dart';

// Controller
class FaqController extends GetxController {
  final FaqService _faqService = FaqService();

  var faqs = <QuestionAnswer>[].obs;
  var isLoading = true.obs;
  var selectedIndex = RxnInt(0);
  var errorMessage = "".obs;

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
      errorMessage.value = "Lỗi kết nối, vui lòng kiểm tra lại đường truyền!";
    } finally {
      isLoading.value = false;
    }
  }

  void toggleAnswer(int index) {
    final prev = selectedIndex.value;
    if (prev == index) {
      selectedIndex.value = null;
      update(['faq-$index']);
    } else {
      selectedIndex.value = index;
      if (prev != null) {
        update(['faq-$index', 'faq-$prev']);
      } else {
        update(['faq-$index']);
      }
    }
  }
}

class FAQ extends GetWidget<FaqController> {
  FAQ({super.key});

  final overlayController = Get.find<OverlayController>();

  @override
  Widget build(BuildContext context) {
    return PhoneBody(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchFAQs();
        },
        child: ScrollViewWrapper(
          children: [
            // Header Bar
            BannerSection(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: Text(
                      "Câu hỏi thường gặp",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  HeaderLine(
                    child: Row(
                      children: List.generate(8, (index) {
                        return Container(
                          margin: EdgeInsets.only(left: 4, right: 4),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSurface,
                            shape: BoxShape.circle,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(24.0),
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: Color(0xFFFBF4ED),
              ),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: Loading());
                }

                if (controller.faqs.isEmpty) {
                  return ErrorNotificationWithMessage(
                    errorMessage: controller.errorMessage.value,
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...controller.faqs.asMap().entries.map((entry) {
                      final index = entry.key;
                      final faq = entry.value;
                      return FAQItems(faq: faq, index: index);
                    }),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
