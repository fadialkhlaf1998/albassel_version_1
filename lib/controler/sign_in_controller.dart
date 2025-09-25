import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/controler/intro_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:albassel_version_1/helper/api.dart';
import 'package:albassel_version_1/helper/api_v2.dart';
import 'package:albassel_version_1/helper/log_in_api.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/my_model/start_up.dart';
import 'package:albassel_version_1/view/home.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:albassel_version_1/view/verification_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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

  Future<bool> signInWithGoogle(BuildContext context)async{
    try{
      loading(true);
      UserCredential googleData = await getGoogleUser();
      print(googleData.user);
      if(googleData.user == null){
        App.error_msg(context, App_Localization.of(context).translate("wrong"));
        loading(false);
        return false;
      }else{
        String pass = generatePassword(googleData.user!.email!.split("@")[0]);
        singInVerfied(context,googleData.user!.email!,pass,
        getFirstName(googleData.user!.displayName!),getLastName(googleData.user!.displayName!));
        return true;
      }
    }catch(e){
      App.error_msg(context, App_Localization.of(context).translate("wrong"));
      print('---------');
      print(e);
      print('---------');
      loading(false);
      return false;
    }
  }
  Future<UserCredential> getGoogleUser() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signInWithApple(BuildContext context)async {
    // https://albasel-2025-dabd5.firebaseapp.com/__/auth/handler
    try{
      loading(true);
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      if (credential.email != null) {
        // AppStyle.successMsg(context, credential.email!);
        String email = credential.email!;
        String pass = generatePassword(credential.email!.split("@")[0]);
        String name = "";
        if (credential.givenName != null && credential.familyName != null) {
          name = credential.givenName! + " " + credential.familyName!;
        }
        singInVerfied(context,email,pass,
            getFirstName(name),getLastName(name));
      } else if (credential.identityToken != null) {
        // AppStyle.successMsg(context, credential.identityToken!.substring(0,15));
        String email = credential.identityToken!.substring(0, 15);
        String pass = generatePassword(
            credential.identityToken!.substring(0, 15));
        String name = "";
        if (credential.givenName != null && credential.familyName != null) {
          name = credential.givenName! + " " + credential.familyName!;
        }
        singInVerfied(context,email,pass,
            getFirstName(name),getLastName(name));
      } else {
        loading(false);
        App.error_msg(context, App_Localization.of(context).translate("wrong"));
      }
    }catch(e){
      loading(false);
    }
  }
  generatePassword(String mail){
    String pass = mail;
    pass+="AlbaselAutoSignin";
    return pass;
  }

  singInVerfied(BuildContext context,String email,String  pass, String fName, String lName)async{
    print('-----------');
    print(email);
    print(pass);
    print(fName);
    print(lName);
    bool s = await ApiV2.signUpVerfied(email, pass, fName, lName);
    print('----END----');
    IntroController introController = Get.find();
    introController.get_nav();
  }

  signIn(BuildContext context,String email,String pass,bool is_home)async{
    try{
      if(email.isEmpty||pass.isEmpty||!RegExp(r'\S+@\S+\.\S+').hasMatch(email)){
        if(email.isEmpty||!RegExp(r'\S+@\S+\.\S+').hasMatch(email)){
          email_vaildate.value=false;
        }
        if(pass.isEmpty){
          pass_vaildate.value=false;
        }
      }else{
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

            // if(Global.customer_type_decoder != 0){
            //   await homeController.updateBestSellersSubCategory();
            // }
            loading.value=false;
            // Get.offAll(()=>Home());
            if(Global.customer_type==0 && Global.customer!.isActive == 0){
              Get.offAll(()=>VerificationCode());
            }else{
              if(Global.customer!.isActive == 0){
                ApiV2.token = "";
                Global.customer= null;
              }
              Get.offAll(()=>Home());
            }
            WishListController wishListController = Get.find();
            CartController cartController = Get.find();
            wishListController.getData();
            cartController.getData(null);

          }else{
            loading.value=false;
            App.error_msg(context, App_Localization.of(context).translate("wrong_mail"));
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
      }
    }catch(e){
      loading.value=false;
      App.error_msg(context, App_Localization.of(context).translate("wrong"));
    }

  }

  getFirstName(String fullName){
    String firstName = "";
    List<String> parts = fullName.trim().split(RegExp(r"\s+"));

    if (parts.length == 1) {
      // Only one name given
      firstName = parts[0];
    } else if (parts.length == 2) {
      // Typical: First + Last
      firstName = parts[0];
      // lastName = parts[1];
    } else {
      // More than 2 parts: take first as firstName, the rest as lastName
      firstName = parts.first;
      // lastName = parts.sublist(1).join(" ");
    }
    return firstName;
  }

  getLastName(String fullName){
    String lastName = "";
    List<String> parts = fullName.trim().split(RegExp(r"\s+"));

    if (parts.length == 1) {
      // Only one name given
      // firstName = parts[0];
    } else if (parts.length == 2) {
      // Typical: First + Last
      // firstName = parts[0];
      lastName = parts[1];
    } else {
      // More than 2 parts: take first as firstName, the rest as lastName
      // firstName = parts.first;
      lastName = parts.sublist(1).join(" ");
    }
    return lastName;
  }
}