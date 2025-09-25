
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingController extends GetxController{
  var value = "English".obs;
  @override
  Future<void> onInit() async {
    if(Global.lang_code=="ar"){
      value.value="العربية";
    }else{
      value.value="English";
    }
    super.onInit();
  }
  change_lang(BuildContext context,String lang){
    MyApp.set_local(context, Locale(lang));
    Get.updateLocale(Locale(lang));
    Global.save_language(lang);
    Global.load_language();
    Global.lang_code = lang;
    HomeController homeController = Get.find();
    homeController.addMarqueeText();
  }
}