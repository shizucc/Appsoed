import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:appsoed/app/modules/komik/bindings/komik_api_services.dart';
import 'package:appsoed/app/modules/komik/model/komik_model.dart';

class ScrollControllerX extends GetxController {
  RxDouble scrollPosition = 0.0.obs;
  RxDouble maxPosition = 0.0.obs;
  RxBool bottomNavigationBarVisible = false.obs;
  late double maxPositionDump;
  Rx<ScrollController> scrollController = ScrollController().obs;

  updateScroll(double newPosition) {
    scrollPosition.value = newPosition;
    print(scrollPosition);
    print(bottomNavigationBarVisible);
    updateStickyContainerVisibility();
  }

  initMaxPosition(double newPosition) {
    maxPosition.value = newPosition;
  }

  initScrollController(ScrollController myScrollController) {
    scrollController.value = myScrollController;
  }

  void toUpScroll() {
    scrollController.value.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void updateStickyContainerVisibility() {
    bool showStickyContainer = scrollPosition.value >= maxPosition.value - 250;
    bottomNavigationBarVisible.value = showStickyContainer;
    update();
  }
}

class ComicController extends GetxController {
  Rx<Comic> currentComic = Comic().obs;
  // RxList<Comic> comicPreviewList = [Comic()].obs;

  initComic(Comic comic) {
    currentComic.value = comic;
    update();
  }

  // Future<void> initComicPreviewList(Comic comic) async {
  //   List<Comic> comicList = await getPreviewComicData(comic);
  //   comicPreviewList.value = comicList;
  // }

  Future<List<Comic>> getPreviewComicData(Comic comicException) async {
    List<Comic> comicListDump = await ComicAPIService().getComics();
    // Remove current comic
    comicListDump.removeWhere((comic) => comic.title == comicException.title);

    // Shuffle Comic
    comicListDump.shuffle();

    // Get 4 first Comic
    List<Comic> comicList = comicListDump.sublist(0, 4);

    return comicList;
  }

  // Future<List<Comic>> getComicList() async {
  //   return comicPreviewList;
  // }
}
