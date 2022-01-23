import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/my_model/customer_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerOrderView extends StatelessWidget {
   List<CustomerOrder> my_list ;
   CustomerOrderView(this.my_list);

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
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: my_list.length,
                  itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black ,width: 2)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(my_list[index].details,style: TextStyle(color: Colors.black,fontSize: 14,overflow: TextOverflow.clip),),
                              Text(App_Localization.of(context).translate("address")+": "+my_list[index].address,style: App.textNormal(Colors.black, 14),),
                              Text(App_Localization.of(context).translate("apartment")+": "+my_list[index].apartment,style: App.textNormal(Colors.black, 14),),
                              Text(App_Localization.of(context).translate("emirate")+": "+my_list[index].emirate,style: App.textNormal(Colors.black, 14),),
                              Text(App_Localization.of(context).translate("phone")+": "+my_list[index].phone,style: App.textNormal(Colors.black, 14),),

                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },),
              ],
            ),
          ),
        ),
      ),
    );
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
