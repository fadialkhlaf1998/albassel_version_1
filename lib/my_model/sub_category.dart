// To parse this JSON data, do
//
//     final subCategory = subCategoryFromMap(jsonString);

import 'package:albassel_version_1/const/global.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class SubCategory {
  SubCategory({
    required this.id,
    required this.title,
    required this.arTitle,
    required this.image,
    required this.categoryId,
  });

  int id;
  String title;
  String arTitle;
  String image;
  int categoryId;

  getTitle(){
    if(Global.lang_code == "en"){
      return title;
    }else{
      return arTitle;
    }
  }

  factory SubCategory.fromJson(String str) => SubCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubCategory.fromMap(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    title: json["title"],
    arTitle: json["ar_title"],
    image: json["image"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "ar_title": arTitle,
    "image": image,
    "category_id": categoryId,
  };
}
