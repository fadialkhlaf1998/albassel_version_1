// To parse this JSON data, do
//
//     final Marquees = MarqueesFromMap(jsonString);

import 'package:albassel_version_1/const/global.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class Marquee {
  Marquee({
    required this.id,
    required this.text,
    required this.arText,
  });

  int id;
  String text;
  String arText;

  getText(){
    if(Global.lang_code == "en"){
      return text;
    }else{
      return arText;
    }
  }

  factory Marquee.fromJson(String str) => Marquee.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Marquee.fromMap(Map<String, dynamic> json) => Marquee(
    id: json["id"],
    text: json["text"],
    arText: json["ar_text"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "text": text,
    "ar_text": arText,
  };
}
