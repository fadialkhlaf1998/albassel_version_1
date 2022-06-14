import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/view/home.dart';
import 'package:albassel_version_1/view/sign_in.dart';
import 'package:albassel_version_1/view/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: App.midOrange,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image:AssetImage("assets/background/welcom.png"),
              fit: BoxFit.cover
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.3,
                child: Image.asset("assets/logo/logo.png",fit: BoxFit.cover,),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.2,),
              Text(App_Localization.of(context).translate("welcome"),style: App.textBlod(Colors.white, 32),),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.8,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(App_Localization.of(context).translate("signup_msg"),style: const TextStyle(fontSize: 18,color: Colors.white,overflow: TextOverflow.clip),textAlign: TextAlign.center)
                    ],
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: (){
                  Get.offAll(() => Home());
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width*0.9,
                  decoration: BoxDecoration(
                    color: App.midOrange,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child:Center(
                    child: Text(App_Localization.of(context).translate("continue"),style: App.textBlod(Colors.white, 16
                    ),),
                  )
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: 40,
                    child: Text(App_Localization.of(context).translate("have_account"),style: App.textNormal(Colors.white, 14),),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => SignIn(false));
                    },
                    child: SizedBox(
                      width: 80,
                      height: 40,
                      child: Text(App_Localization.of(context).translate("sign_in"),style: App.textBlod(App.midOrange, 14)),
                    ),
                  ),
                ],
              ),
              // Text(App_Localization.of(context).translate("or"),style: App.textNormal(Colors.grey, 16),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: 40,
                    child: Text(App_Localization.of(context).translate("not_have_account"),style: App.textNormal(Colors.white, 14),),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => SignUp());
                    },
                    child: SizedBox(
                      width: 80,
                      height: 40,
                      child: Text(App_Localization.of(context).translate("Sign_up"),style: App.textBlod(App.midOrange, 14)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
