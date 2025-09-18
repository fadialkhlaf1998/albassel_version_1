// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/controler/profile_controller.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/view/address.dart';
import 'package:albassel_version_1/view/customer_order.dart';
import 'package:albassel_version_1/view/my_address.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:albassel_version_1/view/sign_in.dart';
import 'package:albassel_version_1/view/sign_up.dart';
import 'package:albassel_version_1/wedgits/plz_signin_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  ProfileController profileController = Get.put(ProfileController());
  TextEditingController newpass = TextEditingController();
  TextEditingController confNewpass = TextEditingController();
  HomeController homeController = Get.find();

  Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Obx(() {
      return SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
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
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.7 -
                                        MediaQuery.of(context).padding.top,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    _account_info(context),
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
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
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          width: Get.width * 0.9,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(color: Colors.black),
                                            boxShadow: [
                                                BoxShadow(color: Colors.black38.withOpacity(0.1), spreadRadius: 3, blurRadius: 2,offset: const Offset(0,0))
                                            ]
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.shopping_bag_outlined),
                                              SizedBox(width: 5,),
                                              Text(App_Localization.of(context).translate("my_order"),style: App.textBlod(Colors.black, 14)),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
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
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Center(
                                                  child: Text(
                                                    App_Localization.of(context)
                                                        .translate(
                                                            "change_pass"),
                                                    style: App.textBlod(
                                                        Colors.black, 14),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                showAlertDialog(context);
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Center(
                                                  child: Text(
                                                    App_Localization.of(context)
                                                        .translate(
                                                            "delete_account"),
                                                    style: App.textBlod(
                                                        Colors.black, 14),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        _adress(context),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
            Positioned(
                top: 0,
                child: homeController.product_loading.value
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey.withOpacity(0.4),
                        child: const Center(child: CircularProgressIndicator()),
                      )
                    : const Center())
          ],
        ),
      ));
    });
  }

  _account_info(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.black, width: 1)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(App_Localization.of(context).translate("account_info"),
                      style: App.textBlod(Colors.black, 14)),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
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
          )
        ],
      ),
    );
  }

  _adress(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(()=>AddressView());
        Get.to(() => MyAddress());
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.93,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: Colors.black)),
        child: Center(
          child: Row(
            children: [
              const SizedBox(width: 10),
              Text(
                App_Localization.of(context).translate("address"),
                style: App.textBlod(Colors.black, 14),
              ),
              const Spacer(),
              Text(
                App_Localization.of(context).translate("edit"),
                style: App.textNormal(Colors.black, 14),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  _wishlist(BuildContext context) {
    return GestureDetector(
      onTap: () {
        homeController.selected_bottom_nav_bar.value = 3;
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: Colors.black)),
        child: Center(
          child: Text(
            App_Localization.of(context).translate("wishlist"),
            style: App.textBlod(Colors.black, 14),
          ),
        ),
      ),
    );
  }

  _my_order(BuildContext context) {
    return GestureDetector(
      onTap: () {
        get_my_order(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            App_Localization.of(context).translate("my_order"),
            style: App.textBlod(Colors.black, 14),
          ),
        ),
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

  get_my_order(BuildContext context) {
    homeController.product_loading.value = true;
    MyApi.get_customer_order(Global.customer!.id).then((value) {
      homeController.product_loading.value = false;
      if (value.isNotEmpty) {
        Get.to(() => CustomerOrderView(value));
      } else {
        App.error_msg(
            context, App_Localization.of(context).translate("wrong_my_order"));
      }
    });
    //     .catchError((err){
    //    print(err);
    //   homeController.product_loading.value=false;
    //   App.error_msg(context, App_Localization.of(context).translate("wrong"));
    // });
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
