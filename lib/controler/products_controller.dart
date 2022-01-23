import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:albassel_version_1/model/product.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/my_model/my_product.dart';
import 'package:albassel_version_1/my_model/sub_category.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../view/product.dart';

class ProductsController extends GetxController{
  List<SubCategory> sub_categories=<SubCategory>[].obs;
  List<MyProduct> my_products=<MyProduct>[].obs;
  var loading = false.obs;
  Rx<int> selected_sub_category = 0.obs;
WishListController wishListController = Get.find();
CartController cartController = Get.find();
  update_product(int index){
    loading.value=true;
    MyApi.check_internet().then((internet) {
      if (internet) {
        selected_sub_category.value=index;
        MyApi.getProducts(wishListController.wishlist,sub_categories[index].id).then((value) {
          my_products.clear();
          my_products.addAll(value);
          loading.value=false;
        }).catchError((err){
          loading.value=false;
        });
      }else{
        Get.to(()=>NoInternet())!.then((value) {
          update_product(index);
        });
      }
      });
  }


  get_products_by_search(String query,BuildContext context){
    MyApi.check_internet().then((internet) {
      if (internet) {
        loading.value=true;
        MyApi.getProductsSearch(wishListController.wishlist,query).then((value) {
          loading.value=false;
          if(value.isNotEmpty){
            this.my_products.clear();
            this.my_products.addAll(value);
          }else{
            App.error_msg(context, App_Localization.of(context).translate("fail_search"));
          }

        }).catchError((err){
          loading.value=false;
        });
      }else{
        Get.to(NoInternet())!.then((value) {
          get_products_by_search(query,context);
        });
      }
    });
  }

  go_to_product(int index){
    loading.value=true;
    MyApi.check_internet().then((internet) {
      if (internet) {
        MyApi.getProductsInfo(my_products[index].id).then((value) {
          // selected_sub_category.value=index;
          loading.value=false;
          //todo add favorite
          Get.to(()=>ProductView(value!));
        }).catchError((err){
          loading.value=false;
        });
      }else{
        Get.to(()=>NoInternet())!.then((value) {
          go_to_product(index);
        });
      }
    });
  }
}