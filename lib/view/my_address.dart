import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/my_address_controller.dart';
import 'package:albassel_version_1/model_v2/address.dart';
import 'package:albassel_version_1/view/add_edit_address.dart';
import 'package:albassel_version_1/wedgits/internal_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAddress extends StatelessWidget {

  MyAddressController myAddressController = Get.put(MyAddressController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App.midOrange,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(()=> AddEditAddress(null));
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              InternalHeader(),
              Obx(()=>Expanded(
                child: Container(
                  padding: EdgeInsets.all(14),
                  color: Colors.white,
                  child:
                  myAddressController.loading.value?
                  Center(
                    child: CircularProgressIndicator(),
                  ) :RefreshIndicator(
                    onRefresh: () => myAddressController.getData(),
                    child:
                    myAddressController.address.isEmpty
                        ?Container(height: 200,child: Center(child: Text(App_Localization.of(context).translate("there_is_no_address_plz_add_address")))):
                    ListView.builder(
                      itemCount: myAddressController.address.length,
                      itemBuilder: (context,index){
                        Address address = myAddressController.address[index];
                        return Card(
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
                                    Icon(Icons.location_on,color: App.midOrange ,),
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
                                        Get.to(()=> AddEditAddress(address));
                                      },
                                    ),
                                    SizedBox(width: 15,),
                                    Container(width: 1,height: 15,color: Colors.grey,),
                                    SizedBox(width: 15,),
                                    GestureDetector(
                                      child: Row(
                                        children: [
                                          const Icon(Icons.delete_outline, color: Colors.grey,size: 20,),
                                          SizedBox(width: 5,),
                                          Text(App_Localization.of(context).translate("delete")),
                                        ],
                                      ),
                                      onTap: () {
                                        myAddressController.deleteAddress(address.id);
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
                        );
                      },
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
