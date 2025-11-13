import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/controllers/overlay-controller.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';

class PhoneBody extends StatelessWidget {
  final Widget body;
  PhoneBody({super.key, required this.body});

  final overlayController = Get.find<OverlayController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: MDDNavbar(onMenuTap: overlayController.toggleOverlay),
          body: body,
        ),

        Obx(
          () =>
              overlayController.showOverlay.value
                  ? OverlayToggle(closeOverlay: overlayController.closeOverlay)
                  : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
