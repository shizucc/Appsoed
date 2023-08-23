import 'package:get/get.dart';
import 'package:appsoed/app/modules/komik/bindings/komik_api_services.dart';
import 'dart:math';
import 'package:appsoed/app/modules/komik/model/komik_model.dart';

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
    bool showStickyContainer = scrollPosition.value >= maxPosition.value - 50;
    bottomNavigationBarVisible.value = showStickyContainer;
    update();
  }
}

class ComicController extends GetxController {
  Rx<Comic> currentComic = Comic().obs;

  initComic(Comic comic) {
    currentComic.value = comic;
    print(currentComic.value.title);
  }

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
}
