import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/my_address_controller.dart';
import 'package:albassel_version_1/helper/api_v2.dart';
import 'package:albassel_version_1/model_v2/address.dart';
import 'package:albassel_version_1/model_v2/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddEditAddressController extends GetxController{

  RxBool loading = false.obs;
  RxBool fake = false.obs;
  RxInt nickNameStatus = 0.obs;

  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController addressText = TextEditingController();
  TextEditingController nickName = TextEditingController();
  TextEditingController apartment = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController phone = TextEditingController();
  List<Country> countries = [];
  Country? selectedCountry;
  Shipping? selectedShipping;

  RxBool validation = false.obs;

  Address? address;


  initControllers(Address? address)async{
    this.address = address;
    loading(true);
    countries = await ApiV2.getCountries();
    validation(false);
    if(address == null){
      nickNameStatus(0);
      addressText.clear();
      nickName.clear();
      first_name.clear();
      last_name.clear();
      apartment.clear();
      city.clear();
      phone.clear();
      selectedCountry = null;
      selectedShipping = null;
    }else{
      nickNameStatus(address.nick_name_status);
      addressText.text = address.address;
      first_name.text = address.first_name;
      last_name.text = address.last_name;
      nickName.text = address.nickName;
      apartment.text = address.apartment;
      city.text = address.city;
      phone.text = address.phone;
      for(int i=0 ; i < countries.length ; i++){
        if(countries[i].id == address.countryId){
          selectedCountry = countries[i];
          for(int j = 0 ; j < countries[i].shipping.length;j++){
            if(countries[i].shipping[j].id == address.shippingId){
              selectedShipping = countries[i].shipping[j];
            }
          }
        }
      }
    }
    loading(false);
  }

  String getNickName(BuildContext context){
    if(nickNameStatus.value == 0){
      return App_Localization.of(context).translate("home0");
    }else if(nickNameStatus.value == 1){
      return App_Localization.of(context).translate("work");
    }else{
      return nickName.text;
    }
  }


  save(BuildContext context)async{

    validation(true);
    if(selectedCountry != null && selectedShipping != null && getNickName(context).isNotEmpty
    && addressText.text.isNotEmpty && apartment.text.isNotEmpty && city.text.isNotEmpty
    && phone.text.isNotEmpty && first_name.text.isNotEmpty && last_name.text.isNotEmpty){
      loading(true);
      if(address == null){
        bool succ = await ApiV2.addAddress(selectedCountry!.id,
            selectedShipping!.id, getNickName(context), addressText.text,
            apartment.text, city.text, phone.text, first_name.text, last_name.text,nickNameStatus.value);
        if(succ){
          MyAddressController myAddressController = Get.find();
          myAddressController.getData();
          Get.back();
        }else{
          App.error_msg(context, App_Localization.of(context).translate("wrong"));
        }
      }else{
        bool succ = await ApiV2.editAddress(selectedCountry!.id,
            selectedShipping!.id, getNickName(context), addressText.text,
            apartment.text, city.text, phone.text, first_name.text, last_name.text,nickNameStatus.value,address!.id);

        if(succ){
          MyAddressController myAddressController = Get.find();
          myAddressController.getData();
          Get.back();
        }else{
          App.error_msg(context, App_Localization.of(context).translate("wrong"));
        }
      }
      loading(false);
    }else{
      App.error_msg(context, App_Localization.of(context).translate("kindly_fill_fields"));
    }

    refreshPage();
  }

  refreshPage(){
    fake(!fake.value);
  }
}