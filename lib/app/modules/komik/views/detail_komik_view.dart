import 'package:appsoed/app/modules/komik/controllers/komik_controller.dart';
import 'package:appsoed/app/modules/komik/bindings/komik_api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appsoed/app/modules/komik/model/komik_model.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DetailComicView extends GetView<KomikController> {
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ComicContent(comicImages: comic.comicImage),
          )
        ],
      ),
    );
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
              (image) => Image.network(
                comicAPIService.getImageUri(image.image),
                width: MediaQuery.of(context).size.width,
              ),
            )
            .toList());
  }
}
