import 'package:appsoed/app/modules/komik/controllers/detail_komik_controller.dart';
import 'package:appsoed/app/modules/komik/bindings/komik_api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appsoed/app/modules/komik/model/komik_model.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class DetailComicView extends GetView {
  final ScrollControllerX scrollControllerX = Get.put(ScrollControllerX());
  final ScrollController scrollController = ScrollController();
  final ComicController comicController = Get.put(ComicController());
  DetailComicView({super.key});
  Comic comic = Get.arguments;
  @override
  Widget build(BuildContext context) {
    comicController.initComic(comic);
    scrollControllerX.initScrollController(scrollController);
    // comicController.initComicPreviewList(comic);
    return Obx(
      () => Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: scrollController
              ..addListener(() {
                scrollControllerX
                    .initMaxPosition(scrollController.position.maxScrollExtent);
                scrollControllerX
                    .updateScroll(scrollController.position.pixels);
              }),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                floating: true,
                pinned: false,
                snap: true,
                leading: GestureDetector(
                    onTap: () => {Navigator.pop(context)},
                    child: const Icon(CupertinoIcons.back, color: Colors.black)
                    // ,
                    ),
                title: Text(
                  '${comicController.currentComic.value.title}',
                  style: const TextStyle(color: Colors.black, fontSize: 17),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 25),
                        child: ComicContent(
                            comicImages:
                                comicController.currentComic.value.comicImage),
                      ),
                      const SizedBox(
                        height: 75,
                      ),
                    ],
                  ),
                )
              ]))
            ],
          ),
          bottomNavigationBar: StickyBottomContainer(
            scrollControllerX: scrollControllerX,
            comic: comicController.currentComic.value,
            comicController: comicController,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            mini: true,
            onPressed: () {
              scrollControllerX.toUpScroll();
            },
            child: const Icon(
              CupertinoIcons.chevron_up,
              color: Colors.black,
            ),
          )),
    );
  }
}

class StickyBottomContainer extends GetView {
  final ScrollControllerX scrollControllerX;
  final Comic comic;
  final ComicController comicController;
  const StickyBottomContainer(
      {super.key,
      required this.scrollControllerX,
      required this.comic,
      required this.comicController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedOpacity(
        curve: Curves.easeInOut,
        opacity: scrollControllerX.bottomNavigationBarVisible.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 1000),
        child: Visibility(
          visible: scrollControllerX.bottomNavigationBarVisible.value,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: const BoxDecoration(
                color: Colors
                    .transparent), // Ganti dengan warna atau dekorasi yang sesuai
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Baca Juga",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: PreviewNextComic(
                        comicException: comic,
                        comicController: comicController,
                      )),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class ComicContent extends StatelessWidget {
  ComicContent({super.key, required this.comicImages});
  final dynamic comicImages;
  final ComicAPIService comicAPIService = ComicAPIService();
  @override
  Widget build(BuildContext context) {
    List<ComicImage> comicImagesDump = comicImages.toList();
    return Column(
        children: comicImagesDump
            .map(
              (image) => Column(
                children: [
                  Image.network(
                    comicAPIService.getImageUri(image.image),
                    width: MediaQuery.of(context).size.width,
                    errorBuilder: (context, error, stackTrace) {
                      return const ComicContentFail();
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
            )
            .toList());
  }
}

class ComicContentFail extends StatelessWidget {
  const ComicContentFail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.grey),
      width: Get.width * 0.9,
      height: 15,
    );
  }
}

class PreviewNextComic extends GetView<ComicController> {
  PreviewNextComic(
      {super.key, required this.comicException, required this.comicController});
  final Comic comicException;
  final ComicController comicController;
  final ComicAPIService comicAPIService = ComicAPIService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: comicController.getPreviewComicData(comicException),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Temukan Banyak Komik Lainnya!",
              style: TextStyle(fontWeight: FontWeight.w600),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Row(
              children: [
                PreviewNextComicShimmer(),
                PreviewNextComicShimmer(),
                PreviewNextComicShimmer()
              ],
            );
          } else if (snapshot.hasData) {
            dynamic comicsDump = (snapshot.data)?.toList() ?? [];
            List<Comic> comics = comicsDump.toList();

            return Row(
                children: comics
                    .map((comic) => GestureDetector(
                          onTap: () {
                            comicController.initComic(comic);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: 100,
                            child: Column(
                              children: [
                                Image.network(
                                  comicAPIService.getCoverUri(comic.cover),
                                  height: 75,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: ((context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/comic_no_image.png',
                                      height: 75,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    );
                                  }),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${comic.title}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList());
          } else {
            return const Text("No Comic available");
          }
        });
  }
}

class PreviewNextComicShimmer extends StatelessWidget {
  const PreviewNextComicShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.black),
                width: 100,
                height: 75,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.black),
                width: 75,
                height: 10,
              ),
            ],
          ),
        ));
  }
}
