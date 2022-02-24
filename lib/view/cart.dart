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
  Cart(){
    cartController.get_total();
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
                   ?Container(
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
                             Text(App_Localization.of(context).translate("dont_have_order"),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                           ],
                         ),

                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(App_Localization.of(context).translate("order_no_data"),style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),),
                             GestureDetector(onTap: (){homeController.selected_bottom_nav_bar.value=0;},child: Text(App_Localization.of(context).translate("start_shopping"),style: TextStyle(color: App.midOrange,fontWeight: FontWeight.bold),)),
                           ],
                         ),
                       ],
                     ),
                   )
                   :_product_list(context),
                   Container(height: MediaQuery.of(context).size.height*0.35,)
                 ],
               ),
             ),
           ),
           Positioned(child: _header(context),top: 0,),
           Positioned(bottom:-1,child:  _check_out(context))
         ],
       ),
     );
   });
  }
  _product_list(BuildContext context){
    return ListView.builder(
      shrinkWrap: true,
        itemCount: cartController.my_order.length,
        physics: NeverScrollableScrollPhysics(),
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
                      image: NetworkImage( cartController.my_order.value[index].product.value.image==null?"https://st2.depositphotos.com/1491329/8004/i/950/depositphotos_80041516-stock-photo-girl-with-healthy-brown-hair.jpg":cartController.my_order.value[index].product.value.image),
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
                       Text(cartController.my_order.value[index].product.value.title,style: TextStyle(color: Colors.black,fontSize: 14,overflow: TextOverflow.clip,),textAlign: TextAlign.left,),
                       Container(
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

                                cartController.increase(cartController.my_order[index],index);
                              }, icon: Icon(Icons.add,)),
                              Text(cartController.my_order.value[index].quantity.value.toString()),
                              IconButton(onPressed: (){
                                cartController.decrease(cartController.my_order[index],index);
                              }, icon: Icon(Icons.remove,))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(App_Localization.of(context).translate("aed")+" "+double.parse(cartController.my_order[index].price.value).toStringAsFixed(2),style: App.textNormal(App.orange, 14),),
                      IconButton(onPressed: (){
                        cartController.remove_from_cart(cartController.my_order[index]);
                      }, icon: Icon(Icons.delete,size: 25,color: Colors.grey,))
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),

          index!=cartController.my_order.length-1?Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: DottedLine(
              dashColor: Colors.grey,
              lineLength: MediaQuery.of(context).size.width*0.6+MediaQuery.of(context).size.height*0.15,
            ),
          ):Center(),

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
              }, icon: Icon(Icons.arrow_back_ios,size: 30,)),
            ),
            Text(App_Localization.of(context).translate("cart_title"),style: App.textBlod(Colors.black, 24),),
            IconButton(onPressed: (){

            }, icon: Icon(Icons.list,color: Colors.transparent,)),
          ],
        ),
      ),
    );
  }
  _check_out(BuildContext context){
    return cartController.my_order.isEmpty?Center():Container(
      
      height: MediaQuery.of(context).size.height*0.3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
        boxShadow: [
          App.box_shadow()
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          Get.to(()=>Checkout(cartController.sub_total.value,cartController.shipping.value,(double.parse(cartController.sub_total.value)+double.parse(cartController.shipping.value)).toString()));
                        }else{
                          // App.error_msg(context, App_Localization.of(context).translate("login_first"));
                          Get.to(SignIn(true));
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

}
