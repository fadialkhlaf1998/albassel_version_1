import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/controler/intro_controller.dart';
import 'package:albassel_version_1/helper/api.dart';
import 'package:albassel_version_1/helper/log_in_api.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/my_model/start_up.dart';
import 'package:albassel_version_1/view/home.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:albassel_version_1/view/verification_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SignInController extends GetxController{

  var hide_passeord=true.obs;
  var loading = false.obs;
  var email_vaildate = true.obs;
  var pass_vaildate = true.obs;
  var remember_value = Global.remember_pass.obs;
  IntroController introController = Get.find();
  HomeController homeController = Get.put(HomeController());

  void change_visibilty(){
    hide_passeord.value = !hide_passeord.value;
  }

  signIn(BuildContext context,String email,String pass,bool is_home){
    try{
      if(email.isEmpty||pass.isEmpty||!RegExp(r'\S+@\S+\.\S+').hasMatch(email)){
        if(email.isEmpty||!RegExp(r'\S+@\S+\.\S+').hasMatch(email)){
          email_vaildate.value=false;
        }
        if(pass.isEmpty){
          pass_vaildate.value=false;
        }
      }else{
        MyApi.check_internet().then((net) async{
          if(net){
            loading.value=true;
            final packageInfo = await PackageInfo.fromPlatform();
            MyApi.login(email, pass,Global.firebase_token,packageInfo.version).then((value) async{
              if(value.state==200){
                Store.saveLoginInfo(email, pass);
                App.sucss_msg(context,App_Localization.of(context).translate("login_succ"));
                // MyApi.login(email,pass).then((result){
                //
                //
                // });


                Global.customer=value.data.first;

                if(Global.customer_type_decoder != 0){
                  await homeController.updateBestSellersSubCategory();
                }
                loading.value=false;
                Get.offAll(()=>Home());

              }else{
                loading.value=false;
                App.error_msg(context, App_Localization.of(context).translate("wrong_mail"));
              }
            });
          }else{
            Get.to(()=>NoInternet())!.then((value) {
              signIn(context,email,pass,is_home);
            });
          }
        });

      }

    }catch (e){
      print(e.toString());
      loading.value=false;
      App.error_msg(context, App_Localization.of(context).translate("wrong"));
    }
    
  }

  forget_pass(BuildContext context,String email){
    try{
      if(email.isEmpty||!RegExp(r'\S+@\S+\.\S+').hasMatch(email)){
        if(email.isEmpty){
          App.error_msg(context, App_Localization.of(context).translate("enter_mail"));
        }
        email_vaildate.value=false;
      } else{
        MyApi.check_internet().then((net) {
          if(net){
            email_vaildate.value=true;
            loading.value=true;
            MyApi.forget_password(email).then((value) {
              loading.value=false;
              if(value.succses){
                App.sucss_msg(context, App_Localization.of(context).translate("resend_pass_succ"));
              }else{
                App.error_msg(context, App_Localization.of(context).translate("wrong"));
              }
            })
            .catchError((value){
              loading.value=false;
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