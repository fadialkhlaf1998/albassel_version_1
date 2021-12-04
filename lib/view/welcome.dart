import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/view/home.dart';
import 'package:albassel_version_1/view/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image:AssetImage("assets/background/welcom.png"),
              fit: BoxFit.cover
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
              Container(
                width: MediaQuery.of(context).size.width*0.3,
                child: Image.asset("assets/logo/logo.png",fit: BoxFit.cover,),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.2,),
              Text(App_Localization.of(context).translate("welcome"),style: App.textBlod(Colors.white, 32),),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              Container(
                width: MediaQuery.of(context).size.width*0.8,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(App_Localization.of(context).translate("signup_msg"),style: TextStyle(fontSize: 18,color: Colors.white,overflow: TextOverflow.clip),textAlign: TextAlign.center)
                    ],
                  ),
                ),
              ),
              Spacer(),
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
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: 40,
                    child: Text(App_Localization.of(context).translate("have_account"),style: App.textNormal(Colors.white, 16),),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => SignIn());
                    },
                    child: Container(
                      width: 80,
                      height: 40,
                      child: Text(App_Localization.of(context).translate("sign_in"),style: App.textBlod(App.midOrange, 16)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
