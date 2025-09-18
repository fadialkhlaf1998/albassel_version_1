// To parse this JSON data, do
//
//     final category = categoryFromMap(jsonString);

import 'package:albassel_version_1/const/global.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class Category {
  Category({
    required this.id,
    required this.title,
    required this.arTitle,
    required this.image,
  });

  int id;
  String title;
  String arTitle;
  String image;

  getTitle(){
    if(Global.lang_code == "en"){
      return title;
    }else{
      return arTitle;
    }
  }

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    arTitle: json["ar_title"],
    image: json["image"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "ar_title": arTitle,
    "image": image,
  };
}
