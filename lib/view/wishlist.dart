// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:albassel_version_1/wedgits/internal_header.dart';
import 'package:albassel_version_1/wedgits/plz_signin_signup.dart';
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
    return SafeArea(child: ConstrainedBox(
      constraints: BoxConstraints(
        minHeight:MediaQuery.of(context).size.height,
      ),
      child: Container(

          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Colors.white
            // image: DecorationImage(
            //     image: AssetImage("assets/background/background.png"),
            //     fit: BoxFit.cover
            // ),
          ),
          child: Column(
            children: [
              // _header(context),
              InternalHeader(),
              Expanded(
                  child: Global.customer==null?
                  PlzSigninSignup() :
                  Obx(()=>
                  wishListController.loading.value?
                  Center(child: CircularProgressIndicator(),):
                  wishListController.wishlist.isEmpty
                      ?Align(
                    alignment: Alignment.topCenter,
                        child: SizedBox(
                                            width: MediaQuery.of(context).size.width,
                                            height: 200,
                                            child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: 50,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.favorite_border,color: App.midOrange,size: 28,)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(App_Localization.of(context).translate("wishlist_empty"),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(App_Localization.of(context).translate("start_adding"),style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),),
                              // GestureDetector(onTap: (){homeController.selected_bottom_nav_bar.value=0;},child: Text(App_Localization.of(context).translate("start_shopping"),style: TextStyle(color: App.midOrange,fontWeight: FontWeight.bold),)),
                            ],
                          ),
                        ],
                                            ),
                                          ),
                      )
                      : _wish_list(context),)
              ),

            ],
          )
      ),
    ));
  }

  _wish_list(BuildContext context){
    return RefreshIndicator(
      onRefresh: ()=>wishListController.getData(),
      child: GridView.builder(
          // physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4/6
          ),
          shrinkWrap: true,
          itemCount: wishListController.wishlist.length,
          itemBuilder: (context ,index){
            var wishlistItem = wishListController.wishlist[index];
            return Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    App.softShadow
                  ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4,
                    child: Container(
                      decoration: BoxDecoration(

                          image: DecorationImage(
                            image: NetworkImage(wishlistItem.image),
                            fit: BoxFit.cover,
                          ),

                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            App.softShadow
                          ]
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(wishlistItem.getTitle(),style: const TextStyle(color: Colors.black,overflow: TextOverflow.clip,fontSize: 12),maxLines: 2,textAlign: TextAlign.center,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        wishlistItem.availability== 0?Container(
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
                          onTap: ()async{
                            wishlistItem.cartLoading(true);
                            await wishListController.moveToCart(wishlistItem.id,context);
                            wishlistItem.cartLoading(false);
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
                              child:Text(App_Localization.of(context).translate("move_cart"),style: App.textNormal(App.midOrange, 9),),
                            ),
                          ),
                        ),

                        IconButton(onPressed: (){
                          wishListController.deleteFromWishlist(wishlistItem.id,context);
                        }, icon: const Icon(Icons.delete,color: Colors.grey,))
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
