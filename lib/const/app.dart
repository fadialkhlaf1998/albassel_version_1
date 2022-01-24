import 'dart:io';

import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/view/chat_view.dart';
import 'package:albassel_version_1/view/policy_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class App{
  static Color orange = Color(0XFFFA5C00);
  static Color lightOrange = Color(0XFFF6921E);
  static Color midOrange = Color(0XFFF37920);
  static textBlod(Color color,double size){
    return TextStyle(color: color,fontWeight: FontWeight.bold,fontSize: size,overflow: TextOverflow.ellipsis);
  }
  static textNormal(Color color,double size){
    return TextStyle(color: color,fontSize: size,overflow: TextOverflow.ellipsis);
  }
  static textField(TextEditingController controller,String translate,BuildContext context,{bool validate=true}){
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      height: 40,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: App_Localization.of(context).translate(translate),
          hintStyle: textNormal(Colors.grey, 14),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: validate?Colors.grey:Colors.red)),
          focusedBorder:  UnderlineInputBorder(borderSide: BorderSide(color: validate?App.orange:Colors.red))

        ),
        style: textNormal(Colors.grey, 14),
      ),
    );
  }
  static checkoutTextField(TextEditingController controller,String translate,BuildContext context,double width,double height,bool err){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(App_Localization.of(context).translate(translate),style: textNormal(Colors.grey, 12),),
        Container(
          width: width,
          height: height,
    child: TextField(
           controller: controller,
            decoration: InputDecoration(
              enabledBorder: err&&controller.value.text.isEmpty?UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)):UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: midOrange))
            ),
            style: textNormal(Colors.black, 14),
          ),
        ),
      ],
    );
  }
  static checkoutTextFieldphone(TextEditingController controller,String translate,BuildContext context,double width,double height,bool err){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(App_Localization.of(context).translate(translate),style: textNormal(Colors.grey, 12),),
        Container(
          width: width,
          height: height,
          child: TextField(
            keyboardType: TextInputType.number,
            controller: controller,
            decoration: InputDecoration(
                enabledBorder: err&&controller.value.text.isEmpty?UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)):UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: midOrange))
            ),
            style: textNormal(Colors.black, 14),
          ),
        ),
      ],
    );
  }
  static orangeGradient(){
    return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.topLeft,
        colors: [
        App.lightOrange,
        App.orange,
        ]
    );
  }
  static box_shadow(){
    return  BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10);
  }
  static live_chate(){
    return FloatingActionButton(
      onPressed: (){
        Get.to(()=>ChatView());
      },
      child: Icon(Icons.chat),
    );
  }
  static void _launchURL(BuildContext context,String url) async {
    if (!await launch(url)){
      App.error_msg(context, App_Localization.of(context).translate("wrong"));
    }
  }
  static void launchURL(BuildContext context,String url) async {
    if (!await launch(url)){
      App.error_msg(context, App_Localization.of(context).translate("wrong"));
    }
  }
  static Drawer get_drawer(BuildContext context,HomeController homeController){
    return Drawer(
      backgroundColor: Color(0xffE37B2F).withOpacity(0.8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 0,),
          Container(
            height: MediaQuery.of(context).size.height*0.25,
            child: Column(
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: (){
                      homeController.closeDrawer();
                    }, icon: Icon(Icons.close,color: Colors.white,))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Container(
                      height: MediaQuery.of(context).size.height*0.1,
                       width:  MediaQuery.of(context).size.height*0.1,
                     decoration: BoxDecoration(
                       image: DecorationImage(
                         image: AssetImage("assets/logo/logo.png")
                       )
                     ),
                   )
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(onTap: (){homeController.nave_to_home();},child: Icon(Icons.home,color: Colors.white,)),
                    GestureDetector(onTap: (){homeController.nave_to_wishlist();},child: Icon(Icons.favorite_border,color: Colors.white,)),
                    GestureDetector(onTap: (){homeController.nave_to_setting();},child: Icon(Icons.settings,color: Colors.white,)),
                    GestureDetector(onTap: (){homeController.nave_to_about_us();},child: Icon(Icons.info_outline,color: Colors.white,)),
                    GestureDetector(onTap: (){openwhatsapp(context, App_Localization.of(context).translate("whatsapp_info"));},child: SvgPicture.asset("assets/icon/whatsapp.svg",height: 21,)),
                    Global.customer!=null? GestureDetector(onTap: (){homeController.nave_to_logout();},child: Icon(Icons.logout,color: Colors.white,)):Center(),

                  ],
                ),
                SizedBox(width: 15,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(onTap: (){homeController.nave_to_home();},child: Text(App_Localization.of(context).translate("home"),style: App.textBlod(Colors.white, 16),)),
                    GestureDetector(onTap: (){homeController.nave_to_wishlist();},child: Text(App_Localization.of(context).translate("wishlist"),style: App.textBlod(Colors.white, 16),)),
                    GestureDetector(onTap: (){homeController.nave_to_setting();},child: Text(App_Localization.of(context).translate("setting"),style: App.textBlod(Colors.white, 16),)),
                    GestureDetector(onTap: (){homeController.nave_to_about_us();},child: Text(App_Localization.of(context).translate("about_us"),style: App.textBlod(Colors.white, 16),)),
                    GestureDetector(onTap: (){openwhatsapp(context, App_Localization.of(context).translate("whatsapp_info"));},child: Text(App_Localization.of(context).translate("whatsapp"),style: App.textBlod(Colors.white, 16),)),
                    Global.customer!=null? GestureDetector(onTap: (){homeController.nave_to_logout();},child: Text(App_Localization.of(context).translate("logout"),style: App.textBlod(Colors.white, 16),)):Center(),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.25,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(onTap: (){_launchURL(context,"https://www.instagram.com/albasel.co/");},child: SvgPicture.asset("assets/icon/insta.svg")),
                    GestureDetector(onTap: (){_launchURL(context,"https://www.facebook.com/albasel.co/");},child: SvgPicture.asset("assets/icon/facebook.svg")),
                    GestureDetector(onTap: (){_launchURL(context,"https://www.youtube.com/channel/UCVEa7VQ0kT7K_54u2ouTVVg");},child: SvgPicture.asset("assets/icon/youtube.svg")),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                    GestureDetector(onTap:(){Get.to(PolicyPage(App_Localization.of(context).translate("policy"), App_Localization.of(context).translate("privacy_policy_content")));},child: Text(App_Localization.of(context).translate("policy"),style: App.textNormal(Colors.white, 10),)),
                    Text(".",style: App.textNormal(Colors.white, 10),),
                    GestureDetector(onTap:(){Get.to(PolicyPage(App_Localization.of(context).translate("terms_sale"), App_Localization.of(context).translate("term_of_service_content")));},child: Text(App_Localization.of(context).translate("terms_sale"),style: App.textNormal(Colors.white, 10),)),
                    Text(".",style: App.textNormal(Colors.white, 10),),
                    GestureDetector(onTap:(){Get.to(PolicyPage(App_Localization.of(context).translate("return_p"), App_Localization.of(context).translate("return_content")));},child: Text(App_Localization.of(context).translate("return_p"),style: App.textNormal(Colors.white, 10),)),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(onTap: (){Get.to(PolicyPage(App_Localization.of(context).translate("shipping-policy"), App_Localization.of(context).translate("shipping_policy_content")));},child: Text(App_Localization.of(context).translate("shipping-policy"),style: App.textNormal(Colors.white, 10),)),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 0,),
        ],
      )
    );
  }

  static sucss_msg(BuildContext context,String msg){
    return showTopSnackBar(
      context,
      CustomSnackBar.success(
        message:
        msg,
        backgroundColor: midOrange,
      ),
    );
  }
  static error_msg(BuildContext context,String err){
    return showTopSnackBar(
      context,
      CustomSnackBar.error(
        message:
        err,
      ),
    );
  }

  static openwhatsapp(BuildContext context,String msg) async{
    var whatsapp ="+1 (202) 773-4834";
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=$msg";
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse(msg)}";
    if(Platform.isIOS){
      // for iOS phone only
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios, forceSafariVC: false);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));

      }

    }else{
      // android , web
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));

      }


    }

  }


}