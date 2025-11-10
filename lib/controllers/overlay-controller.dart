import 'package:get/get.dart';

class OverlayController extends GetxController {
  var showOverlay = false.obs;

  void toggleOverlay() {
    showOverlay.value = !showOverlay.value;
  }

  void closeOverlay() {
    showOverlay.value = false;
  }

  void openOverlay() {
    showOverlay.value = true;
  }
}
