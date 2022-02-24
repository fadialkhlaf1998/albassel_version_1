import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/my_order_controller.dart';
import 'package:albassel_version_1/my_model/customer_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class CustomerOrderView extends StatelessWidget {
   List<CustomerOrder> my_list ;
   CustomerOrderView(this.my_list){
     myOrderController.my_order.value=this.my_list;
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
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/background.png"),fit: BoxFit.cover
            )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _header(context),
                Obx((){
                  return  myOrderController.loading.value?Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.7,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ):ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
                                color: Color(0xfffff4e6),
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
                                        Text(_date_covert(myOrderController.my_order[index].date.toString()),style: TextStyle(color: Colors.grey,fontSize: 10),),
                                        Row(
                                          children: [
                                            Text(myOrderController.my_order[index].deliver==1?App_Localization.of(context).translate("completed"):App_Localization.of(context).translate("process"),style: TextStyle(color: myOrderController.my_order[index].deliver==1?Colors.green:Colors.blue,fontSize: 10),),
                                            SizedBox(width: 5,),
                                            Icon(myOrderController.my_order[index].deliver==1?Icons.check_circle:Icons.history,size: 15,color: myOrderController.my_order[index].deliver==1?Colors.green:Colors.blue,)
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(App_Localization.of(context).translate("oreder_id")+": ",style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold),),
                                        Text(myOrderController.my_order[index].code.toString(),style: TextStyle(color: Colors.grey,fontSize: 13),),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Row(
                                          children: [
                                            Text(App_Localization.of(context).translate("sub_total")+": ",style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold),),
                                            Text(myOrderController.my_order[index].subTotal.toString(),style: TextStyle(color: Colors.grey,fontSize: 13),),
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            Text(App_Localization.of(context).translate("shipping")+": ",style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold),),
                                            Text(myOrderController.my_order[index].shipping.toString(),style: TextStyle(color: Colors.grey,fontSize: 13),),
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            Text(App_Localization.of(context).translate("total")+": ",style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold),),
                                            Text(myOrderController.my_order[index].total.toString(),style: TextStyle(color: Colors.grey,fontSize: 13),),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 1,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            myOrderController.open_order_item(myOrderController.my_order[index].id,myOrderController.my_order[index].code);
                                          },
                                          child: Container(
                                            width: 75,
                                            height: 27,
                                            decoration: BoxDecoration(
                                                color: App.midOrange,
                                                border: Border.all(color: App.midOrange),
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Center(
                                              child: Text(App_Localization.of(context).translate("view_order"),style: TextStyle(fontSize: 11,color: Colors.white),),
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
     final dateTime = DateTime.parse(dateTimeString);

     final format = DateFormat('yyyy-MMM-dd hh:mm');
     final clockString = format.format(dateTime);
     return clockString;
   }
   _header(BuildContext context){
     return Container(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height*0.3,
       decoration: BoxDecoration(
         color: App.midOrange,
         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight:Radius.circular(25)),

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
                 Get.back();
               }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,size: 25,))
             ],
           ),
           SizedBox(),
           SizedBox(),
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
