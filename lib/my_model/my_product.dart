// To parse this JSON data, do
//
//     final myProduct = myProductFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:get/get.dart';

class MyProduct {
  MyProduct({
    required this.id,
    required this.subCategoryId,
    required this.brandId,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.price,
    required this.rate,
    required this.image,
    required this.ratingCount,
    required this.availability,
  });

  int id;
  int subCategoryId;
  int brandId;
  String title;
  String subTitle;
  String description;
  int price;
  double rate;
  String image;
  int ratingCount;
  int availability;
  var favorite=false.obs;

  factory MyProduct.fromJson(String str) => MyProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyProduct.fromMap(Map<String, dynamic> json) => MyProduct(
    id: json["id"],
    subCategoryId: json["sub_category_id"],
    brandId: json["brand_id"],
    title: json["title"],
    subTitle: json["sub_title"],
    description: json["description"],
    price: json["price"],
    rate: double.parse(json["rate"].toString()),
    image: json["image"],
    ratingCount: json["rating_count"],
    availability: json["availability"]==null?0:json["availability"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "sub_category_id": subCategoryId,
    "brand_id": brandId,
    "title": title,
    "sub_title": subTitle,
    "description": description,
    "price": price,
    "rate": rate,
    "image": image,
    "rating_count": ratingCount,
    "availability":availability
  };
}
