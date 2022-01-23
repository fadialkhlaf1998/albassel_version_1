import 'dart:convert';

class Address {
  String address;
  String apartment;
  String city;
  String country;
  String Emirate;
  String phone;

  Address({
      required  this.address,
    required this.apartment,
    required this.city,
    required this.country,
    required this.Emirate,
    required this.phone});

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    address: json["address"],
    apartment: json["apartment"],
    city: json["city"],
    country: json["country"],
    Emirate: json["Emirate"],
    phone: json["phone"],
  );

  Map<String, dynamic> toMap() => {
    "address": address,
    "apartment": apartment,
    "city": city,
    "country": country,
    "Emirate": Emirate,
    "phone": phone,
  };
}