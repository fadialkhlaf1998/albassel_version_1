import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: App.midOrange,
      floatingActionButton: App.live_chate(),
      body: SafeArea(child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  _header(context),
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          height: 90,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/background/about_us.png")
                            )
                          ),
                        ),


                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
                    child: Text(App_Localization.of(context).translate("about_us_content_top"),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold,),textAlign: TextAlign.left,),
                  ),
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
                    child: Text(App_Localization.of(context).translate("about_us_content_bottom"),style:TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.normal,),textAlign: TextAlign.left,),
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
            children: [
              IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios,color: Colors.white,))
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
              Text(App_Localization.of(context).translate("about_us"),style: App.textBlod(Colors.white, 30),)
            ],
          )
        ],
      ),
    );
  }
}

