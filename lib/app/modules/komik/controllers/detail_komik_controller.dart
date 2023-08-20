import 'package:get/get.dart';

class ScrollControllerX extends GetxController {
  RxDouble scrollPosition = 0.0.obs;
  RxDouble maxPosition = 0.0.obs;
  RxBool bottomNavigationBarVisible = false.obs;

  updateScroll(double newPosition) {
    scrollPosition.value = newPosition;
    updateStickyContainerVisibility();
  }

  initMaxPosition(double newPosition) {
    maxPosition.value = newPosition;
  }

  void updateStickyContainerVisibility() {
    bool showStickyContainer =
        scrollPosition.value >= maxPosition.value * (0.8);
    bottomNavigationBarVisible.value = showStickyContainer;
    update();
    // print(bottomNavigationBarVisible.value);
  }
}
