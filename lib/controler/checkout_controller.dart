
import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/helper/cashew_api.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/model/my_order.dart';
import 'package:albassel_version_1/my_model/address.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/view/home.dart';
import 'package:albassel_version_1/view/web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class CheckoutController extends GetxController{
  var selected_operation = 0.obs;
  var address_err=false.obs;
  var my_order = <MyOrder>[].obs;
  var is_paid=false.obs;
  var selected=false.obs;
  var is_cod=false.obs;
  var cashewLoading=false.obs;
  double total=0.0;
  List<LineItem> lineItems = <LineItem>[];
  CartController cartController = Get.find();
  String orderTabbyId = "";


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


  getShippingAmount(String emirate){
    for(int i=0 ; i < Global.new_shipping.length; i++){
      if(emirate == Global.new_shipping[i].emirate){
        return Global.new_shipping[i].amount;
      }
    }
    return Global.new_shipping.first.amount;
  }

  getMinValueForFree(String emirate){
    for(int i=0 ; i < Global.new_shipping.length; i++){
      if(emirate == Global.new_shipping[i].emirate){
        return Global.new_shipping[i].minAmountFree;
      }
    }
    return Global.new_shipping.first.minAmountFree;
  }

  next(BuildContext context){
    print('******hhhh*******');
    print(getMinValueForFree(emirate.value.toString()));
    print(getShippingAmount(emirate.value.toString()));
    cartController.get_total(min_amount_for_free: getMinValueForFree(emirate.value.toString()),
        shipping_amount: getShippingAmount(emirate.value.toString()));
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
  lunch_session()async{
    var now = new DateTime.now();
    var dateFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);
    orderTabbyId = DateTime.now().millisecondsSinceEpoch.toString();
    print(DateTime.now().toIso8601String());
    final mockPayload = Payment(
      amount: cartController.total.value,
      currency: Currency.aed,
      buyer: Buyer(
        email: Global.customer!.email,
        phone: phone.text,
        name: firstName.text+" "+lastName.text,
      ),
      buyerHistory: BuyerHistory(
        loyaltyLevel: 0,
        registeredSince: dateFormatted+"+04:00",
        wishlistCount: 0,
      ),
      shippingAddress: ShippingAddress(
        city: city.text,
        address: country.value+"/"+emirate.value+"/"+address.text+"/"+apartment.text,
        zip: '',
      ),
      order: Order(referenceId: orderTabbyId, items:
      cartController.my_order.map((element) => OrderItem(
        title: element.product.value.title,
        description: element.product.value.description,
        quantity: element.quantity.value,
        unitPrice: element.product.value.price.toStringAsFixed(2) ,
        referenceId: element.product.value.sku,
        productUrl: '',
        category: element.product.value.category,
        brand: element.product.value.brand,
          imageUrl:  element.product.value.image
      )).toList()
      ),
      orderHistory: [

      ],
    );
    final session = await TabbySDK().createSession(TabbyCheckoutPayload(
      merchantCode: 'ABPP',
      lang: Global.lang_code=="en"?Lang.en:Lang.ar,
      payment: mockPayload,
    ));
  }

  lunch_order_tabby(BuildContext context)async{
    cashewLoading(true);
    try{
      var now = new DateTime.now();
      var dateFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);
      print(DateTime.now().toIso8601String());
      final mockPayload = Payment(
        amount: cartController.total.value,
        currency: Currency.aed,
        buyer: Buyer(

          // email: "card.success@tabby.ai",
          email: Global.customer!.email,
          // phone: "500000001",
          phone: phone.text,
          name: firstName.text+" "+lastName.text,
        ),
        buyerHistory: BuyerHistory(
          loyaltyLevel: 0,
          registeredSince: dateFormatted+"+04:00",
          wishlistCount: 0,
        ),
        shippingAddress: ShippingAddress(
          city: city.text,
          address: country.value+"/"+emirate.value+"/"+address.text+"/"+apartment.text,
          zip: '',
        ),
        order: Order(referenceId: orderTabbyId, items:
        cartController.my_order.map((element) => OrderItem(
          title: element.product.value.title,
          description: element.product.value.description,
          quantity: element.quantity.value,
          unitPrice: element.product.value.price.toStringAsFixed(2) ,
          referenceId: element.product.value.sku,
          productUrl: '',
          category: element.product.value.category,
          brand: element.product.value.brand,
          imageUrl:  element.product.value.image
        )).toList()
        ),
        orderHistory: [

        ],
      );
      final session = await TabbySDK().createSession(TabbyCheckoutPayload(
        merchantCode: 'ABPP',
        lang: Global.lang_code=="en"?Lang.en:Lang.ar,
        payment: mockPayload,
      ));
      TabbyWebView.showWebView(
        context: context,
        webUrl: session.availableProducts.installments!.webUrl,
        onResult: (WebViewResult resultCode) {
          print('*************** RESULT ***************');
          print(resultCode.name);
          cashewLoading(false);
          if(resultCode.name == "authorized"){
            add_order_tabby(context,orderTabbyId);
          }else if(resultCode.name == "close"){
            Get.back();
            // App.error_msg(context, App_Localization.of(context).translate("wrong"));
          }
        },
      );
    }catch(e){
      cashewLoading(false);
      App.error_msg(context, App_Localization.of(context).translate("wrong"));
      print(e);
      print('***************');
      e.printError();
    }
  }
  add_order_installment_payment(BuildContext context)async{
    cashewLoading(true);
    String token = await getCashewToken();
    CashewResponse? cashewResponse = await Cashew.checkout(
        token: token,
        mobileNumber: "+971"+phone.text,
        email: Global.customer!.email,
        firstName: firstName.text,
        lastName: lastName.text,
        address1:address.text,
        address2: apartment.text,
        city: city.text,
        state: emirate.value,
        country: country.value,
        cart: cartController.my_order,
        shipping: double.parse(cartController.shipping.value)
    );
    cashewLoading(false);
    if(cashewResponse == null){
      App.error_msg(
          context, App_Localization.of(context).translate("wrong"));
    }else{
      print('***************\n');
      print(cashewResponse.paymentUrl);
      add_order_cashew(context);
      launchUrl(Uri.parse(cashewResponse.paymentUrl),mode: LaunchMode.externalApplication);
    }

  }

  Future<String> getCashewToken()async{
    String? token = await Cashew.getToken();
    if(token == null){
      return await getCashewToken();
    }else{
      return token;
    }
  }

  add_order_payment(BuildContext context){
    get_details();
    //todo add order to shpify
    add_order(firstName.text, lastName.text, address.text, apartment.text, city.text, country.value, emirate.value, "+971"+phone.text, get_details(), double.parse(cartController.sub_total.value)+double.parse(cartController.couponAutoDiscount.value), double.parse(cartController.shipping.value),double.parse(cartController.total.value), is_paid.value ?1:0,lineItems,(double.parse(cartController.coupon.value)+double.parse(cartController.couponAutoDiscount.value)).toStringAsFixed(2),"");
    // cartController.clear_cart();

    App.sucss_msg(context, App_Localization.of(context).translate("s_order"));
  }
  add_order_shopyfi(BuildContext context){
    get_details();
    if(is_paid.value){
      // cartController.clear_cart();
      App.sucss_msg(context, App_Localization.of(context).translate("s_order"));
      Get.offAll(()=>Home());
    }else{
      add_order(firstName.text, lastName.text, address.text, apartment.text, city.text, country.value, emirate.value, "+971"+phone.text, get_details(), double.parse(cartController.sub_total.value)+double.parse(cartController.couponAutoDiscount.value), double.parse(cartController.shipping.value),double.parse(cartController.total.value), is_paid.value ?1:0,lineItems,(double.parse(cartController.coupon.value)+double.parse(cartController.couponAutoDiscount.value)).toStringAsFixed(2),"");
      // cartController.clear_cart();
      App.sucss_msg(context, App_Localization.of(context).translate("s_order"));
      Get.offAll(()=>Home());
    }
  }
  add_order_tabby(BuildContext context,String reference){
    my_order.addAll(cartController.my_order.value);
    get_details();
    add_order(firstName.text, lastName.text, address.text, apartment.text, city.text, country.value, emirate.value, "+971"+phone.text, get_details(), double.parse(cartController.sub_total.value)+double.parse(cartController.couponAutoDiscount.value), double.parse(cartController.shipping.value),double.parse(cartController.total.value), -3,lineItems,(double.parse(cartController.coupon.value)+double.parse(cartController.couponAutoDiscount.value)).toStringAsFixed(2),reference);
    // cartController.clear_cart();
    App.sucss_msg(context, App_Localization.of(context).translate("s_order"));
    Get.offAll(()=>Home());
  }
  add_order_cashew(BuildContext context){
    my_order.addAll(cartController.my_order.value);
    get_details();
    add_order(firstName.text, lastName.text, address.text, apartment.text, city.text, country.value, emirate.value, "+971"+phone.text, get_details(), double.parse(cartController.sub_total.value)+double.parse(cartController.couponAutoDiscount.value), double.parse(cartController.shipping.value),double.parse(cartController.total.value), -1,lineItems,(double.parse(cartController.coupon.value)+double.parse(cartController.couponAutoDiscount.value)).toStringAsFixed(2),"");
    // cartController.clear_cart();
    // App.sucss_msg(context, App_Localization.of(context).translate("s_order"));
    Get.offAll(()=>Home());
  }

  //todo remove coment
  add_order(String first,String last,String address,String apartment,String city,String country,String emirate,String phone,String details,double sub_total,double shipping, double total,int is_paid,List<LineItem> lineItems,String discount,String reference){
    MyApi.add_order(first, last, address, apartment, city, country, emirate, phone, details, sub_total, shipping,  total, is_paid,lineItems,discount,reference).then((succ) {
      if(!succ){
        add_order(first, last, address, apartment, city, country, emirate, phone, details, sub_total, shipping,  total, is_paid,lineItems,discount,reference);
      }else{
        cartController.clear_cart();
      }
    }).catchError((err){
      add_order(first, last, address, apartment, city, country, emirate, phone, details, sub_total, shipping,  total, is_paid,lineItems,discount,reference);
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
    my_order.clear();
    my_order.addAll(cartController.my_order.value);
    lineItems.clear();
    print('clear'+my_order.length.toString());
    for(int i=0;i<my_order.length;i++){
      print(my_order[i].quantity.value);

      if(my_order[i].quantity.value>0){
        print('adding');
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