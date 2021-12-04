import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/helper/api.dart';
import 'package:albassel_version_1/helper/log_in_api.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:albassel_version_1/view/verification_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
 var hide_passeord=true.obs;
 var loading = false.obs;
 var email_vaildate = true.obs;
 var pass_vaildate = true.obs;
 var fname_vaildate = true.obs;
 var lname_vaildate = true.obs;

 void change_visibilty(){
  hide_passeord.value = !hide_passeord.value;
 }
 signUp(BuildContext context,String email,String pass,String fname,String lname){
  try{
   if(email.isEmpty||pass.isEmpty||fname.isEmpty||lname.isEmpty){
    if(email.isEmpty){
     email_vaildate.value=false;
    }else{
     email_vaildate.value=true;
    }
    if(pass.isEmpty){
     pass_vaildate.value=false;
    }else{
     pass_vaildate.value=true;
    }

    if(fname.isEmpty){
     fname_vaildate.value=false;
    }else{
     fname_vaildate.value=true;
    }
    if(lname.isEmpty){
     lname_vaildate.value=false;
    }else{
     lname_vaildate.value=true;
    }
   }else{
    Api.check_internet().then((net) {
     if(net){
      loading.value=true;
      LogInApi.sign_up(email, pass).then((value) {

       if(value.succses){
        Store.saveLoginInfo(email, pass);
        Api.add_customer(fname,lname,email).then((customer){
         print('*************');
         print(customer!.email!);
         Global.customer=customer;
         App.sucss_msg(context, value.message);
         loading.value=false;
         Get.offAll(() => VerificationCode());
        });
        //verrification code
        //Get.to(() => Home());
       }else{
        loading.value=false;
        App.error_msg(context, value.message);
       }
      });
     }else{
      Get.to(()=>NoInternet())!.then((value) {
       signUp(context,email,pass,fname,lname);
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