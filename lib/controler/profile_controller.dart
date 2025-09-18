import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/helper/api.dart';
import 'package:albassel_version_1/helper/log_in_api.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  var openNewPass = false.obs;
  var validateNewPass = true.obs;
  var validateConfNewPass = true.obs;
  var loading = false.obs;
  HomeController homeController = Get.find();

  change_password(BuildContext context,String pass,String confPass){
    if(pass.isEmpty||confPass.isEmpty){
      if(pass.isEmpty){
        validateNewPass.value=false;
      }else{
        validateNewPass.value=true;
      }

      if(confPass.isEmpty){
        validateConfNewPass.value=false;
      }else{
        validateConfNewPass.value=true;
      }
    }else{
      if(pass==confPass&&pass.length>=6){
        validateConfNewPass.value=true;
        validateNewPass.value=true;
        loading.value=true;
        MyApi.change_password(Global.customer!.email, pass).then((result) {
          loading.value=false;
          if(result.succses){
            App.sucss_msg(context, App_Localization.of(context).translate("pass"));
          }else{
            App.error_msg(context, App_Localization.of(context).translate("wrong"));
          }
        });
      }else{
        if(pass.length<6){
          App.error_msg(
              context, App_Localization.of(context).translate("small_pass"));
        }else if(confPass.length<6){
          App.error_msg(
          context, App_Localization.of(context).translate("small_pass"));
        }else {
          App.error_msg(
              context, App_Localization.of(context).translate("conf_eq_pass"));
        }
      }
    }
  }

  Future <bool> deleteAccount(BuildContext context)async{
    loading.value=true;

    var result = await MyApi.delete_acount();
    homeController.nave_to_logout();
    loading.value=false;
    return true;
  }
}