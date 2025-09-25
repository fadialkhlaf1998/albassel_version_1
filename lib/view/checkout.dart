// ignore_for_file: non_constant_identifier_names, must_be_immutable, unrelated_type_equality_checks, invalid_use_of_protected_member

import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/checkout_controller.dart';
import 'package:albassel_version_1/controler/my_address_controller.dart';
import 'package:albassel_version_1/view/add_edit_address.dart';
import 'package:albassel_version_1/view/my_fatoraah.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Checkout extends StatelessWidget {
  CheckoutController checkoutController = Get.put(CheckoutController());


  Checkout() {
    //todo check tabby session
    // checkoutController.lunch_session();
    getData();
  }
  getData()async{
    await checkoutController.myAddressController.getData();
    getShippingDataForSelectedAddress();
  }
  getShippingDataForSelectedAddress(){
    if(checkoutController.myAddressController.address.length > 0){
      checkoutController.cartController.getData(checkoutController.myAddressController.address[checkoutController.selectedAddress.value].id);
    }else{
      checkoutController.cartController.getData(null);
    }
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return WillPopScope(
      onWillPop: (){
        checkoutController.back();
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Obx(()=>Column(
            children: [
              _header(context),

              Expanded(child: checkoutController.selected_operation.value==0
                  ?_address(context):checkoutController.selected_operation.value==1
                  ?_payment(context):_summery(context)),

              _footer(context)
            ],
          ),),
        ),
      ),
    );
  }
  _header(BuildContext context){
    return Container(
      height: 130,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: (){
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back)
              ),
              Text(App_Localization.of(context).translate("checkout"),style: App.textBlod(Colors.black, 20),),
              IconButton(
                  onPressed: (){

                  },
                  icon: const Icon(Icons.arrow_back,color: Colors.transparent,)
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _orange_circle(context,App.midOrange),
                  Container(height: 1,width: 0.5*(MediaQuery.of(context).size.width-60-30-30-30),color: Colors.grey,),
                  _orange_circle(context,checkoutController.selected_operation>0?App.midOrange:Colors.white),
                  Container(height: 1,width: 0.5*(MediaQuery.of(context).size.width-60-30-30-30),color: Colors.grey,),
                  _orange_circle(context,checkoutController.selected_operation>1?App.midOrange:Colors.white),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25,right: 25),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(App_Localization.of(context).translate("address"),style: App.textNormal(Colors.black, 10),),

                  Text(App_Localization.of(context).translate("payment"),style: App.textNormal(Colors.black, 10),),

                  Text(App_Localization.of(context).translate("summary"),style: App.textNormal(Colors.black, 10),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  _orange_circle(BuildContext buildContext ,Color color){
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.grey)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color
            ),
          )
        ],
      ),
    );
  }
  _footer(BuildContext context){
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.1,
      width: MediaQuery.of(context).size.width,
      child: checkoutController.selected_operation==2?
            Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: (){
              checkoutController.add_order_shopyfi(context);
            },
            child: Container(
              height: MediaQuery.of(context).size.height*0.06,
              width: MediaQuery.of(context).size.width*0.35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.03),
                  border: Border.all(color: App.midOrange,width: 2),
                  color: App.midOrange
              ),
              child: Center(child: Text(App_Localization.of(context).translate("done"),style: App.textBlod(Colors.white, 16),)),
            ),
          ),
        ],
      )
          :Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: (){
              checkoutController.back();
            },
            child: Container(
              height: MediaQuery.of(context).size.height*0.06,
              width: MediaQuery.of(context).size.width*0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.03),
                border: Border.all(color: App.midOrange,width: 2),
              ),
              child: Center(child: Text(App_Localization.of(context).translate("back"),style: App.textBlod(App.midOrange, 16),)),
            ),
          ),
          GestureDetector(
            onTap: (){
              checkoutController.next(context);
            },
            child: Container(
              height: MediaQuery.of(context).size.height*0.06,
              width: MediaQuery.of(context).size.width*0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.03),
                border: Border.all(color: App.midOrange,width: 2),
                color: App.midOrange
              ),
              child: Center(child: Text(App_Localization.of(context).translate("next"),style: App.textBlod(Colors.white, 16),)),
            ),
          ),
        ],
      ),
    );
  }
  _address(BuildContext context){
    return Obx(()=>checkoutController.myAddressController.loading.value
        ?Container(
      child: Center(child: CircularProgressIndicator(),),
    )
        : Container(
      child: Column(
        children: [
          Container(
            width: Get.width,
            height: 70,
            child:
            checkoutController.cartController.loading.value?Center(child: LinearProgressIndicator(),):
            Center(
              child:checkoutController.myAddressController.address.isEmpty
                  ?Text(App_Localization.of(context).translate("there_is_no_address_plz_add_address"))
                  :(Text(App_Localization.of(context).translate("shipping_is")+" "+
                  (checkoutController.cartController.cart!.shipping==0?
                  App_Localization.of(context).translate("free"):
                  (checkoutController.cartController.cart!.shipping.toStringAsFixed(2)+" AED")),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
            ),
          ),
          Expanded(child:  ListView.builder(
            shrinkWrap: true,
            itemCount: checkoutController.myAddressController.address.length,
            itemBuilder: (context,index){
              var address = checkoutController.myAddressController.address[index];
              return Obx(()=>GestureDetector(
                onTap: ()async{
                  checkoutController.selectedAddress(index);
                  getShippingDataForSelectedAddress();
                },
                child: Card(
                  elevation: 4, // shadow
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                  width: 13,
                                  height: 13,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: checkoutController.selectedAddress.value == index?App.midOrange:Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8,),
                            Text(address.nickName,style: TextStyle(fontWeight: FontWeight.bold),),
                            Spacer(),
                            GestureDetector(
                              child: Row(
                                children: [
                                  const Icon(Icons.edit, color: Colors.grey,size: 20,),
                                  SizedBox(width: 5,),
                                  Text(App_Localization.of(context).translate("edit")),
                                ],
                              ),
                              onTap: () {
                                Get.to(()=> AddEditAddress(address))!.then((val)async {
                                  await checkoutController.myAddressController.getData();
                                  getShippingDataForSelectedAddress();
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 12,),
                        Container(width: Get.width,height: 1,color: Colors.grey,),
                        SizedBox(height: 12,),
                        Row(
                          children: [
                            Expanded(flex: 1,child: Text(App_Localization.of(context).translate("name"),style: TextStyle(color: Colors.grey),)),
                            Expanded(flex: 3,child: Text(address.first_name+" "+address.last_name)),
                          ],
                        ),
                        SizedBox(height: 8,),
                        Row(
                          children: [
                            Expanded(flex: 1,child: Text(App_Localization.of(context).translate("address"),style: TextStyle(color: Colors.grey),)),
                            Expanded(flex: 3,child: Text(address.emirate+" - "+address.city+" - "+address.address+" - "+address.apartment)),
                          ],
                        ),

                        SizedBox(height: 8,),
                        Row(
                          children: [
                            Expanded(flex: 1,child: Text(App_Localization.of(context).translate("phone"),style: TextStyle(color: Colors.grey),)),
                            Expanded(flex: 3,child: Text(address.phone)),
                          ],
                        ),
                        SizedBox(height: 8,),
                      ],
                    ),
                  ),
                ),
              ));
            },
          ),),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
              Get.to(AddEditAddress(null))!.then((val)async{
                await checkoutController.myAddressController.getData();
                getShippingDataForSelectedAddress();
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: App.midOrange),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Center(
                child: Text(App_Localization.of(context).translate("add_new_address"),style: TextStyle(color: App.midOrange),),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  _payment(BuildContext context){
    return !checkoutController.selected.value?
          SizedBox(
            height: MediaQuery.of(context).size.height*0.7-MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            child: checkoutController.cashewLoading.value?
                Center(
                  child: CircularProgressIndicator(),
                )
                : Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        App.box_shadow()
                      ]
                  ),
                  child: ListTile(
                    onTap: (){
                      checkoutController.selected_operation.value++;
                      checkoutController.selected.value=true;
                      checkoutController.is_paid.value=false;
                      checkoutController.is_cod.value=true;
                    },
                    leading:  CircleAvatar(
                      backgroundColor: App.midOrange,
                      child: Icon(Icons.delivery_dining ,color: Colors.white),
                    ),
                    title: Text(App_Localization.of(context).translate("cod")),
                    subtitle: Text(App_Localization.of(context).translate("cash")),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      App.box_shadow()
                    ]
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: App.midOrange,
                      child: Icon(Icons.credit_card,color: Colors.white,),
                    ),
                    onTap: (){
                      checkoutController.selected.value=true;
                      checkoutController.is_cod.value=false;
                    },
                    title: Text(App_Localization.of(context).translate("payment")),
                    subtitle: Text(App_Localization.of(context).translate("c_card")),
                  ),
                ),
                const SizedBox(height: 10,),
                checkoutController.cartController.cart!.total >= 10
                    ?Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        App.box_shadow()
                      ]
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: App.midOrange,
                      child: Icon(Icons.credit_card ,color: Colors.white,),
                    ),
                    onTap: (){
                      // checkoutController.selected.value=true;
                      // checkoutController.is_cod.value=false;
                      // checkoutController.add_order_installment_payment(context);
                      checkoutController.lunch_order_tabby(context);

                    },
                    title: Row(
                      children: [
                        // Text(App_Localization.of(context).translate("installment_payment")),
                        Container(
                          width: 57,
                          height: 25,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/logo/tabby.png",),fit: BoxFit.cover)
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(App_Localization.of(context).translate("tabby_promotion")),
                  ),
                ):Center(),
                const SizedBox(height: 10,),
                checkoutController.cartController.cart!.total >= 200
                    ?Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        App.box_shadow()
                      ]
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.credit_card),
                    ),
                    onTap: (){
                      // checkoutController.selected.value=true;
                      // checkoutController.is_cod.value=false;
                      checkoutController.add_order_installment_payment(context);
                      // checkoutController.lunch_order_tabby(context);

                    },
                    title: Row(
                      children: [
                        Text(App_Localization.of(context).translate("installment_payment")),
                        Container(
                          width: 80,
                          height: 25,
                          child: SvgPicture.asset("assets/icon/cashew.svg"),
                        )
                      ],
                    ),
                    subtitle: Text(App_Localization.of(context).translate("no_discount_installment_pay")),
                  ),
                ):Center(),

              ],
            ),
          )
        :SizedBox(
      height: MediaQuery.of(context).size.height*0.7-MediaQuery.of(context).padding.top,
      width: MediaQuery.of(context).size.width,
      child:MyFatoraahPage("title",checkoutController.cartController.cart!.total.toString()));

    //   MyFatoorah(
    //     onResult:(response){
    //       if(response.status==PaymentStatus.Success){
    //         checkoutController.my_order.addAll(checkoutController.cartController.my_order);
    //         checkoutController.add_order_payment(context);
    //         checkoutController.selected_operation++;
    //         checkoutController.is_paid.value=true;
    //       }else{
    //         checkoutController.selected.value=false;
    //       }
    //     },
    //     errorChild: Center(
    //       child: Icon(
    //         Icons.error,
    //         color: Colors.redAccent,
    //         size: 50,
    //       ),
    //     ),
    //     succcessChild: Center(
    //       child: Icon(
    //         Icons.done_all,
    //         color: Colors.greenAccent,
    //         size: 50,
    //       ),
    //     ),
    //     request: MyfatoorahRequest.test(
    //       currencyIso: Country.UAE,
    //       successUrl:
    //       'https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png',
    //       errorUrl:
    //       'https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png',
    //       invoiceAmount: double.parse(checkoutController.cartController.total.value),
    //       language: Global.lang_code=="en"?ApiLanguage.English:ApiLanguage.Arabic,
    //
    //
    //       token: "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
    //     ),
    //   ),
    // );
  }
  _summery(BuildContext context){
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height*0.25,
          child: ListView.builder(
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              shrinkWrap: true,
              itemCount: checkoutController.cartController.cart!.cartList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                var item = checkoutController.cartController.cart!.cartList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.height*0.15,
                    child: Column(
                      children: [
                        Expanded(flex:3,
                            child:Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                  image: DecorationImage(
                                      image: NetworkImage(item.image),
                                      fit: BoxFit.cover
                                  )
                              ),
                            )
                        ),
                        Expanded(flex:1,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            child: Column(
                              children: [
                                Text(item.getTitle()+" "+item.getOptionTitle(),style: const TextStyle(fontSize: 8,overflow: TextOverflow.ellipsis),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(App_Localization.of(context).translate("aed")+" "+item.totalPrice.toStringAsFixed(2),style: TextStyle(fontSize: 10,overflow: TextOverflow.ellipsis,color: App.midOrange)),
                                    Text(App_Localization.of(context).translate("quantity")+": "+item.count.toString(),style: const TextStyle(fontSize: 10,overflow: TextOverflow.ellipsis,color: Colors.black)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
        SizedBox(height: 30,),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.8,

          child:  Column(
            children: [
              Row(
                children: [
                  Text(
                    App_Localization.of(context).translate("sub_total"),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: LayoutBuilder(
                      builder: (BuildContext context,
                          BoxConstraints constraints) {
                        final boxWidth = constraints.constrainWidth();
                        const dashWidth = 4.0;
                        const dashHeight = 2.0;
                        final dashCount =
                        (boxWidth / (2 * dashWidth)).floor();
                        return Flex(
                          children: List.generate(dashCount, (_) {
                            return const SizedBox(
                              width: dashWidth,
                              height: dashHeight,
                              child: DecoratedBox(
                                decoration:
                                BoxDecoration(color: Colors.grey),
                              ),
                            );
                          }),
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          direction: Axis.horizontal,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    checkoutController.cartController.cart!.subTotal.toString() + " "+App_Localization.of(context).translate("aed"),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    App_Localization.of(context).translate("shipping"),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: LayoutBuilder(
                      builder: (BuildContext context,
                          BoxConstraints constraints) {
                        final boxWidth = constraints.constrainWidth();
                        const dashWidth = 4.0;
                        const dashHeight = 2.0;
                        final dashCount =
                        (boxWidth / (2 * dashWidth)).floor();
                        return Flex(
                          children: List.generate(dashCount, (_) {
                            return const SizedBox(
                              width: dashWidth,
                              height: dashHeight,
                              child: DecoratedBox(
                                decoration:
                                BoxDecoration(color: Colors.grey),
                              ),
                            );
                          }),
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          direction: Axis.horizontal,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    checkoutController.cartController.cart!.shipping.toString() + " "+App_Localization.of(context).translate("aed"),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    App_Localization.of(context).translate("total"),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: LayoutBuilder(
                      builder: (BuildContext context,
                          BoxConstraints constraints) {
                        final boxWidth = constraints.constrainWidth();
                        const dashWidth = 4.0;
                        const dashHeight = 2.0;
                        final dashCount =
                        (boxWidth / (2 * dashWidth)).floor();
                        return Flex(
                          children: List.generate(dashCount, (_) {
                            return const SizedBox(
                              width: dashWidth,
                              height: dashHeight,
                              child: DecoratedBox(
                                decoration:
                                BoxDecoration(color: Colors.grey),
                              ),
                            );
                          }),
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          direction: Axis.horizontal,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    checkoutController.cartController.cart!.total.toString() + " "+App_Localization.of(context).translate("aed"),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}


