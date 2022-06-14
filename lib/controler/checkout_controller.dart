import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/model/my_order.dart';
import 'package:albassel_version_1/my_model/address.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_fatoorah/my_fatoorah.dart';

class CheckoutController extends GetxController{
  var selected_operation = 0.obs;
  var address_err=false.obs;
  var my_order = <MyOrder>[].obs;
  var is_paid=false.obs;
  var selected=false.obs;
  var is_cod=false.obs;
  double total=0.0;
  List<LineItem> lineItems = <LineItem>[];
  CartController cartController = Get.find();


  @override
  void onInit() {
    firstName.text=Global.customer!.firstname;
    lastName.text=Global.customer!.lastname;
    if(Global.address!=null){
      address.text=Global.address!.address;
      apartment.text=Global.address!.apartment;
      city.text=Global.address!.city;
      phone.text=Global.address!.phone;
      emirate.value=Global.address!.Emirate;
      country.value=Global.address!.country;
    }

  }

  /**address controllers*/
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController apartment = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController phone = TextEditingController();
  Rx<String> country="non".obs;
  Rx<String> emirate="non".obs;
  List<String> countries=["united_arab_emirates"];
  List<String> emirates=["abu_dhabi","ajman","dubai","fujairah","ras_al_Khaimah","sharjah","umm_al_Quwain"];

  next(BuildContext context){

    if(selected_operation==0){

      if(firstName.value.text.isEmpty||lastName.value.text.isEmpty||address.value.text.isEmpty||
          apartment.value.text.isEmpty||city.value.text.isEmpty||phone.value.text.isEmpty||country=="non"||emirate=="non"){
        address_err.value=true;
        // selected_operation++;
      }else{
        selected_operation++;
        Address a = Address(address: address.text, apartment: apartment.text, city: city.text, country: country.value, Emirate: emirate.value, phone: phone.text);
        Store.save_address(a);
      }
    }else{
      if(selected.value&&!is_cod.value) {
        App.error_msg(
            context, App_Localization.of(context).translate("err_next_step"));
      }else if(selected.value){
        selected_operation++;
      }
    }
  }
  back(){
    selected.value=false;
    if(selected_operation==0){
      Get.back();
    }else if(selected.value){
      selected.value=false;
    }
    else if(selected_operation==1){
        address_err.value=false;
        selected_operation--;
    }
  }

  add_order_payment(BuildContext context){
    get_details();
    //todo add order to shpify
    add_order(firstName.text, lastName.text, address.text, apartment.text, city.text, country.value, emirate.value, "+971"+phone.text, get_details(), double.parse(cartController.sub_total.value)+double.parse(cartController.couponAutoDiscount.value), double.parse(cartController.shipping.value),double.parse(cartController.total.value), is_paid.value,lineItems,(double.parse(cartController.coupon.value)+double.parse(cartController.couponAutoDiscount.value)).toStringAsFixed(2));
    cartController.clear_cart();

    App.sucss_msg(context, App_Localization.of(context).translate("s_order"));
  }
  add_order_shopyfi(BuildContext context){
    get_details();
    if(is_paid.value){
      cartController.clear_cart();
      App.sucss_msg(context, App_Localization.of(context).translate("s_order"));
      Get.offAll(()=>Home());
    }else{
      //todo add order to shpify
      add_order(firstName.text, lastName.text, address.text, apartment.text, city.text, country.value, emirate.value, "+971"+phone.text, get_details(), double.parse(cartController.sub_total.value)+double.parse(cartController.couponAutoDiscount.value), double.parse(cartController.shipping.value),double.parse(cartController.total.value), is_paid.value,lineItems,(double.parse(cartController.coupon.value)+double.parse(cartController.couponAutoDiscount.value)).toStringAsFixed(2));
      cartController.clear_cart();
      App.sucss_msg(context, App_Localization.of(context).translate("s_order"));
      Get.offAll(()=>Home());
    }
  }

  add_order(String first,String last,String address,String apartment,String city,String country,String emirate,String phone,String details,double sub_total,double shipping, double total,bool is_paid,List<LineItem> lineItems,String discount){
    MyApi.add_order(first, last, address, apartment, city, country, emirate, phone, details, sub_total, shipping,  total, is_paid,lineItems,discount).then((succ) {
      if(!succ){
        add_order(first, last, address, apartment, city, country, emirate, phone, details, sub_total, shipping,  total, is_paid,lineItems,discount);
      }
    }).catchError((err){
      add_order(first, last, address, apartment, city, country, emirate, phone, details, sub_total, shipping,  total, is_paid,lineItems,discount);
    });
  }

  // String get_details(){
  //   String text="";
  //   lineItems = <LineItem>[];
  //   for(int i=0;i<my_order.length;i++){
  //     if(my_order[i].quantity.value>0){
  //       lineItems.add(LineItem(id: my_order[i].product.value.id, quantity: my_order[i].quantity.value));
  //       text+=my_order[i].product.value.title+" X "+my_order[i].quantity.value.toString()+"\n";
  //     }else{
  //       my_order.removeAt(i);
  //     }
  //
  //   }
  //   return text;
  // }

  String get_details(){
    String text="";
    lineItems.clear();
    for(int i=0;i<my_order.length;i++){
      if(my_order[i].quantity.value>0){
        lineItems.add(LineItem(id: my_order[i].product.value.id, quantity: my_order[i].quantity.value));
        text+=my_order[i].product.value.title+" X "+my_order[i].quantity.value.toString()+"\n";
      }else{
        my_order.removeAt(i);
      }
    }
    for(int i=0;i<cartController.auto_discount.length;i++){
      if(cartController.auto_discount[i].quantity.value>0&&cartController.auto_discount[i].product.value.availability>0){
        lineItems.add(LineItem(id: cartController.auto_discount[i].product.value.id, quantity: cartController.auto_discount[i].quantity.value));
        text+=cartController.auto_discount[i].product.value.title+" X "+cartController.auto_discount[i].quantity.value.toString()+"\n";
      }else{
        cartController.auto_discount.removeAt(i);
      }
    }
    return text;
  }

}