import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/address_cotroller.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/my_model/address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddressView extends StatelessWidget {
  final AdressController _adressController = Get.put(AdressController());

  AddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx((){
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                _header(context),
                const SizedBox(height: 20,),
                _address(context),
                GestureDetector(
                    onTap: (){
                      Address a = Address(address: _adressController.address.text, apartment: _adressController.apartment.text, city: _adressController.city.text, country: _adressController.country.value, Emirate: _adressController.emirate.value, phone: _adressController.phone.text);
                      Store.save_address(a);
                      App.sucss_msg(context, App_Localization.of(context).translate("adress_save"));
                      Get.back();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      height: 40,
                      decoration: BoxDecoration(
                          color: App.midOrange,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Text(App_Localization.of(context).translate("submit"),style: App.textNormal(Colors.white, 14),),
                      ),
                    )
                ),
                const SizedBox(height: 20,),
              ],
            ),
          );
        }),
      ),
    );
  }

  _address(BuildContext context){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30),
        child: Column(
          children: [
            App.checkoutTextField(_adressController.address, "address", context, MediaQuery.of(context).size.width-60, 40,_adressController.address_err.value),
            const SizedBox(height: 30,),
            App.checkoutTextField(_adressController.apartment, "apartment", context, MediaQuery.of(context).size.width-60, 40,_adressController.address_err.value),
            const SizedBox(height: 30,),
            App.checkoutTextField(_adressController.city, "city", context, MediaQuery.of(context).size.width-60, 40,_adressController.address_err.value),
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
                      DropdownButton<String>(
                        isExpanded: true,
                        value: _adressController.country.value=="non"?null:_adressController.country.value,
                        items: _adressController.countries.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(App_Localization.of(context).translate(value),style: App.textNormal(Colors.black, 12),),
                          );
                        }).toList(),
                        underline: Container(color: _adressController.address_err.value&&_adressController.country.value=="non"?Colors.red:Colors.grey,height: 1),
                        onChanged: (val) {
                          _adressController.country.value=val!.toString();
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
                      Text(App_Localization.of(context).translate("emirate"),style: App.textNormal(Colors.grey, 12),),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: _adressController.emirate.value=="non"?null:_adressController.emirate.value,
                        items: _adressController.emirates.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(App_Localization.of(context).translate(value),style: App.textNormal(Colors.black, 12),),
                          );
                        }).toList(),
                        underline: Container(color: _adressController.address_err.value&&_adressController.emirate.value=="non"?Colors.red:Colors.grey,height: 1,),
                        onChanged: (val) {
                          _adressController.emirate.value=val.toString();
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
                    controller: _adressController.phone,
                    keyboardType: TextInputType.number,
                    maxLength: 9,

                    decoration: InputDecoration(
                        prefix: const Text("+971"),
                        enabledBorder: _adressController.address_err.value&&_adressController.phone.value.text.isEmpty?const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)):const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: App.midOrange))
                    ),
                    style: App.textNormal(Colors.black, 14),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40,)
          ],
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
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),

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
              }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 25,))
            ],
          ),
          const SizedBox(),
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(App_Localization.of(context).translate("address"),style: App.textBlod(Colors.white, 40),)
            ],
          )
        ],
      ),
    );
  }
}
