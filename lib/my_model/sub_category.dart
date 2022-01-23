// To parse this JSON data, do
//
//     final subCategory = subCategoryFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class SubCategory {
  SubCategory({
    required this.id,
    required this.title,
    required this.image,
    required this.categoryId,
  });

  int id;
  String title;
  String image;
  int categoryId;

  factory SubCategory.fromJson(String str) => SubCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubCategory.fromMap(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "image": image,
    "category_id": categoryId,
  };
}
