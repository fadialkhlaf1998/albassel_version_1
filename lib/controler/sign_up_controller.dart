import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/helper/api.dart';
import 'package:albassel_version_1/helper/log_in_api.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/view/home.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:albassel_version_1/view/verification_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpController extends GetxController{
 var hide_passeord=true.obs;
 var loading = false.obs;
 var email_vaildate = true.obs;
 var pass_vaildate = true.obs;
 var fname_vaildate = true.obs;
 var lname_vaildate = true.obs;
 var phone_vaildate = true.obs;
 var country = "United Arab Emirates".obs;
 var country_code = "AE".obs;
 var isoCode = PhoneNumber(isoCode: "AE",dialCode: "+971").obs;

 String path = "non";

 var showCustomerType = true.obs;
 var showFileUploader = true.obs;

 setCustomerType(int type){
   Global.customer_type = type;
   showCustomerType.value=false;
   if(type==0){
    showFileUploader.value=false;
   }else{
    showFileUploader.value=true;
   }
 }

 void change_visibilty(){
  hide_passeord.value = !hide_passeord.value;
 }
 signUp(BuildContext context,String email,String pass,String fname,String lname,String phone,String country){

    try{
   if(!RegExp(r'\S+@\S+\.\S+').hasMatch(email)||email.isEmpty||pass.isEmpty||fname.isEmpty||lname.isEmpty||pass.length<6||(Global.customer_type !=0 && phone.isEmpty)){
    if(email.isEmpty||!RegExp(r'\S+@\S+\.\S+').hasMatch(email)){
     email_vaildate.value=false;
     // App.error_msg(context, App_Localization.of(context).translate("plz_vailed_email"));
    }else{
     email_vaildate.value=true;
    }
    //todo not for customer
    if(Global.customer_type !=0 && phone.isEmpty){
     phone_vaildate.value = false;
    }else{
     phone_vaildate.value = true;
    }
    if(pass.isEmpty||pass.length<6){
     if(pass.length<6&&pass.isNotEmpty){
      App.error_msg(context, App_Localization.of(context).translate("small_pass"));
      pass_vaildate.value=false;
     }
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
    loading.value=true;
    MyApi.sign_up(email, pass,fname,lname,isoCode.value.dialCode!+phone,country).then((value) async{
     if(value.state==200){
      Store.saveLoginInfo(email, pass);
      if(Global.customer_type!=0){
       await MyApi.upload_customer_file(path, value.data.first.id);
      }

      loading.value=false;
      Store.save_customer_type(Global.customer_type);
      if(Global.customer_type==0){
       App.sucss_msg(context, App_Localization.of(context).translate("sign_up_succ"));
       Get.offAll(() => VerificationCode());
      }else{
       App.sucss_msg(context, App_Localization.of(context).translate("sign_up_will_replay_mail"));
       Get.offAll(() => Home());
      }

     }else{
      loading.value=false;
      App.error_msg(context, App_Localization.of(context).translate("wrong_signup_msg"));
     }
    });
   }
  }catch(e){
   loading.value=false;
   App.error_msg(context, App_Localization.of(context).translate("wrong"));
  }
 }
}