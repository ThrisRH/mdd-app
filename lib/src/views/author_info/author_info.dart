import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/controllers/author_controller.dart';
import 'package:mddblog/src/widgets/author_info/favorite_content.dart';
import 'package:mddblog/src/widgets/author_info/info_card.dart';
import 'package:mddblog/src/widgets/author_info/more_topic_section.dart';
import 'package:mddblog/src/widgets/author_info/send_content_section.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/main/error.dart';
import 'package:mddblog/src/widgets/main/loading.dart';

class AuthorInfoPage extends GetWidget<AuthorController> {
  AuthorInfoPage({super.key});
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
              controller.fetchAuthorData();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                spacing: 32,
                children: [
                  // Header Bar
                  MDDNavbar(onMenuTap: toggleOverlay),

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

                          // Footer
                          Footer(),
                        ],
                      ),
                    );
                  }),
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
