// To parse this JSON data, do
//
//     final startUp = startUpFromMap(jsonString);


import 'dart:convert';

import 'package:albassel_version_1/model_v2/product.dart';
import 'package:albassel_version_1/my_model/brand.dart';
import 'package:albassel_version_1/my_model/marquee.dart';
import 'package:albassel_version_1/my_model/my_product.dart';
import 'package:albassel_version_1/my_model/slider.dart';
import 'package:albassel_version_1/my_model/top_category.dart';
import 'package:albassel_version_1/my_model/category.dart';

class StartUpResponse {
  final int code;
  final String message;
  final StartUp data;

  StartUpResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory StartUpResponse.fromJson(Map<String, dynamic> json) {
    return StartUpResponse(
      code: json['code'] as int,
      message: json['message'] as String,
      data: StartUp.fromMap(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.toJson(),
    };
  }
}
class StartUp {
  StartUp({
    required this.category,
    required this.topCategories,
    required this.slider,
    required this.bestSellers,
    required this.brand,
    required this.marquee,
  });

  List<Category> category;
  List<TopCategory> topCategories;
  List<MySlider> slider;
  List<Product> bestSellers;
  List<Brand> brand;
  List<Marquee> marquee;

  factory StartUp.fromJson(String str) => StartUp.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StartUp.fromMap(Map<String, dynamic> json) => StartUp(
    category: List<Category>.from(json["category"].map((x) => Category.fromMap(x))),
    topCategories: List<TopCategory>.from(json["top_categories"].map((x) => TopCategory.fromMap(x))),
    slider: List<MySlider>.from(json["slider"].map((x) => MySlider.fromMap(x))),
    bestSellers: List<Product>.from(json["best_sellers"].map((x) => Product.fromJson(x))),
    brand: List<Brand>.from(json["brand"].map((x) => Brand.fromMap(x))),
    marquee: List<Marquee>.from(json["marquee"].map((x) => Marquee.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "category": List<dynamic>.from(category.map((x) => x.toMap())),
    "top_categories": List<dynamic>.from(topCategories.map((x) => x.toMap())),
    "slider": List<dynamic>.from(slider.map((x) => x.toMap())),
    "best_sellers": List<dynamic>.from(bestSellers.map((x) => x.toJson())),
    "brand": List<dynamic>.from(brand.map((x) => x.toMap())),
  };
}