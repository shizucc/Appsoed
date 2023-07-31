// To parse this JSON data, do
//
//     final kost = kostFromJson(jsonString);

import 'dart:convert';

List<Kost> kostFromJson(String str) => List<Kost>.from(json.decode(str).map((x) => Kost.fromJson(x)));

String kostToJson(List<Kost> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Kost {
    int? id;
    String? name;
    String? type;
    String? region;
    String? address;
    String? location;
    String? priceStart;
    String? owner;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<KostFacility>? kostFacilities;
    List<KostImage>? kostImages;

    Kost({
        this.id,
        this.name,
        this.type,
        this.region,
        this.address,
        this.location,
        this.priceStart,
        this.owner,
        this.createdAt,
        this.updatedAt,
        this.kostFacilities,
        this.kostImages,
    });

    factory Kost.fromJson(Map<String, dynamic> json) => Kost(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        region: json["region"],
        address: json["address"],
        location: json["location"],
        priceStart: json["price_start"],
        owner: json["owner"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        kostFacilities: json["kost_facilities"] == null ? [] : List<KostFacility>.from(json["kost_facilities"]!.map((x) => KostFacility.fromJson(x))),
        kostImages: json["kost_images"] == null ? [] : List<KostImage>.from(json["kost_images"]!.map((x) => KostImage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "region": region,
        "address": address,
        "location": location,
        "price_start": priceStart,
        "owner": owner,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "kost_facilities": kostFacilities == null ? [] : List<dynamic>.from(kostFacilities!.map((x) => x.toJson())),
        "kost_images": kostImages == null ? [] : List<dynamic>.from(kostImages!.map((x) => x.toJson())),
    };
}

class KostFacility {
    int? id;
    String? kostId;
    String? facility;

    KostFacility({
        this.id,
        this.kostId,
        this.facility,
    });

    factory KostFacility.fromJson(Map<String, dynamic> json) => KostFacility(
        id: json["id"],
        kostId: json["kost_id"],
        facility: json["facility"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "kost_id": kostId,
        "facility": facility,
    };
}

class KostImage {
    int? id;
    String? kostId;
    String? image;

    KostImage({
        this.id,
        this.kostId,
        this.image,
    });

    factory KostImage.fromJson(Map<String, dynamic> json) => KostImage(
        id: json["id"],
        kostId: json["kost_id"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "kost_id": kostId,
        "image": image,
    };
}
