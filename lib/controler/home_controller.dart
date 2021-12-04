import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:albassel_version_1/helper/api.dart';
import 'package:albassel_version_1/controler/intro_controller.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/model/collection.dart';
import 'package:albassel_version_1/model/product.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:albassel_version_1/view/product.dart';
import 'package:albassel_version_1/view/setting.dart';
import 'package:albassel_version_1/view/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var selected_bottom_nav_bar = 0.obs;
  List<Collection> collections=<Collection>[].obs;
  List<Product> products=<Product>[].obs;
  List<Product> temp_products=<Product>[].obs;
  IntroController introController=Get.find();
  WishListController wishListController = Get.find();
  Product? selected_product;
  var product_loading=true.obs;
  var loading=true.obs;
  var selder_selected=0.obs;
  var bottom_selected=0.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    get_data();
  }


  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    Get.back();
  }

  void nave_to_home() {
    selected_bottom_nav_bar.value=0;
    Get.back();
  }
  void nave_to_wishlist() {
    selected_bottom_nav_bar.value=2;
    Get.back();
  }
  void nave_to_setting() {
    Get.to(()=>Setting());
  }
  void nave_to_about_us() {
    //todo nav to about us
    Get.back();
  }
  void nave_to_logout() {
    Store.logout();
    Get.offAll(()=>Welcome());
  }


  search(String query){
    if(query.isEmpty){
      products.clear();
      products.addAll(temp_products);
    }else {
      products.clear();
      for (int i = 0; i < temp_products.length; i++) {
        if(temp_products[i].title!.toLowerCase().contains(query.toLowerCase())){
          products.add(temp_products[i]);
        }
      }
    }
  }
  on_submit(){
    products.clear();
    products.addAll(temp_products);
  }

  get_product_by_collection(int id){
    Api.check_internet().then((internet) {
      if (internet) {
        product_loading.value=true;
        products.clear();
        temp_products.clear();
        Api.get_products(id).then((_products) {
          products.addAll(_products);
          temp_products.addAll(_products);
          for(int i=0;i<wishListController.wishlist.length;i++){
            for(int j=0;j<products.length;j++){
              if(wishListController.wishlist[i].id==products[j].id){
                products[j].is_favoirite.value=true;
                temp_products[j].is_favoirite.value=true;
              }
            }
          }
          product_loading.value=false;
        });
      }else{
        Get.to(NoInternet())!.then((value) {
          get_product_by_collection(id);
        });
      }
    });

  }

  go_to_product_page(int index){
    Api.check_internet().then((internet) {
      if (internet) {
        loading.value=true;
        Api.get_products_variants_by_id(products[index].id!).then((variants){
          selected_product=products[index];
          selected_product!.variants=variants;
          wishListController.is_favorite(products[index]);
          Get.to(()=>ProductView())!.then((value){
            loading.value=false;
          });
        });
      }else{
        Get.to(NoInternet())!.then((value) {
          go_to_product_page(index);
        });
      }
    });

  }

  get_data(){
    try{
      Api.check_internet().then((internet) {
        if (internet) {
          if(introController.collections.length>0){
            collections.addAll(introController.collections);
            loading.value=false;
            Api.get_products(collections.first.id!).then((_products) {
              products.addAll(_products);
              temp_products.addAll(_products);
              for(int i=0;i<wishListController.wishlist.length;i++){
                for(int j=0;j<products.length;j++){
                  if(wishListController.wishlist[i].id==products[j].id){
                    products[j].is_favoirite.value=true;
                    temp_products[j].is_favoirite.value=true;
                  }
                }
              }
              product_loading.value=false;
            });
          }else{
            introController.get_data();
            get_data();
          }
        }else{
          Get.to(NoInternet())!.then((value) {
            get_data();
          });
        }
      });
    }catch (e){
      get_data();
    }


  }

  set_bottom_bar(int index){
    selected_bottom_nav_bar.value=index;
  }
}