import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/controllers/author_controller.dart';
import 'package:mddblog/src/widgets/author_info/FavoriteContent.dart';
import 'package:mddblog/src/widgets/author_info/InfoCard.dart';
import 'package:mddblog/src/widgets/author_info/MoreTopicSection.dart';
import 'package:mddblog/src/widgets/author_info/SendContentSection.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/main/Error.dart';
import 'package:mddblog/src/widgets/main/Loading.dart';

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
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Header Bar
                MDDNavbar(onMenuTap: toggleOverlay),
                SizedBox(height: 32),

                // Body
                Obx(() {
                  final data = controller.authorInfo.value;
                  if (controller.isLoading.value) {
                    return Center(child: Loading());
                  }
                  if (data == null) {
                    return ErrorNotification();
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
