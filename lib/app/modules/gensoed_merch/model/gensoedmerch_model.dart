import 'dart:convert';

List<GensoedMerch> gensoedMerchsFromJson(String str) => List<GensoedMerch>.from(
    json.decode(str).map((data) => GensoedMerch.fromJson(data)));

class GensoedMerch {
  int? id;
  String? name;
  String? image;
  int? priceStart;
  int? priceEnd;
  String? productLink;

  GensoedMerch(
      {this.id,
      this.name,
      this.image,
      this.priceStart,
      this.priceEnd,
      this.productLink});

  factory GensoedMerch.fromJson(Map<String, dynamic> json) => GensoedMerch(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      priceStart: int.parse(json['price_start'] ?? '0'),
      priceEnd: int.parse(json['price_end'] ?? '0'),
      productLink: json['product_link'] ?? '');
}
