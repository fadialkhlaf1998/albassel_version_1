import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wishlist extends StatelessWidget {
  WishListController wishListController = Get.find();
  CartController cartController = Get.find();
  
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return SafeArea(child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              _header(context),
              _wish_list(context)
            ],
          )
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
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight:Radius.circular(25)),
        image: DecorationImage(
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
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4/7
      ),
      shrinkWrap: true,
        itemCount: wishListController.wishlist.length,
        itemBuilder: (context ,index){
          return Container(
            child: Column(
              children: [
                Expanded(flex: 5,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(wishListController.wishlist[index].image!.src!),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: App.orange,width: 2),
                        borderRadius: BorderRadius.circular(15)
                      ),
                    ),
                ),
                Expanded(flex: 2,child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(wishListController.wishlist[index].title!,style: TextStyle(color: Colors.black,overflow: TextOverflow.clip,fontSize: 12),maxLines: 2,textAlign: TextAlign.center,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: (){
                            cartController.add_to_cart(wishListController.wishlist[index], 1);
                            App.sucss_msg(context, App_Localization.of(context).translate("cart_msg"));
                          }, icon: Icon(Icons.shopping_cart_outlined,color: App.orange,)),
                          IconButton(onPressed: (){
                            wishListController.delete_from_wishlist(wishListController.wishlist[index]);
                          }, icon: Icon(Icons.delete,color: Colors.grey,))
                        ],
                      )
                    ],
                  ),
                ),),
              ],
            ),
          );
        });
  }
}
