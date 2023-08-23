import 'package:get/get.dart';
import 'package:appsoed/app/modules/komik/bindings/komik_api_services.dart';
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
  Future<List<dynamic>> getPreviewComicData(Comic comicException) async {
    List<Comic> comicList = await ComicAPIService().getComics();
    comicList.removeWhere((comic) => comic.title == comicException.title);

    List<String?> comicTitle = comicList.map((e) => e.title).toList();
    return comicTitle;
  }
}
