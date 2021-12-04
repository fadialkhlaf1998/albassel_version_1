import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:albassel_version_1/model/log_in_info.dart';
import 'package:albassel_version_1/model/customer.dart';

class Global{
  static String lang_code="en";
  static LogInInfo? logInInfo;
  static Customer? customer;
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