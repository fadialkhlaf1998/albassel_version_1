// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Wishlist extends StatelessWidget {
  WishListController wishListController = Get.find();
  CartController cartController = Get.find();
  HomeController homeController = Get.find();

  Wishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Obx((){
      return SafeArea(child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:MediaQuery.of(context).size.height,
          ),
          child: Container(

            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background/background.png"),
                  fit: BoxFit.cover
              ),
            ),
            child: Column(
              children: [
                _header(context),
                _wish_list(context)
              ],
            )
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
        color: App.orange,
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight:Radius.circular(25)),
        image: const DecorationImage(
          image: AssetImage("assets/background/wishlist.png"),
          fit: BoxFit.cover
        ),
        boxShadow: [
          App.box_shadow()
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              IconButton(onPressed: (){
                homeController.selected_bottom_nav_bar.value=0;
              }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 25,))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(App_Localization.of(context).translate("wishlist"),style: App.textBlod(Colors.white, 40),)
            ],
          )
        ],
      ),
    );
  }
  _wish_list(BuildContext context){
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4/6
      ),
      shrinkWrap: true,
        itemCount: wishListController.wishlist.length,
        itemBuilder: (context ,index){
          return Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 4,
                    child: Container(
                      decoration: BoxDecoration(

                        image: DecorationImage(
                          image: NetworkImage(wishListController.wishlist[index].image),
                          fit: BoxFit.cover,
                        ),

                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: Colors.black38.withOpacity(0.1), spreadRadius: 0, blurRadius: 2,offset: const Offset(0,4))
                        ]
                      ),
                    ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(wishListController.wishlist[index].title,style: const TextStyle(color: Colors.black,overflow: TextOverflow.clip,fontSize: 12),maxLines: 2,textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wishListController.wishlist[index].availability== 0?Container(
                  width: MediaQuery.of(context).size.width*0.2,
                  height: 25,

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(color: Colors.red)
                  ),
                  child: Center(
                    child: Text(App_Localization.of(context).translate("out_of_stock"),style: App.textNormal(Colors.red, 9),),
                  ),
                ):
                      GestureDetector(
                        onTap: (){
                          if(cartController.add_to_cart(wishListController.wishlist[index], 1,context)){
                            wishListController.wishlist[index].favorite.value=false;
                            wishListController.wishlist.removeAt(index);
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.2,
                          height: 25,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: App.midOrange)
                          ),
                          child: Center(
                            child: Text(App_Localization.of(context).translate("move_cart"),style: App.textNormal(App.midOrange, 9),),
                          ),
                        ),
                      ),
                      // IconButton(onPressed: (){
                      //   cartController.add_to_cart(wishListController.wishlist[index], 1);
                      //   App.sucss_msg(context, App_Localization.of(context).translate("cart_msg"));
                      // }, icon: Icon(Icons.shopping_cart_outlined,color: App.orange,)),
                      IconButton(onPressed: (){
                        wishListController.delete_from_wishlist(wishListController.wishlist[index]);
                      }, icon: const Icon(Icons.delete,color: Colors.grey,))
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
