// To parse this JSON data, do
//
//     final brands = brandsFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Brand {
  Brand({
    required this.id,
    required this.title,
    required this.image,
  });

  int id;
  String title;
  String image;

  factory Brand.fromJson(String str) => Brand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Brand.fromMap(Map<String, dynamic> json) => Brand(
    id: json["id"],
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "image": image,
  };
}
