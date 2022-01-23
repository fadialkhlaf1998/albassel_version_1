import 'dart:convert';
import 'dart:developer';

import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/model/log_in_info.dart';
import 'package:albassel_version_1/model/my_order.dart';
import 'package:albassel_version_1/model/order.dart';
import 'package:albassel_version_1/model/product.dart';
import 'package:albassel_version_1/my_model/address.dart';
import 'package:albassel_version_1/my_model/my_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Store{
  static save_order(List<MyOrder> myOrder){
    String myjson = json.encode(List<dynamic>.from(myOrder.map((x) => x.toMap())));
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("my_order", myjson);
    });
  }

  static Future<List<MyOrder>> load_order()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myjson = prefs.getString("my_order")??"non";
    if(myjson=="non"){
      return <MyOrder>[];
    }else{
      var jsonlist = jsonDecode(myjson) as List;
      List<MyOrder> list = <MyOrder>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(MyOrder.fromMap(jsonlist[i]));
      }
      return list;
    }
  }

  static save_wishlist(List<MyProduct> _products){
    SharedPreferences.getInstance().then((prefs) {
      String myjson = json.encode(List<dynamic>.from(_products.map((x) => x.toMap())));
      prefs.setString("wishlist", myjson);
      load_wishlist();
    });
  }

  static save_recently(List<MyProduct> _products){
    SharedPreferences.getInstance().then((prefs) {
      String myjson = json.encode(List<dynamic>.from(_products.map((x) => x.toMap())));
      prefs.setString("recently", myjson);
      load_wishlist();
    });
  }

  static save_rate(List<MyProduct> _products){
    SharedPreferences.getInstance().then((prefs) {
      String myjson = json.encode(List<dynamic>.from(_products.map((x) => x.toMap())));
      prefs.setString("rate", myjson);
      load_wishlist();
    });
  }
  static save_remember(bool val){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("remember", val);
      Global.remember_pass=val;
    });
  }

  static Future<bool> load_remember()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool val = prefs.getBool("remember")??false;
    String pass = prefs.getString("remember_pass")??"non";
    Global.remember_password=pass;
    Global.remember_pass=val;
    return val;
  }

  static Future<List<MyProduct>> load_recently()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString("recently")??"non";
    if(jsonString=="non"){
      return <MyProduct>[];
    }else{
      var jsonlist = jsonDecode(jsonString) as List;
      List<MyProduct> list = <MyProduct>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(MyProduct.fromMap(jsonlist[i]));
      }
      return list;
    }
  }

  static Future<List<MyProduct>> load_rate()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString("rate")??"non";
    if(jsonString=="non"){
      return <MyProduct>[];
    }else{
      var jsonlist = jsonDecode(jsonString) as List;
      List<MyProduct> list = <MyProduct>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(MyProduct.fromMap(jsonlist[i]));
      }
      return list;
    }
  }



  static Future<List<MyProduct>> load_wishlist()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString("wishlist")??"non";
    if(jsonString=="non"){
      return <MyProduct>[];
    }else{
      var jsonlist = jsonDecode(jsonString) as List;
      List<MyProduct> list = <MyProduct>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(MyProduct.fromMap(jsonlist[i]));
      }
      return list;
    }
  }

  static saveLoginInfo(String email,String pass){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("email", email);
      prefs.setString("pass", pass);
      prefs.setString("remember_pass", pass);
    });
  }

  static logout(){
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove("email");
      prefs.remove("pass");
      prefs.remove("verificat");
      Global.customer=null;
    });
  }

  static Future<LogInInfo> loadLogInInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email")??"non";
    String pass = prefs.getString("pass")??"non";
    return LogInInfo(email, pass);
  }
  static save_verificat(){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("verificat", true);
    });
  }

  static Future<bool> load_verificat()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool val = prefs.getBool("verificat")??false;
    return val;
  }

  static save_address(Address address){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("addresses", address.toJson());
      Global.address=address;
    });
  }

  static load_address()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? val = prefs.getString("addresses")??null;
    if(val!=null){
      Global.address=Address.fromJson(val);
    }
  }

}