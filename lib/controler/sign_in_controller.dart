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

class SignInController extends GetxController{

  var hide_passeord=true.obs;
  var loading = false.obs;
  var email_vaildate = true.obs;
  var pass_vaildate = true.obs;

  void change_visibilty(){
    hide_passeord.value = !hide_passeord.value;
  }

  signIn(BuildContext context,String email,String pass){
    try{
      if(email.isEmpty||pass.isEmpty){
        if(email.isEmpty){
          email_vaildate.value=false;
        }
        if(pass.isEmpty){
          pass_vaildate.value=false;
        }
      }else{
        Api.check_internet().then((net) {
          if(net){
            loading.value=true;
            LogInApi.login(email, pass).then((value) {
              if(value.succses){
                Store.saveLoginInfo(email, pass);
                App.sucss_msg(context, value.message);
                Api.login_customers(email).then((customer){
                  loading.value=false;
                  Global.customer=customer;
                  Get.to(()=>Home());
                });

              }else{
                loading.value=false;
                App.error_msg(context, value.message);
              }
            });
          }else{
            Get.to(()=>NoInternet())!.then((value) {
              signIn(context,email,pass);
            });
          }
        });

      }

    }catch (e){
      loading.value=false;
      App.error_msg(context, App_Localization.of(context).translate("wrong"));
    }
    
  }

  forget_pass(BuildContext context,String email){
    try{
      if(email.isEmpty){
        email_vaildate.value=false;
      } else{
        Api.check_internet().then((net) {
          if(net){
            email_vaildate.value=true;
            loading.value=true;
            LogInApi.forget_password(email).then((value) {
              loading.value=false;
              if(value.succses){
                App.sucss_msg(context, value.message);
              }else{
                App.error_msg(context, value.message);
              }
            });
          }else{
            Get.to(()=>NoInternet())!.then((value) {
              forget_pass(context,email);
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