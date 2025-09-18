import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/view/sign_in.dart';
import 'package:albassel_version_1/view/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PlzSigninSignup extends StatelessWidget {
  const PlzSigninSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.6-MediaQuery.of(context).padding.top,
      child:  Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: SvgPicture.asset("assets/logo/black_logo.svg",color: App.midOrange,),

              )
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(App_Localization.of(context).translate("welcom_albasel"),
                style: const TextStyle(
                    fontSize: 18
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => SignIn(true));
                },
                child: Text(
                  App_Localization.of(context).translate("sign_in"),
                  style: TextStyle(
                      fontSize: 16,
                      decoration:
                      TextDecoration.underline,
                      color: App.midOrange
                  ),
                ),
              ),

              const SizedBox(width: 10,),
              Text(App_Localization.of(context).translate("or"),style: const TextStyle(fontSize: 16,color: Colors.grey),),
              const SizedBox(width: 10,),
              GestureDetector(
                onTap: () {
                  Get.to(() => SignUp());
                },
                child: Text(
                  App_Localization.of(context).translate("Sign_up"),
                  style: TextStyle(
                      fontSize: 16,
                      decoration:
                      TextDecoration.underline,
                      color: App.midOrange
                  ),
                ),
              ),

            ],
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
