import 'dart:io';

import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/view/chat_view.dart';
import 'package:albassel_version_1/view/policy_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      backgroundColor: midOrange.withOpacity(0.8),
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


                  ],
                ),
                SizedBox(width: 15,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(onTap: (){homeController.nave_to_home();},child: Icon(Icons.home,color: Colors.white,size: 25,)),
                        SizedBox(width: 15,),
                        GestureDetector(onTap: (){homeController.nave_to_home();},child: Text(App_Localization.of(context).translate("home"),style: App.textBlod(Colors.white, 14),)),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(onTap: (){homeController.nave_to_wishlist();},child: Icon(Icons.favorite_border,color: Colors.white,size: 25)),
                        SizedBox(width: 15,),
                        GestureDetector(onTap: (){homeController.nave_to_wishlist();},child: Text(App_Localization.of(context).translate("wishlist"),style: App.textBlod(Colors.white, 14),)),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(onTap: (){homeController.nave_to_setting();},child: Icon(Icons.settings,color: Colors.white,size: 25)),
                        SizedBox(width: 15,),
                        GestureDetector(onTap: (){homeController.nave_to_setting();},child: Text(App_Localization.of(context).translate("setting"),style: App.textBlod(Colors.white, 14),)),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(onTap: (){homeController.nave_to_about_us();},child: Icon(Icons.info_outline,color: Colors.white,size: 25)),
                        SizedBox(width: 15,),
                        GestureDetector(onTap: (){homeController.nave_to_about_us();},child: Text(App_Localization.of(context).translate("about_us"),style: App.textBlod(Colors.white, 14),)),
                      ],
                    ),

                    Row(
                      children: [
                        GestureDetector(onTap: (){Get.to(PolicyPage(App_Localization.of(context).translate("faqs"), App_Localization.of(context).translate("faqs_content")));},child: Icon(Icons.question_answer_outlined,color: Colors.white,size: 25)),
                        SizedBox(width: 15,),
                        GestureDetector(onTap: (){Get.to(PolicyPage(App_Localization.of(context).translate("faqs"), App_Localization.of(context).translate("faqs_content")));},child: Text(App_Localization.of(context).translate("faqs"),style: App.textBlod(Colors.white, 14),)),
                      ],
                    ),

                    Row(
                      children: [
                        GestureDetector(onTap: (){openwhatsapp(context, App_Localization.of(context).translate("whatsapp_info"));},child: SvgPicture.asset("assets/icon/whatsapp.svg",height: 23,)),
                        SizedBox(width: 15,),
                        GestureDetector(onTap: (){openwhatsapp(context, App_Localization.of(context).translate("whatsapp_info"));},child: Text(App_Localization.of(context).translate("whatsapp"),style: App.textBlod(Colors.white, 14),)),
                      ],
                    ),



                    Row(
                      children: [
                        Global.customer!=null? GestureDetector(onTap: (){homeController.nave_to_logout();},child: Icon(Icons.logout,color: Colors.white,size: 25)):Center(),
                        SizedBox(width: 10,),
                        Global.customer!=null? GestureDetector(onTap: (){homeController.nave_to_logout();},child: Text(App_Localization.of(context).translate("logout"),style: App.textBlod(Colors.white, 14),)):Center(),
                      ],
                    ),
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
  static price(BuildContext context ,double price,double? offer){
    // print(offer!);
    return offer==null?
    Text(App_Localization.of(context).translate("aed")+" "+price.toStringAsFixed(2),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14,),maxLines: 1,overflow: TextOverflow.ellipsis)
        :Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(App_Localization.of(context).translate("aed")+" "+price.toStringAsFixed(2),maxLines: 2,overflow: TextOverflow.clip,textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),),
          Text(App_Localization.of(context).translate("aed")+" "+offer.toStringAsFixed(2),maxLines: 2,overflow: TextOverflow.clip,textAlign: TextAlign.center,style: TextStyle(color: Colors.grey[700], fontSize: 9, fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough),),
        ],
      ),
    );
  }
  static sucss_msg(BuildContext context,String msg){
    return showTopSnackBar(
      context,
      CustomSnackBar.success(
        message:
        msg,
        backgroundColor: Color(0xffC3C7C7),
        textStyle: TextStyle(color: App.midOrange,fontWeight: FontWeight.bold),
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
    var whatsapp ="971526924021";
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=$msg";
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse(msg)}";

    String url = WA_url(whatsapp,msg);

    if( await canLaunch(url)){
      await launch(url);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Can not open whatsapp")));

    }
  }

  static String WA_url(String phone,String message) {
    return "https://wa.me/$phone/?text=${Uri.parse(message)}";
    if (Platform.isAndroid) {
      // add the [https]
      return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
    } else {
      // add the [https]
      return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
    }
  }


}