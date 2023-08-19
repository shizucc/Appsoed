import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum AppBarState { expanded, collapsed }

class KomikController extends GetxController {
  final ScrollController scrollController = ScrollController();
  var appBarState = Rx<AppBarState>(AppBarState.expanded);

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(handleScroll);
  }

  void handleScroll() {
    if (scrollController.offset > 150 &&
        appBarState.value == AppBarState.expanded) {
      appBarState.value = AppBarState.collapsed;
    } else if (scrollController.offset <= 150 &&
        appBarState.value == AppBarState.collapsed) {
      appBarState.value = AppBarState.expanded;
    }
  }
}
