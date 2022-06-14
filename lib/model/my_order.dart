import 'dart:convert';

import 'package:albassel_version_1/model/product.dart';
import 'package:albassel_version_1/my_model/my_product.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class MyOrder {
  Rx<MyProduct> product;
  Rx<int> quantity;
  Rx<String> price;
  Rx<String> discount="0.0".obs;

  MyOrder({required this.product,required this.quantity,required this.price});
  factory MyOrder.fromJson(String str) => MyOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyOrder.fromMap(Map<String, dynamic> json) => MyOrder(
    product: MyProduct.fromJsonForCart(json["product"]).obs,
    quantity: int.parse(json["quantity"].toString()).obs,
    price: json["price"].toString().obs,
  );

  Map<String, dynamic> toMap() => {
    "product": product.value,
    "quantity": quantity.value,
    "price": price.value,
  };

}

class LineItem {
  int id;
  int quantity;

  LineItem({required this.id, required this.quantity});

  factory LineItem.fromJson(String str) => LineItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LineItem.fromMap(Map<String, dynamic> json) => LineItem(
    id: json['id'],
    quantity: json['quantity'],
  );

  Map<String, dynamic> toMap() => {
    "quantity": quantity,
    "id": id,
  };
}