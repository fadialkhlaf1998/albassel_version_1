// To parse this JSON data, do
//
//     final bestSellers = bestSellersFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class BestSellers {
  BestSellers({
    required this.id,
    required this.productId,
    required this.product,
  });

  int id;
  int productId;
  String product;


  factory BestSellers.fromJson(String str) => BestSellers.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BestSellers.fromMap(Map<String, dynamic> json) => BestSellers(
    id: json["id"],
    productId: json["product_id"],
    product: json["product"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "product_id": productId,
    "product": product,
  };
}
