// ignore_for_file: must_be_immutable, non_constant_identifier_names, invalid_use_of_protected_member

import 'dart:async';

import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/model_v2/cart.dart';
import 'package:albassel_version_1/view/checkout.dart';
import 'package:albassel_version_1/view/custom_web_view.dart';
import 'package:albassel_version_1/view/sign_in.dart';
import 'package:albassel_version_1/wedgits/plz_signin_signup.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Cart extends StatefulWidget {

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartController cartController = Get.find();

  HomeController homeController = Get.find();

  TextEditingController controller = TextEditingController();


  Timer? _holdTimer;
  bool _isHeld = false;

  void _onTap() {
    print("👆 Quick tap event");
    // Your tap action here
  }

  void _onTapDown(TapDownDetails details) {
    _isHeld = true;
    _holdTimer = Timer(Duration(seconds: 1), () {
      if (_isHeld) {
        print("⏳ Held for 1 second event");
        // Your hold action here
      }
    });
  }

  void _onTapUp(TapUpDetails details) {
    _isHeld = false;
    _holdTimer?.cancel();
  }

  void _onTapCancel() {
    _isHeld = false;
    _holdTimer?.cancel();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  return Obx((){
     return SafeArea(
       child: Stack(
         children: [
           Container(height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top,),
           SingleChildScrollView(
             child: Container(
               color: Colors.white,
               width: MediaQuery.of(context).size.width,
               child: Column(
                 children: [
                   _header(context),
                   Global.customer==null?
                   PlzSigninSignup() :

                   cartController.cart == null||cartController.cart!.cartList.isEmpty
                   ?SizedBox(
                     width: MediaQuery.of(context).size.width,
                     height: 90,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                              Icon(Icons.remove_shopping_cart_outlined,color: App.midOrange,size: 28,)
                           ],
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(App_Localization.of(context).translate("havent_cart_yet"),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                           ],
                         ),

                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             // Text(App_Localization.of(context).translate("order_no_data"),style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),),
                             GestureDetector(onTap: (){homeController.selected_bottom_nav_bar.value=0;},child: Text(App_Localization.of(context).translate("start_shopping_now"),style: TextStyle(color: App.midOrange,fontWeight: FontWeight.bold),)),
                           ],
                         ),
                       ],
                     ),
                   )
                   :Column(
                     children: [
                       // _autp_discount_list(context),
                       _product_list(context),
                       SizedBox(height: MediaQuery.of(context).size.height*0.5,)
                     ],
                   ),
                   // Container(height: double.parse(cartController.discount.value)>0||double.parse(cartController.coupon.value)>0?
                   // double.parse(cartController.discount.value)>0&&double.parse(cartController.coupon.value)>0?
                   // 315:290:270,)
                 ],
               ),
             ),
           ),
           Positioned(child: _header(context),top: 0,),
           Positioned(child:  _check_out(context),bottom: 0,),
           cartController.loading.value
               ?Container(
             width: Get.width,
             height: Get.height,
             color: Colors.white.withOpacity(0.5),
             child: Center(
               child: CircularProgressIndicator(),
             ),
           )
               :Center()
           // Positioned(bottom:-1,child:  _check_out(context))
         ],
       ),
     );
   });
  }

  autoDiscountCard(CartItem item){
    return Column(
      children: [
        Container(

          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.15,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.height*0.15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color:Colors.grey,width: 2),
                    image: DecorationImage(
                        image: NetworkImage( item.image),
                        fit: BoxFit.cover
                    )
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.4,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title,style: const TextStyle(color: Colors.black,fontSize: 14,overflow: TextOverflow.clip,),textAlign: TextAlign.left,),
                    item.availability==0?
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width*0.3,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Text(App_Localization.of(context).translate("out_of_stock"),style: const TextStyle(color: Colors.red,fontSize: 12),),
                      ),
                    )
                        : Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width*0.3,
                      decoration: BoxDecoration(
                          color: App.midOrange,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(item.count.toString()+" X "+App_Localization.of(context).translate("free"),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(child:Text(App_Localization.of(context).translate("aed")+" "+item.totalPrice.toStringAsFixed(2),style: const TextStyle(
                      color: Colors.black26,
                      fontSize: 14,
                      decoration: TextDecoration.lineThrough,
                    ),),),
                    IconButton(onPressed: (){
                      // cartController.remove_from_cart(cartController.auto_discount[index]);
                    }, icon: const Icon(Icons.delete,size: 25,color: Colors.transparent,))
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20,),

        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: DottedLine(
            dashColor: Colors.grey,
            lineLength: MediaQuery.of(context).size.width*0.6+MediaQuery.of(context).size.height*0.15,
          ),
        ),

      ],
    );
  }

  _price(BuildContext context , int index){
    return 
    //   double.parse(cartController.cart!.cartList[index].discount.value)>0&&
    //     cartController.canDiscountCode.value?
    // SizedBox(
    //   width: MediaQuery.of(context).size.width * 0.6,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       FittedBox(
    //         child:
    //         Text(App_Localization.of(context).translate("aed") +" "+ (double.parse(cartController.cart!.cartList[index].price.value)-double.parse(cartController.cart!.cartList[index].discount.value)).toStringAsFixed(2) ,
    //           style: TextStyle(
    //               color: App.midOrange,
    //               fontSize: 14,
    //               fontWeight:
    //               FontWeight.bold),
    //         ),
    //       ),
    //       FittedBox(
    //         child: Text( App_Localization.of(context).translate("aed")+" "+double.parse(cartController.cart!.cartList[index].price.value).toStringAsFixed(2),
    //           style: const TextStyle(
    //               color: Colors.black26,
    //               decoration: TextDecoration.lineThrough,
    //               decorationColor: Colors.black26,
    //               decorationStyle: TextDecorationStyle.solid,
    //               decorationThickness: 1.5,
    //               fontSize: 14,
    //               fontWeight:
    //               FontWeight.bold),
    //         ),
    //       ),
    //
    //     ],
    //   ),
    // ) :
    SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: FittedBox(
        child: Text(App_Localization.of(context).translate("aed")+" "+ cartController.cart!.cartList[index].totalPrice.toStringAsFixed(2),
          style: TextStyle(
              color: App.midOrange,
              fontSize: 14,
              fontWeight:
              FontWeight.bold),
        ),
      ),
    );
  }

  // _autp_discount_list(BuildContext context){
  //   return ListView.builder(
  //       shrinkWrap: true,
  //       itemCount: cartController.auto_discount.length,
  //       physics: const NeverScrollableScrollPhysics(),
  //       itemBuilder: (context,index){
  //         return Column(
  //           children: [
  //             Container(
  //
  //               width: MediaQuery.of(context).size.width,
  //               height: MediaQuery.of(context).size.height*0.15,
  //               color: Colors.white,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   Container(
  //                     width: MediaQuery.of(context).size.height*0.15,
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(20),
  //                         border: Border.all(color:Colors.grey,width: 2),
  //                         image: DecorationImage(
  //                             image: NetworkImage( cartController.auto_discount.value[index].product.value.image),
  //                             fit: BoxFit.cover
  //                         )
  //                     ),
  //                   ),
  //                   Container(
  //                     width: MediaQuery.of(context).size.width*0.4,
  //                     color: Colors.white,
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(cartController.auto_discount.value[index].product.value.title,style: const TextStyle(color: Colors.black,fontSize: 14,overflow: TextOverflow.clip,),textAlign: TextAlign.left,),
  //                         cartController.auto_discount[index].product.value.availability==0?
  //                         Container(
  //                           height: 40,
  //                           width: MediaQuery.of(context).size.width*0.3,
  //                           decoration: BoxDecoration(
  //                               border: Border.all(color: Colors.red),
  //                               color: Colors.grey[300],
  //                               borderRadius: BorderRadius.circular(20)
  //                           ),
  //                           child: Center(
  //                             child: Text(App_Localization.of(context).translate("out_of_stock"),style: const TextStyle(color: Colors.red,fontSize: 12),),
  //                           ),
  //                         )
  //                             : Container(
  //                           height: 40,
  //                           width: MediaQuery.of(context).size.width*0.3,
  //                           decoration: BoxDecoration(
  //                               color: App.midOrange,
  //                               borderRadius: BorderRadius.circular(20)
  //                           ),
  //                           child: Center(
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 Text(cartController.auto_discount[index].quantity.toString()+" X "+App_Localization.of(context).translate("free"),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: MediaQuery.of(context).size.width*0.2,
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         FittedBox(child:Text(App_Localization.of(context).translate("aed")+" "+double.parse(cartController.auto_discount[index].price.value).toStringAsFixed(2),style: const TextStyle(
  //                         color: Colors.black26,
  //                         fontSize: 14,
  //                         decoration: TextDecoration.lineThrough,
  //                         ),),),
  //                         IconButton(onPressed: (){
  //                           // cartController.remove_from_cart(cartController.auto_discount[index]);
  //                         }, icon: const Icon(Icons.delete,size: 25,color: Colors.transparent,))
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             const SizedBox(height: 20,),
  //
  //             Padding(
  //               padding: const EdgeInsets.only(bottom: 20),
  //               child: DottedLine(
  //                 dashColor: Colors.grey,
  //                 lineLength: MediaQuery.of(context).size.width*0.6+MediaQuery.of(context).size.height*0.15,
  //               ),
  //             ),
  //
  //           ],
  //         );
  //       });
  // }

  _product_list(BuildContext context){
    return ListView.builder(
      shrinkWrap: true,
        itemCount: cartController.cart!.cartList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
        if(cartController.cart!.cartList[index].isAutoDiscount){
          return autoDiscountCard(cartController.cart!.cartList[index]);
        }
      return Column(
        children: [
          Container(

            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.15,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.height*0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color:Colors.grey,width: 2),
                    image: DecorationImage(
                      image: NetworkImage( cartController.cart!.cartList[index].image),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartController.cart!.cartList[index].title+
                          (cartController.cart!.cartList[index].optionTitle.length>0?" | "+cartController.cart!.cartList[index].optionTitle:""),style: const TextStyle(color: Colors.black,fontSize: 14,overflow: TextOverflow.clip,),textAlign: TextAlign.left,),
                      cartController.cart!.discountCode != null&&
                      !cartController.cart!.cartList[index].includeDiscount?
                      Text(App_Localization.of(context).translate("this_product_illegal"),style: const TextStyle(color: Colors.red,fontSize: 12),):Center(),

                      // cartController.discountCode != null&&
                      // cartController.amountOfCanDiscount > cartController.discountCode!.minimumQuantity&&
                      //     double.parse(cartController.cart!.cartList[index].discount.value)> 0?
                      // Text(App_Localization.of(context).translate("you_saved")
                      //     +" "+cartController.cart!.cartList[index].discount.value+" "+App_Localization.of(context).translate("aed")+" "
                      //     +App_Localization.of(context).translate("on_this_item"),style: const TextStyle(color: Colors.green,fontSize: 12),):Center(),
                      cartController.cart!.cartList[index].availability==0?
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width*0.3,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: Text(App_Localization.of(context).translate("out_of_stock"),style: const TextStyle(color: Colors.red,fontSize: 12),),
                        ),
                      )
                      : Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width*0.3,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(onPressed: (){
                                cartController.addOrUpdateCart(
                                    cartController.cart!.cartList[index].productId,cartController.cart!.cartList[index].optionId,-1,context);
                              }, icon: const Icon(Icons.remove,)),

                              Expanded(
                                child: GestureDetector(
                                  onTap: (){
                                    _showCounterPicker(cartController.cart!.cartList[index]);
                                  },
                                  child: Container(
                                      color: Colors.grey[200],
                                      child: Center(child: Text(cartController.cart!.cartList[index].count.toString()))),
                                ),
                              ),

                              IconButton(onPressed: (){
                                cartController.addOrUpdateCart(
                                    cartController.cart!.cartList[index].productId,cartController.cart!.cartList[index].optionId,1,context);
                              }, icon: const Icon(Icons.add,)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // FittedBox(child:Text(App_Localization.of(context).translate("aed")+" "+double.parse(cartController.cart!.cartList[index].price.value).toStringAsFixed(2),style: App.textNormal(App.orange, 14),),),
                      _price(context,index),
                      IconButton(onPressed: (){
                        cartController.deleteFromCart(
                            cartController.cart!.cartList[index].cartId,context);
                      }, icon: const Icon(Icons.delete,size: 25,color: Colors.grey,))
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),

          index!=cartController.cart!.cartList.length-1?Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: DottedLine(
              dashColor: Colors.grey,
              lineLength: MediaQuery.of(context).size.width*0.6+MediaQuery.of(context).size.height*0.15,
            ),
          ):const Center(),

        ],
      );
    });
  }


  void _showCounterPicker(CartItem cartItem) {
    int selectedValue = cartItem.count;
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 320,
        // color: Colors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 300,
                color: Colors.white,
                child: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      // Top bar with Done button

                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: 40,
                          scrollController: FixedExtentScrollController(initialItem: selectedValue-1),
                          onSelectedItemChanged: (int value) {
                            setState(() {
                              selectedValue = value+1;
                            });
                          },
                          children: List<Widget>.from(
                            List.generate(
                              cartItem.availability,
                                  (index) => index + 1, // generates 1..availability
                            ).map((number) => Center(
                              child: Text(
                                "$number",
                                style: TextStyle(fontSize: 20),
                              ),
                            )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          cartController.addOrUpdateCart(cartItem.productId,
                              cartItem.optionId, selectedValue-cartItem.count, context);
                          Get.back();
                        },
                        child: Container(
                          width: Get.width*0.9,
                          height: 50,
                          decoration: BoxDecoration(
                            color: App.orange,
                            borderRadius: BorderRadius.circular(25)
                          ),

                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle_outline,color: Colors.white,),
                              SizedBox(width: 5,),
                              Text(
                                App_Localization.of(context).translate("submit"),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 10,
              child: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        // border: Border.all(color: Colors.black)
                        boxShadow: [
                          App.softShadow
                        ]
                    ),
                    child: Icon(Icons.close,color: Colors.black,size: 30,)),
              ),
            )
          ],
        ),
      ),
    );
  }

  _header(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: IconButton(onPressed: (){
                homeController.selected_bottom_nav_bar.value=0;
              }, icon: const Icon(Icons.arrow_back_ios,size: 30,)),
            ),
            Text(App_Localization.of(context).translate("cart_title"),style: App.textBlod(Colors.black, 24),),
            IconButton(onPressed: (){

            }, icon: const Icon(Icons.list,color: Colors.transparent,)),
          ],
        ),
      ),
    );
  }

  _check_out(BuildContext context){
    return cartController.cart==null||cartController.cart!.cartList.isEmpty?const Center():Container(
    width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(topRight:  Radius.circular(20),topLeft:  Radius.circular(20)),
        boxShadow: [
          App.box_shadow()
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(App_Localization.of(context).translate("total"),style: App.textBlod(Colors.black, 20),),
                GestureDetector(
                  onTap: (){
                    Get.to(()=>TabbyWebView("https://checkout.tabby.ai/promos/product-page/installments/en/?price=${(cartController.cart!.total).toString()}&currency=AED"));
                  },
                  child: Container(
                    // width: Get.width * 0.9,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        // border: Border.all(color: Color(0xffd6d6d3)),
                        borderRadius: BorderRadius.circular(7)
                    ),
                    child: Row(
                      children: [
                        Container(
                          // width: Get.width*0.9 - 92,
                          width: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(App_Localization.of(context).translate("tabby_promotion"),style: TextStyle(fontSize: 10),)
                            ],
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 25,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/logo/tabby.png"))
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(App_Localization.of(context).translate("sub_total"),style: App.textNormal(Colors.black, 14),),
                DottedLine(
                 dashColor: Colors.grey,
                  lineLength: MediaQuery.of(context).size.width*0.5,
                ),
                Text(App_Localization.of(context).translate("aed")+" "+cartController.cart!.subTotal.toStringAsFixed(2))
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(App_Localization.of(context).translate("shipping"),style: App.textNormal(Colors.black, 14),),
                // DottedLine(
                //   dashColor: Colors.grey,
                //   lineLength: 100,
                // ),
                // Text(App_Localization.of(context).translate("aed")+" "+ double.parse(cartController.shipping.value).toStringAsFixed(2))
                Text(App_Localization.of(context).translate("Shipping_will_be_calculated_at_checkout"))
              ],
            ),
            cartController.cart!.discount > 0 ?const SizedBox(height: 5,):const Center(),
            cartController.cart!.discount > 0?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(App_Localization.of(context).translate("discount"),style: App.textNormal(Colors.black, 14),),
                DottedLine(
                  dashColor: Colors.grey,
                  lineLength: MediaQuery.of(context).size.width*0.5,
                ),
                Text(cartController.cart!.discount.toStringAsFixed(0)+" %")
              ],
            ):const Center(),


            cartController.cart!.coupon > 0?const SizedBox(height: 5,):const Center(),
            cartController.cart!.coupon > 0?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(App_Localization.of(context).translate("coupon"),style: App.textNormal(Colors.black, 14),),
                DottedLine(
                  dashColor: Colors.grey,
                  lineLength: MediaQuery.of(context).size.width*0.5,
                ),
                Text(App_Localization.of(context).translate("aed")+" "+ cartController.cart!.coupon.toStringAsFixed(2))
              ],
            ):const Center(),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(App_Localization.of(context).translate("tax")+" "+App_Localization.of(context).translate("included"),style: App.textNormal(Colors.black, 14),),
                DottedLine(
                  dashColor: Colors.grey,
                  lineLength: MediaQuery.of(context).size.width*0.5 - 20,
                ),
                Text(App_Localization.of(context).translate("aed")+" "+ cartController.cart!.tax.toStringAsFixed(2))
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(App_Localization.of(context).translate("total"),style: App.textNormal(Colors.black, 14),),
                DottedLine(
                  dashColor: Colors.grey,
                  lineLength: MediaQuery.of(context).size.width*0.5,
                ),
                Text(App_Localization.of(context).translate("aed")+" "+cartController.cart!.total.toStringAsFixed(2))
              ],
            ),
            cartController.cart!.discountCode != null&&cartController.cart!.discountErrorMsg.length > 0?
            cartController.cart!.discountErrorMsg == "you_did_not_reach_min_amount"?
            Text(
              App_Localization.of(context).translate("you_did_not_reach_min_amount")+" "+
                  cartController.cart!.discountCode!.minimumQuantity.toStringAsFixed(2)+" "+App_Localization.of(context).translate("aed"),style: App.textNormal(Colors.red, 14),overflow: TextOverflow.clip,) :
            Text(cartController.cart!.discountErrorMsg ,style: App.textNormal(Colors.red, 14),overflow: TextOverflow.clip,):const Center(),
            activateDicountCode(context),
            const SizedBox(height: 5,),

            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      if(cartController.cart!.cartList.isNotEmpty){

                        if(Global.customer!=null){
                          Get.to(()=>Checkout());
                          //todo checking logic why customer_type is 0 at below if
                          // if(Global.customer_type!=0){
                          //
                          // }else{
                          //   Get.to(()=>Checkout(cartController.sub_total.value,cartController.shipping.value,(double.parse(cartController.sub_total.value)+double.parse(cartController.shipping.value)).toString()));
                          // }
                        }else{
                          // App.error_msg(context, App_Localization.of(context).translate("login_first"));
                          Get.to(()=>SignIn(true));
                        }
                      }else{
                        App.error_msg(context, App_Localization.of(context).translate("cart_empty"));
                      }

                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.7,
                      height: 50,
                      decoration: BoxDecoration(
                        color: App.orange,
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Center(
                        child: Text(App_Localization.of(context).translate("p_checkout").toUpperCase(),style: App.textNormal(Colors.white, 14),),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  activateDicountCode(BuildContext context){
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.92,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.92-70,
            child: TextField(
              controller: cartController.discountCodeController,
              decoration: InputDecoration(
                  label: Text(App_Localization.of(context).translate("discount_code")),
                  labelStyle: TextStyle(color: App.midOrange),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1,color: App.midOrange)
                  )
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              cartController.apply(context);
            },
            child: SizedBox(
              width: 70,
              child: Center(
                child: Text(App_Localization.of(context).translate("apply"),style: TextStyle(color: App.midOrange),),
              ),
            ),
          )
        ],
      ),
    );
  }
}
