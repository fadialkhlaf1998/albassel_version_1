import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/intro_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:albassel_version_1/model/product.dart';
import 'package:albassel_version_1/my_model/category.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/my_model/my_product.dart';
import 'package:albassel_version_1/my_model/sub_category.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../view/product.dart';

class CategoryViewNavController extends GetxController{
  List<SubCategory> sub_categories=<SubCategory>[].obs;
  List<Category> categories=<Category>[].obs;
  List<MyProduct> my_products=<MyProduct>[].obs;
  var loading = false.obs;
  Rx<int> selected_sub_category = 0.obs;
  Rx<int> selected_category = 0.obs;
  IntroController introController = Get.find();
  WishListController wishListController = Get.find();
  CartController cartController = Get.find();

  @override
  void onInit() {
    categories.addAll(introController.category);
    if(introController.category.isNotEmpty)
    MyApi.getSubCategory(introController.category.first.id).then((sub_cat) {
      sub_categories=sub_cat;
      if(sub_cat.isNotEmpty){
        MyApi.getProducts(wishListController.wishlist,sub_cat.first.id).then((value) {
          my_products=value;
        });
      }
    });

  }
  update_sub_category(int index){
    loading.value=true;
    MyApi.check_internet().then((internet) {
      if (internet) {
        selected_category.value=index;
        MyApi.getSubCategory(categories[index].id).then((value) {
          selected_sub_category=0.obs;
          sub_categories.clear();
          sub_categories.addAll(value);
          loading.value=false;
          update_product(0);
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