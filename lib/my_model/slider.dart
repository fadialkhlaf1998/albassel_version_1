// To parse this JSON data, do
//
//     final slider = sliderFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class MySlider {
  MySlider({
    required this.id,
    required this.title,
    required this.image,
    required this.product_id,
    required this.is_product,
  });

  int id;
  String title;
  String image;
  int? product_id;
  int? is_product;


  factory MySlider.fromJson(String str) => MySlider.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MySlider.fromMap(Map<String, dynamic> json) => MySlider(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    product_id: json["product_id"],
    is_product: json ["is_product"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "image": image,
    "product_id": product_id,

  };
}
