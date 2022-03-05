import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/model/my_order.dart';
import 'package:albassel_version_1/model/order.dart';
import 'package:albassel_version_1/model/product.dart';
import 'package:albassel_version_1/my_model/my_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  // Rx<Order> order=Order(lineItems: <OrderLineItem>[]).obs;
  Rx<String> total="0.00".obs,sub_total="0.00".obs,shipping="10.00".obs;
  var my_order = <MyOrder>[].obs;
  var rate = <MyOrder>[].obs;

  //todo save when do any thing

  bool add_to_cart(MyProduct product , int count,BuildContext context){
    if(product.availability>0){
      for(int i=0;i<my_order.length;i++){
        if(my_order[i].product.value.id==product.id){
          if(my_order[i].quantity.value+count<=product.availability){
            App.sucss_msg(context, App_Localization.of(context).translate("cart_msg"));
            my_order[i].quantity.value = my_order[i].quantity.value + count;
            double x = (my_order[i].quantity.value * double.parse(product.price.toString())) as double;
            my_order[i].price.value = x.toString();
            get_total();
            return true;
          }else{
            return false;
          }
        }
      }
      App.sucss_msg(context, App_Localization.of(context).translate("cart_msg"));
      double x = (count * double.parse(product.price.toString())) as double;
      MyOrder myOrder = MyOrder(product:product.obs,quantity:count.obs,price:x.toString().obs);
      my_order.add(myOrder);
      get_total();
      return true;
    }else{
      App.error_msg(context, App_Localization.of(context).translate("out_of_stock"));
      return false;
    }
  }

  add_to_rate(MyProduct product , int count){
      for(int i=0;i<rate.length;i++){
        if(rate[i].product.value.id==product.id){
          rate[i].quantity.value = rate[i].quantity.value + count;
          // double x = (my_order[i].quantity.value * double.parse(product.price.toString())) as double;
          rate[i].price.value = "0.0";
          get_total();
          return ;
        }
      }
      // double x = (count * double.parse(product.price.toString())) as double;
      MyOrder myOrder = MyOrder(product:product.obs,quantity:count.obs,price:"0.0".obs);
      rate.add(myOrder);
  }

  clear_cart(){
    my_order.clear();
    get_total();
  }

  increase(MyOrder myOrder,index){
    if(myOrder.product.value.availability>my_order[index].quantity.value){
      my_order[index].quantity.value++;
      double x =  (my_order[index].quantity.value * double.parse(my_order[index].product.value.price.toString())) as double;
      my_order[index].price.value=x.toString();
      get_total();
    }

  }

  decrease(MyOrder myOrder,index){
    if(my_order[index].quantity.value>1){
      my_order[index].quantity.value--;
      double x =  (my_order[index].quantity.value *double.parse(my_order[index].product.value.price.toString())) as double;
      my_order[index].price.value=x.toString();
      get_total();
    }else{
      remove_from_cart(myOrder);
    }

  }
  remove_from_cart(MyOrder myOrder){
    my_order.removeAt(my_order.indexOf(myOrder));
    get_total();
  }

  get_total(){
    double x=0,y=0;
      for (var elm in my_order) {
        x += double.parse(elm.price.value);
        // y += double.parse(elm.shipping.value);
      }
      sub_total.value=x.toString();
      if(x>250){
        shipping.value="0.00";
      }else{
        shipping.value="10.00";
      }
      // shipping.value = y.toString();
      total.value = (x + y).toString();
      Store.save_order(my_order.value);
  }
}