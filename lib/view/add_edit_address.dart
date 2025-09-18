import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/add_edit_address_controller.dart';
import 'package:albassel_version_1/model_v2/country.dart';
import 'package:albassel_version_1/wedgits/internal_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:albassel_version_1/model_v2/address.dart';

class AddEditAddress extends StatelessWidget {
  AddEditAddressController addEditAddressController = Get.put(AddEditAddressController());
  AddEditAddress(Address? address){
    addEditAddressController.initControllers(address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App.midOrange,

      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              InternalHeader(),
              Obx(()=>Expanded(
                child:
                addEditAddressController.loading.value?Container(color: Colors.white,child: Center(child: CircularProgressIndicator(),)):
                Container(
                    color: Colors.white,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            addEditAddressController.fake.value?Center():Center(),
                            const SizedBox(height: 30,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    addEditAddressController.nickNameStatus(0);
                                  },
                                  child: Container(
                                    width: 90,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: addEditAddressController.nickNameStatus.value==0?App.midOrange:Colors.grey)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.home_outlined,size: 27,color: addEditAddressController.nickNameStatus.value==0?App.midOrange:Colors.grey,),
                                        Text(App_Localization.of(context).translate("home0"))
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                GestureDetector(
                                  onTap: (){
                                    addEditAddressController.nickNameStatus(1);
                                  },
                                  child: Container(
                                    width: 90,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: addEditAddressController.nickNameStatus.value==1?App.midOrange:Colors.grey)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.work_outline_sharp,size: 27,color: addEditAddressController.nickNameStatus.value==1?App.midOrange:Colors.grey,),
                                        Text(App_Localization.of(context).translate("work"))
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20,),

                                GestureDetector(
                                  onTap: (){
                                    addEditAddressController.nickNameStatus(2);
                                  },
                                  child: Container(
                                    width: 90,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: addEditAddressController.nickNameStatus.value==2?App.midOrange:Colors.grey)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.location_on_outlined,size: 27,color: addEditAddressController.nickNameStatus.value==2?App.midOrange:Colors.grey,),
                                        Text(App_Localization.of(context).translate("other"))
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            addEditAddressController.nickNameStatus.value == 2?
                            Column(
                              children: [
                                const SizedBox(height: 30,),
                                App.checkoutTextField(addEditAddressController.nickName, "nickname", context, MediaQuery.of(context).size.width-60, 40,addEditAddressController.nickNameStatus.value == 2&&addEditAddressController.nickName.text.isEmpty&&addEditAddressController.validation.value?true:false),
                              ],
                            ):Center(),
                            const SizedBox(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: Get.width*0.35,
                                  child: App.checkoutTextField(addEditAddressController.first_name, "first_name", context, MediaQuery.of(context).size.width-60, 40,addEditAddressController.first_name.text.isEmpty&&addEditAddressController.validation.value?true:false),
                                ),
                                Container(
                                  width: Get.width*0.35,
                                  child: App.checkoutTextField(addEditAddressController.last_name, "last_name", context, MediaQuery.of(context).size.width-60, 40,addEditAddressController.last_name.text.isEmpty&&addEditAddressController.validation.value?true:false),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30,),
                            App.checkoutTextField(addEditAddressController.addressText, "address", context, MediaQuery.of(context).size.width-60, 40,addEditAddressController.addressText.text.isEmpty&&addEditAddressController.validation.value?true:false),
                            const SizedBox(height: 30,),
                            App.checkoutTextField(addEditAddressController.apartment, "apartment", context, MediaQuery.of(context).size.width-60, 40,addEditAddressController.apartment.text.isEmpty&&addEditAddressController.validation.value?true:false),
                            const SizedBox(height: 30,),
                            App.checkoutTextField(addEditAddressController.city, "city", context, MediaQuery.of(context).size.width-60, 40,addEditAddressController.city.text.isEmpty&&addEditAddressController.validation.value?true:false),
                            const SizedBox(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width*0.35,
                                  height: 80,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(App_Localization.of(context).translate("country_region"),style: App.textNormal(Colors.grey, 12),),
                                      DropdownButton<Country?>(
                                        isExpanded: true,
                                        value: addEditAddressController.selectedCountry,
                                        items: addEditAddressController.countries.map((Country value) {
                                          return DropdownMenuItem<Country>(
                                            value: value,
                                            child: Text(value.name,style: App.textNormal(Colors.black, 12),),
                                          );
                                        }).toList(),
                                        underline: Container(color: addEditAddressController.addressText.text.isEmpty&&addEditAddressController.validation.value?Colors.red:Colors.grey,height: 1),
                                        onChanged: (val) {
                                          addEditAddressController.selectedCountry = val;
                                          addEditAddressController.refreshPage();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width*0.35,
                                  height: 80,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(App_Localization.of(context).translate("shipping"),style: App.textNormal(Colors.grey, 12),),
                                      DropdownButton<Shipping?>(
                                        isExpanded: true,
                                        value: addEditAddressController.selectedShipping,
                                        hint: Text(" "),
                                        items: addEditAddressController.selectedCountry?.shipping.map((Shipping value) {
                                          return DropdownMenuItem<Shipping>(
                                            value: value,
                                            child: Text(value.emirate + " "+App_Localization.of(context).translate("shipping")
                                                +" "+ value.amount.toStringAsFixed(2)+"AED",style: App.textNormal(Colors.black, 12),),
                                          );
                                        }).toList(),
                                        underline: Container(color: addEditAddressController.addressText.text.isEmpty&&addEditAddressController.validation.value?Colors.red:Colors.grey,height: 1,),
                                        onChanged: (val) {
                                          addEditAddressController.selectedShipping = val;
                                          addEditAddressController.refreshPage();
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
                                SizedBox(
                                  width: MediaQuery.of(context).size.width-60,
                                  height: 60,
                                  child: TextField(
                                    controller: addEditAddressController.phone,
                                    keyboardType: TextInputType.number,
                                    maxLength: 9,

                                    decoration: InputDecoration(
                                        prefix: Text( addEditAddressController.selectedCountry==null?"+971":addEditAddressController.selectedCountry!.isoCode),
                                        enabledBorder: addEditAddressController.addressText.text.isEmpty&&addEditAddressController.validation.value?const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)):const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: App.midOrange))
                                    ),
                                    style: App.textNormal(Colors.black, 14),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 40,),
                            GestureDetector(
                              onTap: (){
                                addEditAddressController.save(context);
                              },
                              child: Container(
                                height: 50,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: App.midOrange
                                ),
                                child: Center(
                                  child: Text(App_Localization.of(context).translate("submit"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40,),
                          ],
                        ),
                      ),
                    ),
                  )
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  
}
