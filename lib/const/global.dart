import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/main.dart';
import 'package:albassel_version_1/my_model/auto_discount.dart';
import 'package:albassel_version_1/my_model/my_product.dart';
import 'package:albassel_version_1/my_model/shipping.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:albassel_version_1/model/log_in_info.dart';
import 'package:albassel_version_1/my_model/customer.dart';
import 'package:albassel_version_1/model/customer.dart';
import 'package:albassel_version_1/model_v2/product.dart' as modelV2;

import '../my_model/address.dart';
import 'dart:ui' as ui;

class Global{
  static String firebase_token = '';
  static List<modelV2.Product> suggestion_list = <modelV2.Product>[];
  static String lang_code="en";
  static int customer_type=0;
  static int customer_type_decoder=0;
  static LogInInfo? logInInfo;
  static MyCustomer? customer;
  static Address? address;
  static bool remember_pass=false;
  static String remember_password="non";
  static String remember_email="non";
  static String? discountCode;
  // static List<AutoDiscount> auto_discounts = <AutoDiscount>[];
  static save_language(String locale){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("lang", locale);
    });
  }

  static Widget cartCircleCount(){
    CartController cartController = Get.find();
    if(cartController.cart != null){
      return Obx(()=>
          CircleAvatar(
              radius: 8,
              backgroundColor: cartController.cartLength.value == 0?Colors.transparent:Colors.red,
              child: Text(cartController.cartLength.value.toString(),style: App.textNormal(cartController.cartLength.value == 0?Colors.transparent: Colors.white, 10),)));
    }else{
      return Center();
    }
  }

  static Future<String> load_language()async{
    try{
      SharedPreferences prefs= await SharedPreferences.getInstance();
      String lang=prefs.getString("lang")??'def';
      if(lang!="def"){
        Global.lang_code=lang;
      }else{
        if(ui.PlatformDispatcher.instance.locale.languageCode == 'en' ||
            ui.PlatformDispatcher.instance.locale.languageCode == 'ar'){
          Global.lang_code=ui.PlatformDispatcher.instance.locale.languageCode;
        }else{
          Global.lang_code="en";
        }
      }
      return Global.lang_code;
    }catch(e){
      return "en";
    }
  }
}