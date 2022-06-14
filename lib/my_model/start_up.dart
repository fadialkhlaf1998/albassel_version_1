// To parse this JSON data, do
//
//     final startUp = startUpFromMap(jsonString);


import 'dart:convert';

import 'package:albassel_version_1/my_model/brand.dart';
import 'package:albassel_version_1/my_model/my_product.dart';
import 'package:albassel_version_1/my_model/slider.dart';
import 'package:albassel_version_1/my_model/top_category.dart';
import 'package:albassel_version_1/my_model/category.dart';

class StartUp {
  StartUp({
    required this.category,
    required this.topCategories,
    required this.slider,
    required this.bestSellers,
    required this.brand,
  });

  List<Category> category;
  List<TopCategory> topCategories;
  List<MySlider> slider;
  List<MyProduct> bestSellers;
  List<Brand> brand;

  factory StartUp.fromJson(String str) => StartUp.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StartUp.fromMap(Map<String, dynamic> json) => StartUp(
    category: List<Category>.from(json["category"].map((x) => Category.fromMap(x))),
    topCategories: List<TopCategory>.from(json["top_categories"].map((x) => TopCategory.fromMap(x))),
    slider: List<MySlider>.from(json["slider"].map((x) => MySlider.fromMap(x))),
    bestSellers: List<MyProduct>.from(json["best_sellers"].map((x) => MyProduct.fromMap(x))),
    brand: List<Brand>.from(json["brand"].map((x) => Brand.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "category": List<dynamic>.from(category.map((x) => x.toMap())),
    "top_categories": List<dynamic>.from(topCategories.map((x) => x.toMap())),
    "slider": List<dynamic>.from(slider.map((x) => x.toMap())),
    "best_sellers": List<dynamic>.from(bestSellers.map((x) => x.toMap())),
    "brand": List<dynamic>.from(brand.map((x) => x.toMap())),
  };
}