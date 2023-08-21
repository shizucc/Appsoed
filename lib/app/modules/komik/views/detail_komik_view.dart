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
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(CupertinoIcons.back),
          ),
          title: Text("${comic.title}"),
        ),
        body: SingleChildScrollView(
          controller: scrollController
            ..addListener(() {
              scrollControllerX
                  .initMaxPosition(scrollController.position.maxScrollExtent);
              scrollControllerX.updateScroll(scrollController.position.pixels);
            }),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
                child: ComicContent(comicImages: comic.comicImage),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        bottomNavigationBar:
            StickyBottomContainer(scrollControllerX: scrollControllerX),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            double scrollPosition = scrollControllerX.scrollPosition.value;
            double max = scrollControllerX.maxPosition.value;
            print('Current : ${scrollPosition}');
            print('max : ${max}');
          },
          child: Icon(Icons.home),
        ));
  }
}

class StickyBottomContainer extends GetView {
  final ScrollControllerX scrollControllerX;

  const StickyBottomContainer({super.key, required this.scrollControllerX});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: scrollControllerX.bottomNavigationBarVisible.value,
        child: Container(
            color: Colors.blue, // Ganti dengan warna atau dekorasi yang sesuai
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Baca Juga"),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    Placeholder(fallbackHeight: 50, fallbackWidth: 50),
                    Placeholder(fallbackHeight: 50, fallbackWidth: 50),
                    Placeholder(fallbackHeight: 50, fallbackWidth: 50),
                    Placeholder(fallbackHeight: 50, fallbackWidth: 50),
                  ]),
                )
              ],
            )),
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

class ReadNextComic extends StatelessWidget {
  const ReadNextComic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Container(
        child: Column(
          children: [
            Text("Baca juga"),
            SizedBox(
              height: 10,
            ),
            ListView(
              children: [],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Placeholder(
                      fallbackHeight: 80,
                      fallbackWidth: 60,
                    ),
                    Text("Judul")
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  children: [
                    Placeholder(
                      fallbackHeight: 80,
                      fallbackWidth: 60,
                    ),
                    Text("Judul")
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  children: [
                    Placeholder(
                      fallbackHeight: 80,
                      fallbackWidth: 60,
                    ),
                    Text("Judul")
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
