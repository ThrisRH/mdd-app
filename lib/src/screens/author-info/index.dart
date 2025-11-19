import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/controllers/author-controller.dart';
import 'package:mddblog/controllers/overlay-controller.dart';
import 'package:mddblog/src/screens/home/sections/banner.dart';
import 'package:mddblog/src/widgets/author_info/favorite-content.dart';
import 'package:mddblog/src/widgets/author_info/info-card.dart';
import 'package:mddblog/src/widgets/author_info/more-topic-section.dart';
import 'package:mddblog/src/widgets/author_info/send-content-section.dart';
import 'package:mddblog/src/widgets/layout/phone-body.dart';
import 'package:mddblog/src/widgets/layout/scroll-wrapper.dart';
import 'package:mddblog/src/widgets/main/error.dart';
import 'package:mddblog/src/widgets/main/loading.dart';

class AuthorInfoPage extends GetWidget<AuthorController> {
  AuthorInfoPage({super.key});
  final overlayController = Get.find<OverlayController>();

  @override
  Widget build(BuildContext context) {
    return PhoneBody(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchAuthorData();
        },
        child: ScrollViewWrapper(
          children: [
            BannerSection(),

            // Body
            Obx(() {
              final data = controller.authorInfo.value;
              if (controller.isLoading.value) {
                return Center(child: Loading());
              }
              if (data == null) {
                return ErrorNotificationWithMessage(
                  errorMessage: controller.errorMessage.value,
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  spacing: 40,
                  children: [
                    InfoCard(data: data),
                    MoreTopicSection(),
                    FavoriteContent(),
                    SendContentSection(),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
