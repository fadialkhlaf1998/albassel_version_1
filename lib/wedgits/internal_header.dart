import 'package:albassel_version_1/const/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternalHeader extends StatelessWidget {
  const InternalHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 90,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          gradient: App.orangeGradient()
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 30,),
          ),
          Image.asset("assets/logo/logo.png",height: 50,),
          Icon(Icons.arrow_back_ios,color: Colors.transparent,size: 30,),
        ],
      ),
    );
  }
}
