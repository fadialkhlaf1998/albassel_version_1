import 'dart:developer';

import 'package:albassel_version_1/model/log_in_info.dart';
import 'package:albassel_version_1/model/my_order.dart';
import 'package:albassel_version_1/model/order.dart';
import 'package:albassel_version_1/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Store{
  static save_order(List<MyOrder> myOrder){
    Order order= Order();
    order.lineItems=<OrderLineItem>[];
    for(var elm in myOrder){
      bool shipping=false;
      if(double.parse(elm.shipping.value)>0){
        shipping = true;
      }
      order.lineItems!.add(OrderLineItem(product: Product.fromJson(elm.product.value.toJson()),quantity: elm.quantity.value,price: elm.price.value,productId: elm.product.value.id,requiresShipping: shipping));
    }
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("my_order", order.toJson());
    });
  }

  static Future<List<MyOrder>> load_order()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = prefs.getString("my_order")??"non";
    if(json=="non"){
      return <MyOrder>[];
    }else{
      List<MyOrder> myorder=<MyOrder>[];
      Order order = Order.fromJson(json);
      for(var elm in order.lineItems!){
        myorder.add(MyOrder(elm.product!.obs,elm.quantity!.obs,elm.price!.obs,"0.00".obs));
      }
      return myorder;
    }
  }

  static save_wishlist(List<Product> _products){
    SharedPreferences.getInstance().then((prefs) {
      Products products = Products();
      products.products=_products;
      prefs.setString("wishlist", products.toJson());
    });
  }

  static Future<List<Product>> load_wishlist()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = prefs.getString("wishlist")??"non";
    if(json=="non"){
      return <Product>[];
    }else{
      Products _products = Products.fromJson(json);
      return _products.products!;
    }
  }

  static saveLoginInfo(String email,String pass){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("email", email);
      prefs.setString("pass", pass);
    });
  }

  static logout(){
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove("email");
      prefs.remove("pass");
      prefs.remove("verificat");
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
}