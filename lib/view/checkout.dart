import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/checkout_controller.dart';
import 'package:albassel_version_1/view/home.dart';
import 'package:albassel_version_1/view/payment/ready_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_fatoorah/my_fatoorah.dart';

class Checkout extends StatelessWidget {
  CheckoutController checkoutController = Get.put(CheckoutController());
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(()=>Container(
            child:SingleChildScrollView(
              physics: checkoutController.selected_operation.value==1?NeverScrollableScrollPhysics():null,
              child: Column(
                children: [
                  _header(context),
                  checkoutController.selected_operation==0?_address(context):checkoutController.selected_operation==1?_payment(context):_summery(context),
                  _footer(context)
                ],
              ),
            )
        ),),
      ),
    );
  }
  _header(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height*0.2,
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
                  icon: Icon(Icons.arrow_back)
              ),
              Text(App_Localization.of(context).translate("checkout"),style: App.textBlod(Colors.black, 20),),
              IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.arrow_back,color: Colors.transparent,)
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 30,right: 30),
            child: Container(
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
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 25,right: 25),
            child: Container(
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
    return Container(
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
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(left: 30,right: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                App.checkoutTextField(checkoutController.firstName, "first_name", context, MediaQuery.of(context).size.width*0.4, 40,checkoutController.address_err.value),
                App.checkoutTextField(checkoutController.lastName, "last_name", context, MediaQuery.of(context).size.width*0.4, 40,checkoutController.address_err.value),
              ],
            ),
            SizedBox(height: 30,),
            App.checkoutTextField(checkoutController.address, "address", context, MediaQuery.of(context).size.width-60, 40,checkoutController.address_err.value),
            SizedBox(height: 30,),
            App.checkoutTextField(checkoutController.apartment, "apartment", context, MediaQuery.of(context).size.width-60, 40,checkoutController.address_err.value),
            SizedBox(height: 30,),
            App.checkoutTextField(checkoutController.city, "city", context, MediaQuery.of(context).size.width-60, 40,checkoutController.address_err.value),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  width: MediaQuery.of(context).size.width*0.35,
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(App_Localization.of(context).translate("country_region"),style: App.textNormal(Colors.grey, 12),),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: checkoutController.country.value=="non"?null:checkoutController.country.value,
                        items: checkoutController.countries.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(App_Localization.of(context).translate(value),style: App.textNormal(Colors.black, 12),),
                          );
                        }).toList(),
                        underline: Container(color: checkoutController.address_err.value&&checkoutController.country.value=="non"?Colors.red:Colors.grey,height: 1),
                        onChanged: (val) {
                          checkoutController.country.value=val!.toString();
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.35,
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(App_Localization.of(context).translate("emirate"),style: App.textNormal(Colors.grey, 12),),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: checkoutController.emirate.value=="non"?null:checkoutController.emirate.value,
                        items: checkoutController.emirates.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(App_Localization.of(context).translate(value),style: App.textNormal(Colors.black, 12),),
                          );
                        }).toList(),
                        underline: Container(color: checkoutController.address_err.value&&checkoutController.emirate.value=="non"?Colors.red:Colors.grey,height: 1,),
                        onChanged: (val) {
                          checkoutController.emirate.value=val.toString();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(App_Localization.of(context).translate("phone"),style: App.textNormal(Colors.grey, 12),),
                Container(
                  width: MediaQuery.of(context).size.width-60,
                  height: 60,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: checkoutController.phone,
                    maxLength: 9,
                    decoration: InputDecoration(
                        prefix: Text("+971"),
                        enabledBorder: checkoutController.address_err.value&&checkoutController.phone.value.text.isEmpty?UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)):UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: App.midOrange))
                    ),
                    style: App.textNormal(Colors.black, 14),
                  ),
                ),
              ],
            ),


            SizedBox(height: 40,)
          ],
        ),
      ),
    );
  }
  _payment(BuildContext context){
    return !checkoutController.selected.value?
          Container(
            height: MediaQuery.of(context).size.height*0.7-MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            child: Column(
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
                      checkoutController.my_order.addAll(cartController.my_order.value);
                      checkoutController.selected_operation.value++;
                      checkoutController.selected.value=true;
                      checkoutController.is_paid.value=false;
                      checkoutController.is_cod.value=true;
                    },
                    leading: CircleAvatar(
                      child: Icon(Icons.delivery_dining),
                    ),
                    title: Text(App_Localization.of(context).translate("cod")),
                    subtitle: Text(App_Localization.of(context).translate("cash")),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      App.box_shadow()
                    ]
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.credit_card),
                    ),
                    onTap: (){
                      checkoutController.selected.value=true;
                      checkoutController.is_cod.value=false;

                    },
                    title: Text(App_Localization.of(context).translate("payment")),
                    subtitle: Text(App_Localization.of(context).translate("c_card")),
                  ),
                )
              ],
            ),
          )
        :Container(
      height: MediaQuery.of(context).size.height*0.7-MediaQuery.of(context).padding.top,
      width: MediaQuery.of(context).size.width,
      child:Ready_UI(),
      // MyFatoorah(
      //   onResult:(response){
      //     if(response.status==PaymentStatus.Success){
      //       checkoutController.my_order.addAll(cartController.my_order);
      //       checkoutController.add_order_payment(context);
      //       checkoutController.selected_operation++;
      //       checkoutController.is_paid.value=true;
      //     }else{
      //       checkoutController.selected.value=false;
      //     }
      //   },
      //   errorChild: Center(
      //     child: Icon(
      //       Icons.error,
      //       color: Colors.redAccent,
      //       size: 50,
      //     ),
      //   ),
      //   succcessChild: Center(
      //     child: Icon(
      //       Icons.done_all,
      //       color: Colors.greenAccent,
      //       size: 50,
      //     ),
      //   ),
      //   request: MyfatoorahRequest.test(
      //     currencyIso: Country.UAE,
      //     successUrl:
      //     'https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png',
      //     errorUrl:
      //     'https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png',
      //     invoiceAmount: double.parse(cartController.total.value),
      //     language: Global.lang_code=="en"?ApiLanguage.English:ApiLanguage.Arabic,
      //     token: "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
      //   ),
      // ),
    );
  }
  _summery(BuildContext context){
    return Column(
      children: [
        GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: checkoutController.my_order.length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      Expanded(flex:3,
                          child:Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                              image: DecorationImage(
                                image: NetworkImage(checkoutController.my_order[index].product.value.image),
                                fit: BoxFit.cover
                              )
                            ),
                          )
                      ),
                      Expanded(flex:1,
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: Column(
                              children: [
                                Text(checkoutController.my_order[index].product.value.title,style: TextStyle(fontSize: 8,overflow: TextOverflow.ellipsis),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(App_Localization.of(context).translate("aed")+" "+checkoutController.my_order[index].price.value,style: TextStyle(fontSize: 10,overflow: TextOverflow.ellipsis,color: App.midOrange)),
                                    Text(App_Localization.of(context).translate("quantity")+": "+checkoutController.my_order[index].quantity.value.toString(),style: TextStyle(fontSize: 10,overflow: TextOverflow.ellipsis,color: Colors.black)),
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
      ],
    );
  }
}


