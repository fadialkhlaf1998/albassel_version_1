// To parse this JSON data, do
//
//     final Marquees = MarqueesFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Marquee {
  Marquee({
    required this.id,
    required this.text,
  });

  int id;
  String text;

  factory Marquee.fromJson(String str) => Marquee.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Marquee.fromMap(Map<String, dynamic> json) => Marquee(
    id: json["id"],
    text: json["text"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "text": text,
  };
}
