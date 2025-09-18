import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:albassel_version_1/helper/api_v2.dart';
import 'package:albassel_version_1/model_v2/product.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/my_model/sub_category.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../view/product.dart';

class ProductsController extends GetxController{
  List<SubCategory> sub_categories=<SubCategory>[].obs;
  List<Product> my_products=<Product>[].obs;
  var loading = false.obs;
  Rx<int> selected_sub_category = 0.obs;
WishListController wishListController = Get.find();
CartController cartController = Get.find();
  var productCountShow = 10.obs;

  showMore(){
    if(productCountShow.value+10<=my_products.length){
      productCountShow.value += 10;
    }else{
      productCountShow.value = my_products.length;
    }
  }

  setProductShow(){
    if(my_products.length > 10){
      productCountShow.value = 10;
    }else{
      productCountShow.value = my_products.length;
    }
  }

  update_product(int index){

    loading.value=true;
    selected_sub_category.value=index;
    ApiV2.getProductsBySubCategory(sub_categories[index].id).then((value) {
      my_products.clear();
      my_products.addAll(value);
      loading.value=false;
      if(my_products.length>10){
        productCountShow.value = 10;
      }else{
        productCountShow.value = my_products.length;
      }
    }).catchError((err){
      loading.value=false;
    });
  }


  get_products_by_search(String query,BuildContext context){
    loading.value=true;
    ApiV2.search(query).then((value) {

      if(value.isNotEmpty){
        this.my_products.clear();
        this.my_products.addAll(value);
      }else{
        App.error_msg(context, App_Localization.of(context).translate("fail_search"));
      }
      setProductShow();
      loading.value=false;

    }).catchError((err){
      loading.value=false;
    });
  }

  go_to_product(int index){
    Get.to(()=>ProductView(my_products[index].id));
  }
}