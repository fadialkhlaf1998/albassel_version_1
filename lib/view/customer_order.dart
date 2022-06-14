// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/my_order_controller.dart';
import 'package:albassel_version_1/my_model/customer_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class CustomerOrderView extends StatelessWidget {
   List<CustomerOrder> my_list ;
   CustomerOrderView(this.my_list, {Key? key}) : super(key: key){
     myOrderController.my_order.value=my_list;
   }

   MyOrderController myOrderController = Get.put(MyOrderController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(

        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/background.png"),fit: BoxFit.cover
            )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _header(context),
                Obx((){
                  return  myOrderController.loading.value?SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.7,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ):ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: my_list.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            // border: Border.all(color: App.midOrange ,width: 2)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0,right: 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 50,
                              height: 130,
                              decoration: BoxDecoration(
                                color: const Color(0xfffff4e6),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 10,
                                      spreadRadius: 0.1
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                                /*image: DecorationImage(
                                          colorFilter: ColorFilter.mode(AppColors.main2.withOpacity(0.8), BlendMode.overlay),
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/images/cardBackground.jpg'
                                          )
                                      )*/
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(_date_covert(myOrderController.my_order[index].date.toString()),style: const TextStyle(color: Colors.grey,fontSize: 10),),
                                        Row(
                                          children: [
                                            Text(myOrderController.my_order[index].deliver==1?App_Localization.of(context).translate("completed"):myOrderController.my_order[index].deliver==-1?App_Localization.of(context).translate("refused"):App_Localization.of(context).translate("process"),style: TextStyle(color: myOrderController.my_order[index].deliver==1?Colors.green:myOrderController.my_order[index].deliver==-1?Colors.red:Colors.blue,fontSize: 10),),
                                            const SizedBox(width: 5,),
                                            Icon(myOrderController.my_order[index].deliver==1?Icons.check_circle:myOrderController.my_order[index].deliver==-1?Icons.close:Icons.history,size: 15,color: myOrderController.my_order[index].deliver==1?Colors.green:myOrderController.my_order[index].deliver==-1?Colors.red:Colors.blue,)
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(App_Localization.of(context).translate("oreder_id")+": ",style: const TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold),),
                                        Text(myOrderController.my_order[index].code.toString(),style: const TextStyle(color: Colors.grey,fontSize: 13),),
                                      ],
                                    ),
                                    FittedBox(
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Row(

                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Row(
                                              children: [
                                                Text(App_Localization.of(context).translate("sub_total")+": ",style: const TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold),),
                                                Text(myOrderController.my_order[index].subTotal.toStringAsFixed(2)+" "+App_Localization.of(context).translate("aed"),style: const TextStyle(color: Colors.grey,fontSize: 13),),
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Text(App_Localization.of(context).translate("shipping")+": ",style: const TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold),),
                                                Text(myOrderController.my_order[index].shipping.toStringAsFixed(2)+" "+App_Localization.of(context).translate("aed"),style: const TextStyle(color: Colors.grey,fontSize: 13),),
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Text(App_Localization.of(context).translate("total")+": ",style: const TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold),),
                                                Text(myOrderController.my_order[index].total.toStringAsFixed(2)+" "+App_Localization.of(context).translate("aed"),style: const TextStyle(color: Colors.grey,fontSize: 13),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 1,),
                                    DateTime.parse(myOrderController.my_order[index].current.toString()).isBefore(DateTime.parse(myOrderController.my_order[index].date.toString()))
                                        &&myOrderController.my_order[index].isPaid!=1&&myOrderController.my_order[index].deliver==0?
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            myOrderController.open_order_item(myOrderController.my_order[index].id,myOrderController.my_order[index].code);
                                          },
                                          child: Container(
                                            width: 90,
                                            height: 27,
                                            decoration: BoxDecoration(
                                                color: App.midOrange,
                                                border: Border.all(color: App.midOrange),
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Center(
                                              child: Text(App_Localization.of(context).translate("view_order"),style: const TextStyle(fontSize: 11,color: Colors.white),),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            myOrderController.cancel_order(index);
                                          },
                                          child: Container(
                                            width: 90,
                                            height: 27,
                                            decoration: BoxDecoration(
                                                color: App.midOrange,
                                                border: Border.all(color: App.midOrange),
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Center(
                                              child: Text(App_Localization.of(context).translate("cancel_order"),style: const TextStyle(fontSize: 11,color: Colors.white),),
                                            ),
                                          ),
                                        )
                                      ],
                                    ): Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            myOrderController.open_order_item(myOrderController.my_order[index].id,myOrderController.my_order[index].code);
                                          },
                                          child: Container(
                                            width: 90,
                                            height: 27,
                                            decoration: BoxDecoration(
                                                color: App.midOrange,
                                                border: Border.all(color: App.midOrange),
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Center(
                                              child: Text(App_Localization.of(context).translate("view_order"),style: const TextStyle(fontSize: 11,color: Colors.white),),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },);
                })

              ],
            ),
          ),
        ),
      ),
    );
  }


   _date_covert(String dateTimeString){
     final dateTime = DateTime.parse(dateTimeString).add(const Duration(hours: 4));

     final format = DateFormat('yyyy-MMM-dd hh:mm');
     final clockString = format.format(dateTime);
     return clockString.replaceAll(" ", ",");
   }
   _header(BuildContext context){
     return Container(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height*0.3,
       decoration: BoxDecoration(
         color: App.midOrange,
         borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight:Radius.circular(25)),

         boxShadow: [
           App.box_shadow()
         ],
       ),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           Row(
             children: [
               Padding(
                 padding: const EdgeInsets.only(top: 15),
                 child: IconButton(onPressed: (){
                   Get.back();
                 }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 25,)),
               )
             ],
           ),
           const SizedBox(),
           const SizedBox(),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(App_Localization.of(context).translate("my_order"),style: App.textBlod(Colors.white, 40),)
             ],
           )
         ],
       ),
     );
   }
}
