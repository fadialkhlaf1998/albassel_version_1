// To parse this JSON data, do
//
//     final myProduct = myProductFromMap(jsonString);

import 'package:albassel_version_1/const/global.dart';
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
    required this.offer_price,
    required this.category_id,
    this.count,
    required this.sku,
  });

  int id;
  int subCategoryId;
  int category_id;
  int brandId;
  String title;
  String subTitle;
  String description;
  double price;
  double? offer_price;
  double rate;
  String image;
  String sku;
  int ratingCount;
  int availability;
  var favorite=false.obs;
  int? count;
  factory MyProduct.fromJsonForCart(String str) => MyProduct.fromMapForCart(json.decode(str));
  factory MyProduct.fromMapForCart(Map<String, dynamic> json) {

    return MyProduct(
        id: json["id"],
        sku: json["sku"]==null?"":json["sku"],
        subCategoryId: json["sub_category_id"] ?? -1,
        brandId: json["brand_id"] ?? -1,
        title: json["title"],
        subTitle: json["sub_title"],
        description: json["description"],
        price:  Global.customer_type_decoder==0?double.parse(json["price"].toString()):Global.customer_type_decoder==1?double.parse(json["salon_price"].toString()):double.parse(json["whole_saller_price"].toString()),
        offer_price: json["offer_price"]==null?null:double.parse(json["offer_price"].toString()),
        rate: double.parse(json["rate"].toString()),
        image: json["image"],
        ratingCount: json["rating_count"],
        category_id: json["category_id"] ?? -1,
        availability: json["availability"]==null?0:json["availability"]<0?0:json["availability"],
        // availability: 10,
        count: json["count"]==null?1:json["count"]
    );
  }

  factory MyProduct.fromJson(String str) => MyProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyProduct.fromMap(Map<String, dynamic> json) {
    return MyProduct(
    id: json["id"],
    sku: json["sku"],
    subCategoryId: json["sub_category_id"] ?? 1,
    brandId: json["brand_id"] ?? 1,
    title: json["title"],
    subTitle: json["sub_title"],
    description: json["description"],
      price: Global.customer_type_decoder==0?double.parse(json["price"].toString()):Global.customer_type_decoder==1?double.parse(json["salon_price"]==null?"0.0":json["salon_price"].toString()):double.parse(json["whole_saller_price"].toString()),
      offer_price: json["offer_price"]==null?null:double.parse(json["offer_price"].toString()),
    rate: double.parse(json["rate"].toString()),
    image: json["image"],
    ratingCount: json["rating_count"],
      category_id: json["category_id"] ?? 1,
    // availability: json["availability"]==null?0:json["availability"],
        availability:   json["availability"]==null?0:json["availability"]<0?0:json["availability"],
    // availability: 10,
    count: json["count"]==null?1:json["count"]
  );
  }

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
    "category_id": category_id,
    "rating_count": ratingCount,
    "availability":availability,
    "offer_price":offer_price
  };
}
