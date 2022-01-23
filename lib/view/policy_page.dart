import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';


class PolicyPage extends StatelessWidget {

  String title;
  String content;


  PolicyPage(this.title, this.content);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: App.midOrange,
      body: SafeArea(child: SingleChildScrollView(
        child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                _header(context),

                // Padding(
                //   padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
                //   child: Text(App_Localization.of(context).translate("about_us_content_top"),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                // ),
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
                  child:Html(data: this.content,),
                ),
              ],
            )
        ),
      )),

    );
    // });
  }
  _header(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.3,
      decoration: BoxDecoration(
        color: App.midOrange,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight:Radius.circular(25)),

        boxShadow: [
          App.box_shadow()
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),

              IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios,color: Colors.transparent,)),
            ],
          ),
          GestureDetector(
            onTap: (){
              // homeController.selected_bottom_nav_bar.value=0;
              Get.back();
              Get.back();
            },
            child: Container(
              width: 90,
              height: 90,

              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/logo/logo.png")
                  )
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(this.title,style: App.textBlod(Colors.white, 30),)
            ],
          )
        ],
      ),
    );
  }
}

