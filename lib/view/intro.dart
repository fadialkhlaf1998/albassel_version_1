import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/intro_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Intro extends StatelessWidget {

  IntroController introController=Get.put(IntroController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/intro.png",),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(App_Localization.of(context).translate("welcome"),style: App.textBlod(Colors.white, 32),),
              Container(
                width: MediaQuery.of(context).size.width*0.6,
                child: Image.asset("assets/logo/logo.png",fit: BoxFit.cover,),
              ),
              SizedBox()
            ],
          ),
        ),
      )
    );
  }
}
