import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:albassel_version_1/helper/api.dart';
import 'package:albassel_version_1/helper/log_in_api.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/view/home.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:albassel_version_1/view/verification_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VerificationCodeController extends GetxController{

  var loading = false.obs;
  var code_vaildate = true.obs;

  resend(BuildContext context){
    try{
      loading.value=true;
      Store.loadLogInInfo().then((info) {
        MyApi.resend_code(info.email).then((result) {
          loading.value=false;
          if(result.succses){
            App.sucss_msg(context, App_Localization.of(context).translate("resend_succ"));
          }else{
            App.error_msg(context, App_Localization.of(context).translate("wrong"));
          }
        });
      });
    }catch(e){
      loading.value=false;
      App.error_msg(context, App_Localization.of(context).translate("wrong"));
    }

  }

  verificate(BuildContext context,String code){
    try{
      if(code.isEmpty){
        code_vaildate.value=false;
      }else{
        code_vaildate.value=true;
        loading.value=true;
        Store.loadLogInInfo().then((info) {
          MyApi.verify_code(info.email,code).then((result) async{
            loading.value=false;
            final packageInfo = await PackageInfo.fromPlatform();
            MyApi.login(info.email,info.pass,Global.firebase_token,packageInfo.version);
            if(result.succses){
              App.sucss_msg(context, App_Localization.of(context).translate("mail_verificated"));

              WishListController wishListController = Get.put(WishListController());
              CartController cartController = Get.put(CartController());
              wishListController.getData();
              cartController.getData(null);

              Get.offAll(()=>Home());
            }else{
              App.error_msg(context, App_Localization.of(context).translate("wrong"));
            }
          });
        });
      }
    }catch(e){
      loading.value=false;
      App.error_msg(context, App_Localization.of(context).translate("wrong"));
    }

  }

}
