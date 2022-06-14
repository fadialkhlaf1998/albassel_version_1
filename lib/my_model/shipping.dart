// To parse this JSON data, do
//
//     final shipping = shippingFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Shipping {
  Shipping({
    required this.amount,
    required this.minAmountFree,
  });

  double amount;
  double minAmountFree;

  factory Shipping.fromJson(String str) => Shipping.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Shipping.fromMap(Map<String, dynamic> json) => Shipping(
    amount: double.parse(json["amount"].toString()),
    minAmountFree: double.parse(json["min_amount_free"].toString()),
  );

  Map<String, dynamic> toMap() => {
    "amount": amount,
    "min_amount_free": minAmountFree,
  };
}
