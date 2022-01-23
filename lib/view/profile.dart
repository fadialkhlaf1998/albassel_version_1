import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/controler/profile_controller.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/view/address.dart';
import 'package:albassel_version_1/view/customer_order.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:albassel_version_1/view/sign_in.dart';
import 'package:albassel_version_1/view/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  ProfileController profileController = Get.put(ProfileController());
  TextEditingController newpass = TextEditingController();
  TextEditingController confNewpass = TextEditingController();
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Obx((){
      return  SafeArea(child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top,
              decoration: BoxDecoration(
                color: Colors.white
              ),
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

                        Text(App_Localization.of(context).translate("login_first"),style: App.textNormal(Colors.black, 18),),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            Get.to(()=>SignIn(true));
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
                        SizedBox(height: 20,),
                        _account_info(context),
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
                          border: Border.all(color:Colors.black,width: 1),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Text(App_Localization.of(context).translate("change_pass"),style: App.textBlod(Colors.black, 14),),
                      ),
                    ),
                  ),
                    SizedBox(height: 20,),
                  _adress(context),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _wishlist(context),
                        _my_order(context),
                      ],
                    ),
                  )
                ],
              )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(top: 0,child: homeController.product_loading.value?Container(height:MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.grey.withOpacity(0.4),child: Center(child: CircularProgressIndicator()),):Center())
          ],
        ),
      ));
    });
  }
  _account_info(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.9,
            height: 35,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),border: Border.all(color:Colors.black,width: 1)),
            child:Row(

              children: [
                SizedBox(width: 10,),
                Text(App_Localization.of(context).translate("account_info"),style: App.textBlod(Colors.black, 14)),
                SizedBox(width: 10,),
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
            child: Row(
              children: [
                Text(App_Localization.of(context).translate("name")+":   ",style: App.textNormal(Colors.black, 12),),
                Text(Global.customer!.firstname+" "+Global.customer!.lastname,style: App.textNormal(Colors.black, 12),),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
            child: Row(
              children: [
                Text(App_Localization.of(context).translate("email")+":   ",style: App.textNormal(Colors.black, 12),),
                Text(Global.customer!.email,style: App.textNormal(Colors.black, 12),),
              ],
            ),
          )
        ],
      ),
    );
  }
  _adress(BuildContext context){
    return GestureDetector(
      onTap: (){
        Get.to(()=>AddressView());
      },
      child: Container(
        width: MediaQuery.of(context).size.width*0.9,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1,color: Colors.black)
        ),
        child: Center(
          child: Row(
            children: [
              SizedBox(width: 10),
              Text(App_Localization.of(context).translate("address"),style: App.textBlod(Colors.black, 14),),
              Spacer(),
              Text(App_Localization.of(context).translate("edit"),style: App.textNormal(Colors.black, 14),),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
  _wishlist(BuildContext context){
    return GestureDetector(
      onTap: (){
        homeController.selected_bottom_nav_bar.value=3;
      },
      child: Container(
        width: MediaQuery.of(context).size.width*0.4,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1,color: Colors.black)
        ),
        child: Center(
          child: Text(App_Localization.of(context).translate("wishlist"),style: App.textBlod(Colors.black, 14),),
        ),
      ),
    );
  }
  _my_order(BuildContext context){
    return GestureDetector(
      onTap: (){
        get_my_order(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width*0.4,
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.black),
            borderRadius: BorderRadius.circular(20)
        ),
        child: Center(
          child: Text(App_Localization.of(context).translate("my_order"),style: App.textBlod(Colors.black, 14),),
        ),
      ),
    );
  }
  _header(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.2,
      decoration: BoxDecoration(
        color: App.midOrange,
        gradient: App.orangeGradient(),
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
              IconButton(onPressed: (){
                homeController.selected_bottom_nav_bar.value=0;
              }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,size: 25,)),

              GestureDetector(
                onTap: (){
                  homeController.selected_bottom_nav_bar.value=0;
                },
                child: Container(
                  width: 70,
                  height: 70,

                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/logo/logo.png")
                      )
                  ),
                ),
              ),

              IconButton(onPressed: (){

              }, icon: Icon(Icons.arrow_back_ios,color: Colors.transparent,size: 25,))
            ],
          ),
          SizedBox(),
          SizedBox(),
          Global.customer==null?
              Center()
              :Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10),
              Text(App_Localization.of(context).translate("hello")+" ",style: App.textBlod(Colors.white, 16),),
              Text(Global.customer!.firstname+" "+Global.customer!.lastname,style: App.textNormal(Colors.white, 16),),
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

  get_my_order(BuildContext context){

    MyApi.check_internet().then((internet) {
      if (internet) {
        homeController.product_loading.value=true;
         MyApi.get_customer_order(Global.customer!.id).then((value) {
          homeController.product_loading.value=false;
          if(value.isNotEmpty){
            Get.to(()=>CustomerOrderView(value));
          }else{
            App.error_msg(context, App_Localization.of(context).translate("wrong_my_order"));
          }

        })
            .catchError((err){
          print(err);
          homeController.product_loading.value=false;
          App.error_msg(context, App_Localization.of(context).translate("wrong"));
        });
      }else{
        Get.to(NoInternet())!.then((value) {
          get_my_order(context);
        });
      }
    });

  }
}
