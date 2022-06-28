// ignore_for_file: must_be_immutable, non_constant_identifier_names, invalid_use_of_protected_member

import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/view/checkout.dart';
import 'package:albassel_version_1/view/sign_in.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {
  CartController cartController = Get.find();
  HomeController homeController = Get.find();
  Cart({Key? key}) : super(key: key){
    cartController.get_total();
    if(cartController.discountCode!=null){
      cartController.discountCodeController.text = cartController.discountCode!.code;
    }
  }
  TextEditingController controller = TextEditingController();

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
                   cartController.my_order.isEmpty
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
                             Text(App_Localization.of(context).translate("dont_have_order"),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                           ],
                         ),

                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(App_Localization.of(context).translate("order_no_data"),style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),),
                             GestureDetector(onTap: (){homeController.selected_bottom_nav_bar.value=0;},child: Text(App_Localization.of(context).translate("start_shopping"),style: TextStyle(color: App.midOrange,fontWeight: FontWeight.bold),)),
                           ],
                         ),
                       ],
                     ),
                   )
                   :Column(
                     children: [
                       _autp_discount_list(context),
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
           Positioned(child:  _check_out(context),bottom: 0,)
           // Positioned(bottom:-1,child:  _check_out(context))
         ],
       ),
     );
   });
  }
  _price(BuildContext context , int index){
    return double.parse(cartController.my_order[index].discount.value)>0&&
        cartController.canDiscountCode.value?
    SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child:
            Text(App_Localization.of(context).translate("aed") +" "+ (double.parse(cartController.my_order[index].price.value)-double.parse(cartController.my_order[index].discount.value)).toStringAsFixed(2) ,
              style: TextStyle(
                  color: App.midOrange,
                  fontSize: 14,
                  fontWeight:
                  FontWeight.bold),
            ),
          ),
          FittedBox(
            child: Text( App_Localization.of(context).translate("aed")+" "+double.parse(cartController.my_order[index].price.value).toStringAsFixed(2),
              style: const TextStyle(
                  color: Colors.black26,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.black26,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationThickness: 1.5,
                  fontSize: 14,
                  fontWeight:
                  FontWeight.bold),
            ),
          ),

        ],
      ),
    )
        :SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: FittedBox(
        child: Text(App_Localization.of(context).translate("aed")+" "+ double.parse(cartController.my_order[index].price.value).toStringAsFixed(2),
          style: TextStyle(
              color: App.midOrange,
              fontSize: 14,
              fontWeight:
              FontWeight.bold),
        ),
      ),
    );
  }
  _autp_discount_list(BuildContext context){
    return ListView.builder(
        shrinkWrap: true,
        itemCount: cartController.auto_discount.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
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
                              image: NetworkImage( cartController.auto_discount.value[index].product.value.image),
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
                          Text(cartController.auto_discount.value[index].product.value.title,style: const TextStyle(color: Colors.black,fontSize: 14,overflow: TextOverflow.clip,),textAlign: TextAlign.left,),
                          cartController.auto_discount[index].product.value.availability==0?
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
                                  Text(cartController.auto_discount[index].quantity.toString()+" X "+App_Localization.of(context).translate("free"),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
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
                          FittedBox(child:Text(App_Localization.of(context).translate("aed")+" "+double.parse(cartController.auto_discount[index].price.value).toStringAsFixed(2),style: const TextStyle(
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
        });
  }
  _product_list(BuildContext context){
    return ListView.builder(
      shrinkWrap: true,
        itemCount: cartController.my_order.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
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
                      image: NetworkImage( cartController.my_order.value[index].product.value.image),
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
                       Text(cartController.my_order.value[index].product.value.title,style: const TextStyle(color: Colors.black,fontSize: 14,overflow: TextOverflow.clip,),textAlign: TextAlign.left,),
                      cartController.my_order[index].product.value.availability==0?
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
                                cartController.decrease(cartController.my_order[index],index);
                              }, icon: const Icon(Icons.remove,)),

                              Text(cartController.my_order.value[index].quantity.value.toString()),

                              IconButton(onPressed: (){

                                cartController.increase(cartController.my_order[index],index);
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
                      // FittedBox(child:Text(App_Localization.of(context).translate("aed")+" "+double.parse(cartController.my_order[index].price.value).toStringAsFixed(2),style: App.textNormal(App.orange, 14),),),
                      _price(context,index),
                      IconButton(onPressed: (){
                        cartController.remove_from_cart(cartController.my_order[index]);
                      }, icon: const Icon(Icons.delete,size: 25,color: Colors.grey,))
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),

          index!=cartController.my_order.length-1?Padding(
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
    return cartController.my_order.isEmpty?const Center():Container(
      

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
              children: [
                Text(App_Localization.of(context).translate("total"),style: App.textBlod(Colors.black, 20),)
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
                Text(App_Localization.of(context).translate("aed")+" "+double.parse(cartController.sub_total.value).toStringAsFixed(2))
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(App_Localization.of(context).translate("shipping"),style: App.textNormal(Colors.black, 14),),
                DottedLine(
                  dashColor: Colors.grey,
                  lineLength: MediaQuery.of(context).size.width*0.5,
                ),
                Text(App_Localization.of(context).translate("aed")+" "+ double.parse(cartController.shipping.value).toStringAsFixed(2))
              ],
            ),
            double.parse(cartController.discount.value)>0&&cartController.canDiscountCode.value?const SizedBox(height: 5,):const Center(),
            double.parse(cartController.discount.value)>0&&cartController.canDiscountCode.value?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(App_Localization.of(context).translate("discount"),style: App.textNormal(Colors.black, 14),),
                DottedLine(
                  dashColor: Colors.grey,
                  lineLength: MediaQuery.of(context).size.width*0.5,
                ),
                Text(cartController.discount.value+" %")
              ],
            ):const Center(),
            double.parse(cartController.coupon.value)>0&&cartController.canDiscountCode.value?const SizedBox(height: 5,):const Center(),
            double.parse(cartController.coupon.value)>0&&cartController.canDiscountCode.value?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(App_Localization.of(context).translate("coupon"),style: App.textNormal(Colors.black, 14),),
                DottedLine(
                  dashColor: Colors.grey,
                  lineLength: MediaQuery.of(context).size.width*0.5,
                ),
                Text(App_Localization.of(context).translate("aed")+" "+ double.parse(cartController.coupon.value).toStringAsFixed(2))
              ],
            ):const Center(),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(App_Localization.of(context).translate("tax")+" "+App_Localization.of(context).translate("included"),style: App.textNormal(Colors.black, 14),),
                DottedLine(
                  dashColor: Colors.grey,
                  lineLength: MediaQuery.of(context).size.width*0.5,
                ),
                Text(App_Localization.of(context).translate("aed")+" "+ double.parse(cartController.tax.value).toStringAsFixed(2))
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
                Text(App_Localization.of(context).translate("aed")+" "+(double.parse(cartController.total.value)).toStringAsFixed(2))
              ],
            ),
            activateDicountCode(context),
            const SizedBox(height: 5,),
            // Row(
            //   children: [
            //     Container(
            //       width: MediaQuery.of(context).size.width*0.9,
            //       height: 45,
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(50),
            //         border: Border.all(width: 1,color: Colors.grey)
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.only(left: 15,right: 15),
            //         child: TextField(
            //           style: App.textBlod(Colors.grey, 14),
            //           textAlignVertical: TextAlignVertical.center,
            //           controller: controller,
            //           decoration: InputDecoration(
            //             focusedBorder:  UnderlineInputBorder(
            //               borderSide: BorderSide(color: Colors.transparent)
            //             ),
            //             enabledBorder: UnderlineInputBorder(
            //                 borderSide: BorderSide(color: Colors.transparent)
            //             ),
            //             hintText: App_Localization.of(context).translate("voucher_code"),
            //             hintStyle: App.textBlod(Colors.grey, 14),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      if(cartController.my_order.value.isNotEmpty){

                        if(Global.customer!=null){
                          if(Global.customer_type!=0||Global.customer!.country.toLowerCase()!="ae"){
                            if(Global.customer!.country.toLowerCase()!="ae"){
                              App.error_msg(context, App_Localization.of(context).translate("cannot_order_out_ae"));
                            }else{
                              Get.to(()=>Checkout(cartController.sub_total.value,cartController.shipping.value,(double.parse(cartController.sub_total.value)+double.parse(cartController.shipping.value)).toString()));
                            }

                          }else{
                            Get.to(()=>Checkout(cartController.sub_total.value,cartController.shipping.value,(double.parse(cartController.sub_total.value)+double.parse(cartController.shipping.value)).toString()));
                          }
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
