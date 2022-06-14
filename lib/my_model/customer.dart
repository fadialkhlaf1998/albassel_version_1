// To parse this JSON data, do
//
//     final result = resultFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Result {
  Result({
    required this.state,
    required this.message,
    required this.data,
  });

  int state;
  String message;
  List<MyCustomer> data;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
    state: json["state"],
    message: json["message"],
    data: List<MyCustomer>.from(json["data"].map((x) => MyCustomer.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "state": state,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class MyCustomer {
  MyCustomer({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.code,
    required this.isActive,
    required this.pass,
    required this.customer_type,
    required this.phone,
    required this.country,
  });

  int id;
  String email;
  String firstname;
  String lastname;
  int customer_type;
  int code;
  int isActive;
  String pass;
  String phone;
  String country;

  factory MyCustomer.fromJson(String str) => MyCustomer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyCustomer.fromMap(Map<String, dynamic> json) => MyCustomer(
    id: json["id"],
    email: json["email"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    code: json["code"],
    isActive: json["is_active"],
    pass: json["pass"],
    customer_type: json["customer_type"]??0,
    country: json["country"]??"non",
    phone: json["phone"]??"non",
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "email": email,
    "firstname": firstname,
    "lastname": lastname,
    "code": code,
    "is_active": isActive,
    "pass": pass,
    "customer_type": customer_type,
    "country": country,
    "phone": phone,
  };
}
