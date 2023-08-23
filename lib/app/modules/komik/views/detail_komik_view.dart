import 'package:appsoed/app/modules/komik/controllers/detail_komik_controller.dart';
import 'package:appsoed/app/modules/komik/bindings/komik_api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appsoed/app/modules/komik/model/komik_model.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DetailComicView extends StatelessWidget {
  final ScrollControllerX scrollControllerX = Get.put(ScrollControllerX());
  final ScrollController scrollController = ScrollController();
  DetailComicView({super.key});
  Comic comic = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          controller: scrollController
            ..addListener(() {
              scrollControllerX
                  .initMaxPosition(scrollController.position.maxScrollExtent);
              scrollControllerX.updateScroll(scrollController.position.pixels);
            }),
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: false,
              snap: true,
              leading: GestureDetector(
                  onTap: () => {Navigator.pop(context)},
                  child: const Icon(
                      size: 30, CupertinoIcons.back, color: Colors.white)
                  // ,
                  ),
              flexibleSpace: FlexibleSpaceBar(
                title: Text('${comic.title}'),
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
                      child: ComicContent(comicImages: comic.comicImage),
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
          comic: comic,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            scrollController.animateTo(0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          },
          child: Icon(CupertinoIcons.chevron_up),
        ));
  }
}

class StickyBottomContainer extends GetView {
  final ScrollControllerX scrollControllerX;
  final Comic comic;
  const StickyBottomContainer(
      {super.key, required this.scrollControllerX, required this.comic});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedOpacity(
        opacity: scrollControllerX.bottomNavigationBarVisible.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Visibility(
          visible: scrollControllerX.bottomNavigationBarVisible.value,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ]), // Ganti dengan warna atau dekorasi yang sesuai
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Baca Juga",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        PreviewNextComic(
                          comicException: comic,
                        )
                      ]),
                    ),
                  )
                ],
              )),
        ),
      );
    });
  }
}

// ignore: must_be_immutable
class ComicContent extends StatelessWidget {
  ComicContent({super.key, required this.comicImages});
  final dynamic comicImages;
  ComicAPIService comicAPIService = ComicAPIService();
  @override
  Widget build(BuildContext context) {
    List<ComicImage> comicImagesDump = comicImages.toList();
    return Column(
        children: comicImagesDump
            .map(
              (image) => Container(
                child: Column(
                  children: [
                    Image.network(
                      comicAPIService.getImageUri(image.image),
                      width: MediaQuery.of(context).size.width,
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
            )
            .toList());
  }
}

class PreviewNextComic extends StatelessWidget {
  PreviewNextComic({super.key, required this.comicException});
  final Comic comicException;
  final comicController = ComicController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: comicController.getPreviewComicData(comicException),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            print(snapshot.data);
            return Container();
          } else {
            return const Text("No Comic available");
          }
        });
  }
}
