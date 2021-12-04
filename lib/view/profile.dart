import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/profile_controller.dart';
import 'package:albassel_version_1/view/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  ProfileController profileController = Get.put(ProfileController());
  TextEditingController newpass = TextEditingController();
  TextEditingController confNewpass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return  SafeArea(child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top,
          child: profileController.loading.value?Center(
            child: CircularProgressIndicator(),
          ):Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _header(context),
              //
              Global.customer==null?Container(
                height: MediaQuery.of(context).size.height*0.6-MediaQuery.of(context).padding.top,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(App_Localization.of(context).translate("not_signup"),style: App.textNormal(Colors.black, 18),),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: (){
                        Get.offAll(()=>Welcome());
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.3,
                        height: 40,
                        decoration: BoxDecoration(
                            color: App.midOrange,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: Text(App_Localization.of(context).translate("sign_in"),style: App.textNormal(Colors.white, 14),),
                        ),
                      ),
                    )

                  ],
                ),
              ):Container(
                height: MediaQuery.of(context).size.height*0.7-MediaQuery.of(context).padding.top,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _block(context,"first_name"),
                            _block(context,"last_name"),
                            _block(context,"email"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _block2(context, Global.customer!.firstName??"none"),
                            _block2(context, Global.customer!.lastName??"none"),
                            _block2(context, Global.customer!.email??"none"),


                          ],
                        ),
                      ],
                    ),
                    Column(
              children: [
              SizedBox(height: 20,),
              AnimatedContainer(duration: Duration(milliseconds: 300),
                width:MediaQuery.of(context).size.width*0.8,
                height: profileController.openNewPass.value?100:0,
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      App.textField(newpass, "new_pass", context,validate: profileController.validateNewPass.value),
                      App.textField(confNewpass, "c_pass", context,validate: profileController.validateConfNewPass.value),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap:(){
                  if(profileController.openNewPass.value){
                    profileController.change_password(context,newpass.value.text, confNewpass.value.text);
                  }else{
                    profileController.openNewPass.value=true;
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.45,
                  height: 40,
                  decoration: BoxDecoration(
                      color: App.midOrange,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: Text(App_Localization.of(context).translate("change_pass"),style: App.textNormal(Colors.white, 14),),
                  ),
                ),
              ),

            ],
          )
                  ],
                ),
              )
            ],
          ),
        ),
      ));
    });
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
              IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios,color: Colors.transparent,))
            ],
          ),
          SizedBox(),
          SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(App_Localization.of(context).translate("profile"),style: App.textBlod(Colors.white, 40),)
            ],
          )
        ],
      ),
    );
  }
  _block(BuildContext context,String key){
    return Container(
      width: 130,
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(App_Localization.of(context).translate(key)+" :",style: App.textBlod(App.midOrange, 16),),
          ],
        ),
      ),
    );
  }

  _block2(BuildContext context,String obj){
    return Container(
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(obj,style: App.textNormal(Colors.black, 16)),
          ],
        ),
      ),
    );
  }
}
