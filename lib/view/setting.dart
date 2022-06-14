// ignore_for_file: must_be_immutable

import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/settting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Setting extends StatelessWidget {
  SettingController settingController = Get.put(SettingController());

  List<String> view = ["English","العربية"];

  Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

      return Scaffold(
        floatingActionButton: App.live_chate(),
        backgroundColor: Colors.white,
        body: Obx((){
          return SafeArea(child: SingleChildScrollView(
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
                          Text(App_Localization.of(context).translate("language"),style: App.textBlod(Colors.black, 14),),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.3,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: settingController.value.value,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: App.midOrange),
                              underline: Container(
                                height: 2,
                                color: App.midOrange,
                              ),
                              onChanged: (String? newValue) {
                                settingController.value.value=newValue!;
                                String lang="ar";
                                if(newValue=="English"){
                                  lang="en";
                                }
                                settingController.change_lang(context, lang);
                              },
                              items: view.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
            ),
          ));
      }),
      );
    // });
  }
  _header(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.3,
      decoration: BoxDecoration(
        color: App.midOrange,
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight:Radius.circular(25)),

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
              IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)),

              IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios,color: Colors.transparent,)),
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

              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/logo/logo.png")
                  )
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(App_Localization.of(context).translate("setting"),style: App.textBlod(Colors.white, 30),)
            ],
          )
        ],
      ),
    );
  }

}
