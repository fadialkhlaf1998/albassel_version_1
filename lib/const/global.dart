import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/main.dart';
import 'package:albassel_version_1/my_model/auto_discount.dart';
import 'package:albassel_version_1/my_model/shipping.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:albassel_version_1/model/log_in_info.dart';
import 'package:albassel_version_1/my_model/customer.dart';
import 'package:albassel_version_1/model/customer.dart';

import '../my_model/address.dart';

class Global{
  static Shipping shipping = Shipping(amount: 10, minAmountFree: 250,emirate: "");
  static List<Shipping> new_shipping = <Shipping>[];
  static String lang_code="en";
  static int customer_type=0;
  static int customer_type_decoder=0;
  static LogInInfo? logInInfo;
  static MyCustomer? customer;
  static Address? address;
  static bool remember_pass=false;
  static String remember_password="non";
  static String remember_email="non";
  static List<AutoDiscount> auto_discounts = <AutoDiscount>[];
  static save_language(String locale){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("lang", locale);
    });
  }



  static Future<String> load_language()async{
    try{
      SharedPreferences prefs= await SharedPreferences.getInstance();
      String lang=prefs.getString("lang")??'def';
      if(lang!="def"){
        Global.lang_code=lang;
      }else{
        Global.lang_code="en";
      }
      return Global.lang_code;
    }catch(e){

      return "en";
    }

  }
}