import 'dart:convert';

List<Comic> comicsFromJson(String str) =>
    List<Comic>.from(json.decode(str).map((data) => Comic.fromJson(data)));

Comic comicFromJson(String str) => Comic.fromJson(json.decode(str));

class Comic {
  int? id;
  String? title;
  String? cover;
  List<ComicImage>? comicImage;

  Comic({this.id, this.title, this.cover, this.comicImage});

  factory Comic.fromJson(Map<String, dynamic> json) => Comic(
      id: json['id'],
      title: json['title'],
      cover: json['cover'],
      comicImage: json['comic_images'] == null
          ? []
          : List<ComicImage>.from(json['comic_images']!
              .map((image) => ComicImage.fromJson(image))));
}

class ComicImage {
  int? id;
  int? comicId;
  String? image;

  ComicImage({this.id, this.comicId, this.image});

  factory ComicImage.fromJson(Map<String, dynamic> json) => ComicImage(
        id: json['id'],
        comicId: json['comicId'],
        image: json['image'],
      );

  // Useless ?
  Map<String, dynamic> toJson() =>
      {'id': id, 'comic_id': comicId, 'image': image};
}
