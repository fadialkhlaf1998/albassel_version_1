// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/controler/profile_controller.dart';
import 'package:albassel_version_1/controler/settting_controller.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/view/address.dart';
import 'package:albassel_version_1/view/customer_order.dart';
import 'package:albassel_version_1/view/my_address.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:albassel_version_1/view/policy_page.dart';
import 'package:albassel_version_1/view/sign_in.dart';
import 'package:albassel_version_1/view/sign_up.dart';
import 'package:albassel_version_1/wedgits/plz_signin_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatelessWidget {
  ProfileController profileController = Get.put(ProfileController());
  TextEditingController newpass = TextEditingController();
  TextEditingController confNewpass = TextEditingController();
  HomeController homeController = Get.find();

  SettingController settingController = Get.put(SettingController());

  Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Obx(() {
      return SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Colors.white),
            child: profileController.loading.value
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _header(context),
                //
                Global.customer == null
                    ? PlzSigninSignup()
                    : Expanded(
                      child: homeController.product_loading.value?Center(child: CircularProgressIndicator(),):
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              width: Get.width * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(App_Localization.of(context).translate("account_info"),
                                      style: App.textBlod(Colors.black, 14)),
                                  SizedBox(height: 10,),
                                  myCard(
                                      context,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                App_Localization.of(context).translate("name") + ":   ",
                                                style: App.textNormal(Colors.black, 12),
                                              ),
                                              Text(
                                                Global.customer!.firstname + " " + Global.customer!.lastname,
                                                style: App.textNormal(Colors.black, 12),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                App_Localization.of(context).translate("email") + ":   ",
                                                style: App.textNormal(Colors.black, 12),
                                              ),
                                              Text(
                                                Global.customer!.email,
                                                style: App.textNormal(Colors.black, 12),
                                              ),
                                            ],
                                          ),
                                          Divider(color: Colors.black,height: 30,),
                                          GestureDetector(
                                            onTap: (){
                                              Get.to(() => CustomerOrderView());
                                            },
                                            child: myCardItem(
                                                context,
                                                firstIcon: Icon(Icons.shopping_bag_outlined,color: App.midOrange,),
                                                title: "my_order",
                                                lastIcon: Icon(Icons.arrow_forward_ios,size: 15,)
                                            ),
                                          ),
                                          Divider(color: Colors.black,height: 30,),
                                          GestureDetector(
                                            onTap: (){
                                              homeController.selected_bottom_nav_bar.value = 3;
                                            },
                                            child: myCardItem(
                                                context,
                                                firstIcon: Icon(Icons.favorite_border,color: App.midOrange,),
                                                title: "wishlist",
                                                lastIcon: Icon(Icons.arrow_forward_ios,size: 15,)
                                            ),
                                          ),
                                          Divider(color: Colors.black,height: 30,),
                                          GestureDetector(
                                            onTap: (){
                                              Get.to(() => MyAddress());
                                            },
                                            child: myCardItem(
                                                context,
                                                firstIcon: Icon(Icons.location_on_outlined,color: App.midOrange,),
                                                title: "address",
                                                lastIcon: Icon(Icons.arrow_forward_ios,size: 15,)
                                            ),
                                          )

                                        ],
                                      )
                                  ),
                                  SizedBox(height: 20,),
                                  Text(App_Localization.of(context).translate("setting"),
                                      style: App.textBlod(Colors.black, 14)),
                                  SizedBox(height: 10,),
                                  myCard(
                                      context,
                                      child: Column(
                                        children: [

                                          GestureDetector(
                                            onTap: (){
                                              settingController.change_lang(context, Global.lang_code=="en"?"ar":"en");
                                            },
                                            child: myCardItem(
                                                context,
                                                firstIcon: Icon(Icons.language,color: App.midOrange,),
                                                title: "language",
                                                lastIcon: Global.lang_code=="en"?Text("English"):Text("العربية")
                                            ),
                                          ),
                                          Divider(color: Colors.black,height: 30,),
                                          GestureDetector(
                                            onTap: (){
                                              //todo notifications
                                            },
                                            child: myCardItem(
                                                context,
                                                firstIcon: Icon(Icons.notifications_active_outlined,color: App.midOrange,),
                                                title: "notifications",
                                                lastIcon: Switch(value: true, onChanged: (val){

                                                })
                                            ),
                                          ),
                                          Divider(color: Colors.black,height: 30,),
                                          AnimatedContainer(
                                            duration:
                                            const Duration(milliseconds: 300),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.8,
                                            height: profileController
                                                .openNewPass.value
                                                ? 100
                                                : 0,
                                            child: SingleChildScrollView(
                                              physics:
                                              const NeverScrollableScrollPhysics(),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  App.textField(newpass,
                                                      "new_pass", context,
                                                      validate: profileController
                                                          .validateNewPass.value),
                                                  App.textField(confNewpass,
                                                      "c_pass", context,
                                                      validate: profileController
                                                          .validateConfNewPass
                                                          .value),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              if (profileController
                                                  .openNewPass.value) {
                                                profileController
                                                    .change_password(
                                                    context,
                                                    newpass.value.text,
                                                    confNewpass
                                                        .value.text);
                                              } else {
                                                profileController
                                                    .openNewPass.value = true;
                                              }
                                            },
                                            child: myCardItem(
                                                context,
                                                firstIcon: Icon(Icons.lock_open,color: App.midOrange,),
                                                title: "change_pass",
                                                lastIcon: GestureDetector(
                                                    onTap: (){
                                                      if (profileController
                                                          .openNewPass.value) {
                                                        profileController
                                                            .openNewPass.value = false;
                                                      } else {
                                                        profileController
                                                            .openNewPass.value = true;
                                                      }
                                                    },
                                                    child: profileController.openNewPass.value
                                                        ?Icon(Icons.keyboard_arrow_up,size: 25,)
                                                        :Icon(Icons.keyboard_arrow_down,size: 25,)
                                                )
                                            ),
                                          ),
                                          Divider(color: Colors.black,height: 30,),
                                          GestureDetector(
                                            onTap: (){
                                              homeController.showFloatActionBtn(false);
                                              Scaffold.of(context).showBottomSheet(

                                                backgroundColor: App.midOrange,

                                                    (context) => Container(
                                                  height: 200,
                                                  width: Get.width,
                                                  padding: EdgeInsets.all(14),
                                                  color: Colors.white,
                                                  child: myCard(context, child: Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: (){
                                                          showAlertDialog(context);
                                                        },
                                                        child: myCardItem(
                                                            context,
                                                            firstIcon: Icon(Icons.delete_outline,color: App.midOrange,),
                                                            title: "delete_account",
                                                            lastIcon: Icon(Icons.arrow_forward_ios,size: 15,)
                                                        ),
                                                      ),
                                                      Divider(color: Colors.black,height: 30,),
                                                      GestureDetector(
                                                        onTap: (){
                                                          Get.to(PolicyPage(App_Localization.of(context).translate("faqs"), App_Localization.of(context).translate("faqs_content")));
                                                        },
                                                        child: myCardItem(
                                                            context,
                                                            firstIcon: Icon(Icons.question_answer_outlined,color: App.midOrange,),
                                                            title: "faqs",
                                                            lastIcon: Icon(Icons.arrow_forward_ios,size: 15,)
                                                        ),
                                                      ),
                                                      Divider(color: Colors.black,height: 30,),
                                                      GestureDetector(
                                                        onTap: (){
                                                          App.openwhatsapp(context, "Hi, I need Help");
                                                        },
                                                        child: myCardItem(
                                                            context,
                                                            firstIcon: SvgPicture.asset("assets/icon/whatsapp.svg",height: 25,width: 25,color: App.midOrange,),
                                                            title: "whatsapp",
                                                            lastIcon: Icon(Icons.arrow_forward_ios,size: 15,)
                                                        ),
                                                      ),

                                                    ],
                                                  )),
                                                ),
                                                showDragHandle: true,
                                              ).closed.whenComplete(() {
                                                homeController.showFloatActionBtn(true); // show FAB back
                                              });
                                              // showAlertDialog(context);
                                            },
                                            child: myCardItem(
                                                context,
                                                firstIcon: Icon(Icons.help_outline,color: App.midOrange,),
                                                title: "help",
                                                lastIcon: Icon(Icons.arrow_forward_ios,size: 15,)
                                            ),
                                          ),


                                        ],
                                      )
                                  ),
                                  const SizedBox(height: 20),

                                  GestureDetector(
                                    onTap: () {
                                      homeController.nave_to_logout();
                                    },
                                    child: Container(
                                        width: Get.width *0.9,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            // border: Border.all(
                                            //     color: Colors.black,
                                            //     width: 1),
                                            color: App.grey,
                                            borderRadius:
                                            BorderRadius.circular(
                                                8)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.logout,color: App.midOrange,),
                                            SizedBox(width: 10,),
                                            Text(
                                              App_Localization.of(context)
                                                  .translate(
                                                  "logout"),
                                              style: App.textBlod(
                                                  Colors.black, 14),
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  myCard(context, child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(width: 10,),
                                          GestureDetector(
                                            onTap: (){
                                              App.launchURL(context, "https://www.facebook.com/albasel.co");
                                            },
                                            child: FaIcon(FontAwesomeIcons.facebookF,color: Colors.grey,size: 20,),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              App.launchURL(context, "https://www.instagram.com/albasel.co/");
                                            },
                                            child: FaIcon(FontAwesomeIcons.instagram,color: Colors.grey,size: 20,),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              App.launchURL(context, "https://www.tiktok.com/@albaselcosmetics");
                                            },
                                            child: FaIcon(FontAwesomeIcons.tiktok,color: Colors.grey,size: 20,),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              App.launchURL(context, "https://www.youtube.com/@AlBaselCo");
                                            },
                                            child: FaIcon(FontAwesomeIcons.youtube,color: Colors.grey,size: 20,),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              App.launchURL(context, "https://www.pinterest.com/albaselmedia/");
                                            },
                                            child: FaIcon(FontAwesomeIcons.pinterestP,color: Colors.grey,size: 20,),
                                          ),
                                          SizedBox(width: 10,),
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(width: 10,),
                                          SizedBox(width: 10,),
                                          GestureDetector(onTap:(){Get.to(PolicyPage(App_Localization.of(context).translate("policy"), App_Localization.of(context).translate("privacy_policy_content")));},child: Text(App_Localization.of(context).translate("policy"),style: App.textNormal(Colors.grey, 10),)),
                                          Text(".",style: App.textNormal(Colors.black, 10),),
                                          GestureDetector(onTap:(){Get.to(PolicyPage(App_Localization.of(context).translate("terms_sale"), App_Localization.of(context).translate("term_of_service_content")));},child: Text(App_Localization.of(context).translate("terms_sale"),style: App.textNormal(Colors.grey, 10),)),
                                          Text(".",style: App.textNormal(Colors.black, 10),),
                                          GestureDetector(onTap:(){Get.to(PolicyPage(App_Localization.of(context).translate("return_p"), App_Localization.of(context).translate("return_content")));},child: Text(App_Localization.of(context).translate("return_p"),style: App.textNormal(Colors.grey, 10),)),
                                          SizedBox(width: 10,),
                                          SizedBox(width: 10,),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(onTap: (){Get.to(PolicyPage(App_Localization.of(context).translate("shipping-policy"), App_Localization.of(context).translate("shipping_policy_content")));},child: Text(App_Localization.of(context).translate("shipping-policy"),style: App.textNormal(Colors.grey, 10),)),
                                        ],
                                      )
                                    ],
                                  )),
                                  const SizedBox(height: 20),

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
              ],
            ),
          ));
    });
  }

  myCard(BuildContext context , {required Widget child}){
    return Container(
      width: Get.width * 0.9,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          // color: Colors.white,
          // border: Border.all(color: Colors.black),
        color: App.grey,
          borderRadius: BorderRadius.circular(8)
      ),
      child: child
    );
  }
  myCardItem(BuildContext context,
      {required Widget firstIcon, required String title, required Widget lastIcon}){
    return Container(
      color: App.grey,
      height: 24,
      child: Row(
        children: [
          firstIcon,
          SizedBox(width: 14,),
          Text(App_Localization.of(context).translate(title)),
          Spacer(),
          lastIcon
        ],
      ),
    );
  }


  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: App.midOrange,
        gradient: App.orangeGradient(),
        boxShadow: [App.box_shadow()],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    homeController.selected_bottom_nav_bar.value = 0;
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 25,
                  )),
              GestureDetector(
                onTap: () {
                  homeController.selected_bottom_nav_bar.value = 0;
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/logo/logo.png"))),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.transparent,
                    size: 25,
                  ))
            ],
          ),
          const SizedBox(),
          const SizedBox(),
          Global.customer == null
              ? const Center()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      App_Localization.of(context).translate("hello") + " ",
                      style: App.textBlod(Colors.white, 16),
                    ),
                    Text(
                      Global.customer!.firstname +
                          " " +
                          Global.customer!.lastname,
                      style: App.textNormal(Colors.white, 16),
                    ),
                  ],
                )
        ],
      ),
    );
  }


  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(App_Localization.of(context).translate("confirm")),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            profileController.deleteAccount(context);
          },
          child: Text(
            App_Localization.of(context).translate("yes"),
            style: TextStyle(color: App.midOrange),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            App_Localization.of(context).translate("no"),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
      content: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(App_Localization.of(context)
                .translate("are_you_sure_to_delete_account"))
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
