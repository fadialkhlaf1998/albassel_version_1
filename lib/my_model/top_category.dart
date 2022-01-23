// To parse this JSON data, do
//
//     final topCategory = topCategoryFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class TopCategory {
  TopCategory({
    required this.id,
    required this.categoryId,
    required this.mainImage,
    required this.category,
  });

  int id;
  int categoryId;
  String mainImage;
  String category;

  factory TopCategory.fromJson(String str) => TopCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TopCategory.fromMap(Map<String, dynamic> json) => TopCategory(
    id: json["id"],
    categoryId: json["category_id"],
    mainImage: json["main_image"],
    category: json["category"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "category_id": categoryId,
    "main_image": mainImage,
    "category": category,
  };
}
