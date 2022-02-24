// To parse this JSON data, do
//
//     final customerOrder = customerOrderFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CustomerOrder {
  CustomerOrder({
    required this.id,
    required this.customerId,
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.apartment,
    required this.country,
    required this.emirate,
    required this.phone,
    required this.details,
    required this.subTotal,
    required this.shipping,
    required this.total,
    required this.isPaid,
    required this.deliver,
    required this.date,
    required this.code,
  });

  int id;
  int customerId;
  String firstname;
  String lastname;
  String address;
  String apartment;
  String country;
  String emirate;
  String phone;
  String details;
  int subTotal;
  int shipping;
  int total;
  int isPaid;
  int deliver;
  var date ;
  String code;

  factory CustomerOrder.fromJson(String str) => CustomerOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerOrder.fromMap(Map<String, dynamic> json) => CustomerOrder(
    id: json["id"],
    customerId: json["customer_id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    address: json["address"],
    apartment: json["apartment"],
    country: json["country"],
    emirate: json["emirate"],
    phone: json["phone"],
    details: json["details"],
    subTotal: json["sub_total"],
    shipping: json["shipping"],
    total: json["total"],
    isPaid: json["is_paid"],
    deliver: json["deliver"],
    date: DateTime.parse(json["created_at"]),
    code: json["code"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "customer_id": customerId,
    "firstname": firstname,
    "lastname": lastname,
    "address": address,
    "apartment": apartment,
    "country": country,
    "emirate": emirate,
    "phone": phone,
    "details": details,
    "sub_total": subTotal,
    "shipping": shipping,
    "total": total,
    "is_paid": isPaid,
  };
}
