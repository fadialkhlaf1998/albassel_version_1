

import 'package:albassel_version_1/my_model/customer_order.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/view/order_item.dart';
import 'package:get/get.dart';

class MyOrderController extends GetxController{

  var my_order = <CustomerOrder>[].obs;
  var loading = false.obs;

  open_order_item(int order_id,String code){
    loading.value=true;
    MyApi.getOrderItems(order_id).then((value) {
      loading.value=false;
      Get.to(()=>OrderItems(value,code));
    });
  }



}