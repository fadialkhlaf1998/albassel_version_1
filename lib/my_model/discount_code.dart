// To parse this JSON data, do
//
//     final discountCode = discountCodeFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class DiscountCode {
  DiscountCode({
    required this.id,
    required this.code,
    required this.minimumQuantity,
    required this.isActive,
    required this.forAll,
    required this.amount,
    required this.products,
    required this.category,
    required this.brands,
    required this.subCategory,
    required this.customer_type,
    required this.persent,
  });

  int id;
  String code;
  int minimumQuantity;
  int isActive;
  int forAll;
  int amount;
  int persent;
  int customer_type;
  List<DCProduct> products;
  List<DCCategory> category;
  List<DCBrand> brands;
  List<DCSubCategory> subCategory;

  factory DiscountCode.fromJson(String str) => DiscountCode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DiscountCode.fromMap(Map<String, dynamic> json) => DiscountCode(
    id: json["id"],
    code: json["code"],
    minimumQuantity: json["minimum_quantity"],
    isActive: json["is_active"],
    forAll: json["for_all"],
    amount: json["amount"]==null?0.0:json["amount"],
    customer_type: json["customer_type"],
    persent: json["persent"]==null?0.0:json["persent"],
    products: List<DCProduct>.from(json["products"].map((x) => DCProduct.fromMap(x))),
    category: List<DCCategory>.from(json["category"].map((x) => DCCategory.fromMap(x))),
    brands: List<DCBrand>.from(json["brands"].map((x) => DCBrand.fromMap(x))),
    subCategory: List<DCSubCategory>.from(json["sub_category"].map((x) => DCSubCategory.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "code": code,
    "minimum_quantity": minimumQuantity,
    "is_active": isActive,
    "for_all": forAll,
    "amount": amount,
    "persent": persent,
    "customer_type": customer_type,
    "products": List<dynamic>.from(products.map((x) => x.toMap())),
    "category": List<dynamic>.from(category.map((x) => x.toMap())),
    "brands": List<dynamic>.from(brands.map((x) => x.toMap())),
    "sub_category": List<dynamic>.from(subCategory.map((x) => x.toMap())),
  };
}

class DCBrand {
  DCBrand({
    required this.brandId,
    required this.title,
  });

  int brandId;
  String title;

  factory DCBrand.fromJson(String str) => DCBrand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DCBrand.fromMap(Map<String, dynamic> json) => DCBrand(
    brandId: json["brand_id"],
    title: json["title"],
  );

  Map<String, dynamic> toMap() => {
    "brand_id": brandId,
    "title": title,
  };
}

class DCCategory {
  DCCategory({
    required this.categoryId,
    required this.title,
  });

  int categoryId;
  String title;

  factory DCCategory.fromJson(String str) => DCCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DCCategory.fromMap(Map<String, dynamic> json) => DCCategory(
    categoryId: json["category_id"],
    title: json["title"],
  );

  Map<String, dynamic> toMap() => {
    "category_id": categoryId,
    "title": title,
  };
}

class DCProduct {
  DCProduct({
    required this.productId,
    required this.title,
  });

  int productId;
  String title;

  factory DCProduct.fromJson(String str) => DCProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DCProduct.fromMap(Map<String, dynamic> json) => DCProduct(
    productId: json["product_id"],
    title: json["title"],
  );

  Map<String, dynamic> toMap() => {
    "product_id": productId,
    "title": title,
  };
}

class DCSubCategory {
  DCSubCategory({
    required this.subCategoryId,
    required this.title,
  });

  int subCategoryId;
  String title;

  factory DCSubCategory.fromJson(String str) => DCSubCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DCSubCategory.fromMap(Map<String, dynamic> json) => DCSubCategory(
    subCategoryId: json["sub_category_id"],
    title: json["title"],
  );

  Map<String, dynamic> toMap() => {
    "sub_category_id": subCategoryId,
    "title": title,
  };
}

class DCSuperCategory {
  DCSuperCategory({
    required this.superCategoryId,
    required this.title,
  });

  int superCategoryId;
  String title;

  factory DCSuperCategory.fromJson(String str) => DCSuperCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DCSuperCategory.fromMap(Map<String, dynamic> json) => DCSuperCategory(
    superCategoryId: json["super_category_id"],
    title: json["title"],
  );

  Map<String, dynamic> toMap() => {
    "super_category_id": superCategoryId,
    "title": title,
  };
}
