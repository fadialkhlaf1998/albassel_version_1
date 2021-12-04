import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/helper/api.dart';
import 'package:albassel_version_1/helper/log_in_api.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/view/home.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:albassel_version_1/view/verification_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerificationCodeController extends GetxController{

  var loading = false.obs;
  var code_vaildate = true.obs;

  resend(BuildContext context){
    try{
     Api.check_internet().then((net) {
       if(net){
         loading.value=true;
         Store.loadLogInInfo().then((info) {
           LogInApi.resend_code(info.email).then((result) {
             loading.value=false;
             if(result.succses){
               App.sucss_msg(context, result.message);
             }else{
               App.error_msg(context, result.message);
             }
           });
         });
       }else{
         Get.to(()=>NoInternet())!.then((value) {
           resend(context);
         });
       }
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
        Api.check_internet().then((net) {
          if(net){
            code_vaildate.value=true;
            loading.value=true;
            Store.loadLogInInfo().then((info) {
              LogInApi.verify_code(info.email,code).then((result) {
                loading.value=false;
                if(result.succses){
                  App.sucss_msg(context, result.message);
                  Store.save_verificat();
                  Get.offAll(()=>Home());
                }else{
                  App.error_msg(context, result.message);
                }
              });
            });
          }else{
            Get.to(()=>NoInternet())!.then((value) {
              verificate(context,code);
            });
          }
        });
      }
    }catch(e){
      loading.value=false;
      App.error_msg(context, App_Localization.of(context).translate("wrong"));
    }

  }

}
