// To parse this JSON data, do
//
//     final autoDiscount = autoDiscountFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class AutoDiscount {
  AutoDiscount({
    required this.id,
    required this.title,
    required this.productId,
    required this.isActive,
    required this.minimumQuantity,
    required this.products,
    required this.is_product,
    required this.brand_id,
    required this.category_id,
    required this.sub_category_id,
  });

  int id;
  String title;
  int productId;
  int isActive;
  int minimumQuantity;
  int is_product;
  int brand_id;
  int category_id;
  int sub_category_id;
  List<Product> products;

  factory AutoDiscount.fromJson(String str) => AutoDiscount.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AutoDiscount.fromMap(Map<String, dynamic> json) => AutoDiscount(
    id: json["id"],
    title: json["title"],
    productId: json["product_id"]==null?-1:json["product_id"],
    isActive: json["is_active"],
    minimumQuantity: json["minimum_quantity"],
    is_product: json["is_product"],
    brand_id: json["brand_id"]==null?-1:json["brand_id"],
    category_id: json["category_id"]==null?-1:json["category_id"],
    sub_category_id: json["sub_category_id"]==null?-1:json["sub_category_id"],
    products: List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "product_id": productId,
    "is_active": isActive,
    "minimum_quantity": minimumQuantity,
    "products": List<dynamic>.from(products.map((x) => x.toMap())),
  };
}

class Product {
  Product({
    required this.id,
    required this.autoDiscountId,
    required this.productId,
    required this.subCategoryId,
    required this.brandId,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.price,
    required this.rate,
    required this.image,
    required this.ratingCount,
    required this.newArrivials,
    required this.availability,
    required this.sku,
    required this.shopifyId,
    required this.offerPrice,
    required this.count,
  });

  int id;
  int autoDiscountId;
  int productId;
  int subCategoryId;
  int brandId;
  String title;
  String subTitle;
  String description;
  double price;
  double rate;
  String image;
  int ratingCount;
  int newArrivials;
  int availability;
  String sku;
  dynamic shopifyId;
  double? offerPrice;
  int count;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"],
    autoDiscountId: json["auto_discount_id"],
    productId: json["product_id"],
    subCategoryId: json["sub_category_id"]??1,
    brandId: json["brand_id"]??1,
    title: json["title"],
    subTitle: json["sub_title"],
    description: json["description"],
    price: double.parse(json["price"].toString()),
    rate: json["rate"].toDouble(),
    image: json["image"],
    ratingCount: json["rating_count"],
    newArrivials: json["new_arrivials"]??0,
    availability: json["availability"],
    sku: json["sku"],
    shopifyId: json["shopify_id"],
    offerPrice: json["offer_price"]==null?null:double.parse(json["offer_price"].toString()),
    count: json["count"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "auto_discount_id": autoDiscountId,
    "product_id": productId,
    "sub_category_id": subCategoryId,
    "brand_id": brandId,
    "title": title,
    "sub_title": subTitle,
    "description": description,
    "price": price,
    "rate": rate,
    "image": image,
    "rating_count": ratingCount,
    "new_arrivials": newArrivials,
    "availability": availability,
    "sku": sku,
    "shopify_id": shopifyId,
    "offer_price": offerPrice,
    "count": count,
  };
}
