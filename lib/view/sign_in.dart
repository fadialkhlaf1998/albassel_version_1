// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:io';

import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/sign_in_controller.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/view/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  bool is_home;
  TextEditingController password=TextEditingController();
  SignInController signInController=Get.put(SignInController());
  TextEditingController email=TextEditingController();
  SignIn(this.is_home, {Key? key}) : super(key: key){
    if(Global.remember_pass&&Global.remember_password!="non"){
      password.text=Global.remember_password;
      email.text=Global.remember_email;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx((){
          return Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: signInController.loading.value?
                const Center(child: CircularProgressIndicator(),)
                    :Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(App_Localization.of(context).translate("or"),style: App.textNormal(Colors.grey, 20),),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(App_Localization.of(context).translate("not_have_account"),style: App.textNormal(Colors.black, 16),),
                              const SizedBox(width: 5,),
                              GestureDetector(
                                onTap: (){
                                  Get.to(() => SignUp());
                                },
                                child: Text(App_Localization.of(context).translate("Sign_up"),style: App.textBlod(App.midOrange, 16),),
                              ),
                            ],
                          ),

                          const SizedBox(height: 50,)
                        ],
                      ),

                    ),
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/background/signup.png"),
                                fit: BoxFit.cover),
                          ),
                          child: Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Image.asset("assets/logo/logo.png"),
                              )),
                        ),
                        Positioned(
                            top: 30,
                            left: Global.lang_code=="en"?5:null,
                            right: Global.lang_code=="ar"?5:null,
                            child:IconButton(
                              onPressed: (){
                                Get.back();
                              },
                              icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,),
                            )
                        ),
                      ],
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.26,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.height * 0.04),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black54,
                                  spreadRadius: 0.02,
                                  blurRadius: 2),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              App_Localization.of(context).translate("sign_in"),
                              style: App.textBlod(Colors.black, 22),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.9,
                              height: 40,
                              child: TextField(
                                controller: email,
                                decoration: InputDecoration(
                                    hintText: App_Localization.of(context).translate("email"),
                                    hintStyle: App.textNormal(Colors.grey, 14),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: signInController.email_vaildate.value?Colors.grey:Colors.red)),
                                    focusedBorder:  UnderlineInputBorder(borderSide: BorderSide(color: signInController.email_vaildate.value?App.orange:Colors.red))

                                ),
                                style: App.textNormal(Colors.grey, 14),
                              ),
                            ),


                            Obx((){
                              return textFieldPassword("password",password,context,signInController.hide_passeord.value);
                            }),

                            GestureDetector(
                              onTap: (){
                                signInController.signIn(context,email.value.text, password.value.text,is_home);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.height * 0.06 > 70
                                    ? 70
                                    : MediaQuery.of(context).size.height * 0.06,
                                decoration: BoxDecoration(
                                  color: App.midOrange,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    App_Localization.of(context)
                                        .translate("sign_in")
                                        .toUpperCase(),
                                    style: App.textNormal(Colors.white, 16),
                                  ),
                                ),
                              ),
                            ),
                            Platform.isAndroid?
                            GestureDetector(
                              onTap: (){
                                signInController.signInWithGoogle(context);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.height * 0.06 > 70
                                    ? 70
                                    : MediaQuery.of(context).size.height * 0.06,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.black)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/icon/google.png",height: 35,),
                                    SizedBox(width: 15,),
                                    Text(
                                      App_Localization.of(context)
                                          .translate("signin_google"),
                                      style: App.textNormal(Colors.black, 16),
                                    ),
                                  ],
                                )
                              ),
                            )
                            :GestureDetector(
                              onTap: (){
                                signInController.signInWithApple(context);
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  height: MediaQuery.of(context).size.height * 0.06 > 70
                                      ? 70
                                      : MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(color: Colors.black)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.apple,size: 40,),
                                      SizedBox(width: 15,),
                                      Text(
                                        App_Localization.of(context)
                                            .translate("signin_apple"),
                                        style: App.textNormal(Colors.black, 16),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        })
    );
  }
  textFieldPassword(String translate,TextEditingController controller,BuildContext context,bool hide){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width*0.9,
          child: TextField(
            obscureText: hide,
            enableSuggestions: false,
            autocorrect: false,
            controller: controller,
            decoration: InputDecoration(
                hintText: App_Localization.of(context).translate(translate),
                hintStyle: App.textNormal(Colors.grey, 14),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: signInController.pass_vaildate.value?Colors.grey:Colors.red)),
                focusedBorder:  UnderlineInputBorder(borderSide: BorderSide(color: signInController.pass_vaildate.value?App.orange:Colors.red)),
                suffix: IconButton(
                  onPressed: (){
                    signInController.change_visibilty();
                  },
                  icon: Icon(!hide?Icons.visibility:Icons.visibility_off,color: Colors.black,size: 20,),
                )
            ),
            style: App.textNormal(Colors.grey, 14),
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            Checkbox(value: signInController.remember_value.value,onChanged: (val){
              signInController.remember_value.value=val!;
              Store.save_remember(val);
            },),
            Text(App_Localization.of(context).translate("remember_pass"))
          ],
        ),
        const SizedBox(height: 30,),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.9,
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: (){
                    signInController.forget_pass(context,email.value.text);
                  },
                  child: Text(App_Localization.of(context).translate("forget_pass"),style: TextStyle(color: App.midOrange,fontSize: 13),))
            ],
          ),
        )
      ],
    );
  }

}
