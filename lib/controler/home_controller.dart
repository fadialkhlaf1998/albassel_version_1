import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/category_view_nav_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:albassel_version_1/helper/api.dart';
import 'package:albassel_version_1/controler/intro_controller.dart';
import 'package:albassel_version_1/helper/api_v2.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/model_v2/product.dart';
import 'package:albassel_version_1/view/about_us.dart';
import 'package:albassel_version_1/my_model/brand.dart';
import 'package:albassel_version_1/my_model/category.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/my_model/my_product.dart';
import 'package:albassel_version_1/my_model/sub_category.dart';
import 'package:albassel_version_1/my_model/slider.dart';
import 'package:albassel_version_1/my_model/top_category.dart';
import 'package:albassel_version_1/view/category_view.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:albassel_version_1/view/product.dart';
import 'package:albassel_version_1/view/products.dart';
import 'package:albassel_version_1/view/products_search.dart';
import 'package:albassel_version_1/view/setting.dart';
import 'package:albassel_version_1/view/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  List<Brand> brands=<Brand>[];
  List<MySlider> slider=<MySlider>[];
  List<TopCategory> topCategory=<TopCategory>[];
  RxList<Product> bestSellers=<Product>[].obs;
  bool makeup=false;
  CartController cartController = Get.find();
  CategoryViewNavController categoryViewNavController=Get.put(CategoryViewNavController());
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var selected_bottom_nav_bar = 0.obs;
  ScrollController scrollController = new ScrollController();
  // List<Collection> collections=<Collection>[].obs;
  List<Category> category=<Category>[];
  List<SubCategory> sub_Category=<SubCategory>[];
  List<SubCategory> sub_Category_category_view=<SubCategory>[];
  List<Product> temp_products=<Product>[].obs;
  IntroController introController=Get.find();
  WishListController wishListController = Get.find();
  Product? selected_product;
  var product_loading=true.obs;
  var showFloatActionBtn=true.obs;
  var loading=true.obs;
  var selder_selected=0.obs;
  var selected_category=0.obs;
  var bottom_selected=0.obs;
  List<ImageProvider> imageProvider = <ImageProvider>[];
  String marqueeText = "";

  @override
  Future<void> onInit() async {
    super.onInit();
    // for(int i=0;i<introController.sliders.length;i++){
    //   print(i);
    //   imageProvider.add(NetworkImage(introController.sliders[i].image));
    // }
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
    loading.value=true;
    sub_Category.clear();
    loading.value=false;
    Get.back();
  }
  void nave_to_wishlist() {
    selected_bottom_nav_bar.value=3;
    Get.back();
  }
  void nave_to_setting() {
    Get.to(()=>Setting());
  }
  void nave_to_about_us() {
    //todo nav to about us
    Get.to(()=>AboutUs());
  }
  void nave_to_logout() {
    Store.logout();
    // cartController.clear_cart();
    updateBestSellersSubCategory();
    wishListController.wishlist.clear();
    Get.offAll(()=>Welcome());
  }
  updateBestSellersSubCategory()async{
    print(Global.customer_type_decoder);
    print('best sellers');
    List<Product> list = await ApiV2.getBeastSellersProducts();
    introController.bestSellers = list;
    bestSellers.clear();
    bestSellers.addAll(list);
    for(int i=0;i<bestSellers.length;i++){
      print(bestSellers[i].price);
    }
    // loading.value = true;
    categoryViewNavController.onInit();
  }

  search(String query){}
  on_submit(){}

  get_sub_category(int category_id,BuildContext context){
    product_loading.value=true;
    if(category_id==5){
      makeup=true;
      MyApi.getMakeupSubSubCategory().then((value) {
        sub_Category.clear();
        product_loading.value=false;
        sub_Category.addAll(value);
        sub_Category_category_view=value;
      }).catchError((err){
        product_loading.value=false;
        // App.error_msg(context, App_Localization.of(context).translate("wrong"));

      });
    }else{
      makeup=false;
      MyApi.getSubCategory(category_id).then((value) {
        sub_Category.clear();
        product_loading.value=false;
        sub_Category.addAll(value);
        sub_Category_category_view=value;
      }).catchError((err){
        product_loading.value=false;
        // App.error_msg(context, App_Localization.of(context).translate("wrong"));

      });
    }
  }
  get_sub_categoryPage(int category_id,BuildContext context){

    product_loading.value=true;
    if(category_id==5){
      makeup=true;
      MyApi.getMakeupSubSubCategory().then((value) {
        sub_Category.clear();
        product_loading.value=false;
        sub_Category=value;
        sub_Category_category_view=value;
        Get.to(()=>CategoryView());
      }).catchError((err){
        product_loading.value=false;
        // App.error_msg(context, App_Localization.of(context).translate("wrong"));

      });
    }else{
      makeup=false;
      MyApi.getSubCategory(category_id).then((value) {
        sub_Category.clear();
        product_loading.value=false;
        sub_Category=value;
        sub_Category_category_view=value;
        Get.to(()=>CategoryView());
      }).catchError((err){
        product_loading.value=false;
        // App.error_msg(context, App_Localization.of(context).translate("wrong"));

      });
    }
  }

  get_products(int sub_category,index,BuildContext context){
    product_loading.value=true;
    ApiV2.getProductsBySubCategory(sub_category).then((value) {
      product_loading.value=false;
      Get.to(()=>ProductsView(sub_Category, value,index));
    }).catchError((err){
      product_loading.value=false;
      // App.error_msg(context, App_Localization.of(context).translate("wrong"));

    });
  }
  get_productsMakeup(int sub_category,index,BuildContext context){
    product_loading.value=true;
    MyApi.getMakeupSubCategory(sub_category).then((sub_cat) {
      if(sub_cat.isNotEmpty){
        ApiV2.getProductsBySubCategory(sub_cat.first.id).then((value) {
          product_loading.value=false;
          sub_Category=sub_cat;
          Get.to(()=>ProductsView(sub_cat, value,index));
        }).catchError((err){
          product_loading.value=false;
          // App.error_msg(context, App_Localization.of(context).translate("wrong"));

        });
      }else{
        product_loading.value=false;
        App.error_msg(context, App_Localization.of(context).translate("fail_search"));
      }

    });
  }

  get_products_by_search(String query,BuildContext context){
    product_loading.value=true;
    ApiV2.search(query).then((value) {
      product_loading.value=false;
      if(value.isNotEmpty){
        Get.to(()=>ProductsSearchView(value,query));
      }else{
        App.error_msg(context, App_Localization.of(context).translate("fail_search"));
      }

    }).catchError((err){
      product_loading.value=false;
      // App.error_msg(context, App_Localization.of(context).translate("wrong"));

    });
  }

  get_products_by_brand(int brand_id,BuildContext context){
    product_loading.value=true;
    ApiV2.getProductsByBrand(brand_id).then((value) {
      product_loading.value=false;
      if(value.isNotEmpty){
        Get.to(()=>ProductsSearchView(value,""));
      }else{
        App.error_msg(context, App_Localization.of(context).translate("fail_search"));
      }

    })
        .catchError((err){
      product_loading.value=false;
      // App.error_msg(context, App_Localization.of(context).translate("wrong"));

    });
  }
  go_to_product_page(MySlider slid){

    if(slid.product_id!=null&&slid.is_product==1){
      Get.to(()=>ProductView(slid.product_id!));
    }else{
      product_loading.value=true;
      ApiV2.getProductsBySlider(slid.id).then((value) {
        product_loading.value=false;
        if(value.isNotEmpty){
          Get.to(()=>ProductsSearchView(value,""));
        }
      }).catchError((err){
        product_loading.value=false;
      });
    }
  }

  get_data(){
    try{
      marqueeText="";
      for(int i=0;i<introController.marquee.length;i++){
        marqueeText+=introController.marquee[i].getText()+" | ";
        // if(i<introController.marquee.length-1){
        //   marqueeText+=introController.marquee[i].getText()+" | ";
        // }else{
        //   marqueeText+=introController.marquee[i].getText();
        // }
      }
      if(introController.category.length>0){
        category.clear();
        category.addAll(introController.category);
        loading.value=false;
        if(introController.topCategory.isNotEmpty){
          topCategory.clear();
          topCategory.addAll(introController.topCategory);
          product_loading.value=false;
        }else{
          introController.get_data();
          get_data();
        }
        if(introController.bestSellers.isNotEmpty){
          bestSellers.clear();
          bestSellers.addAll(introController.bestSellers);
        }else{
          introController.get_data();
          get_data();
        }

        if(introController.brands.isNotEmpty){
          brands.clear();
          brands.addAll(introController.brands);
        }else{
          introController.get_data();
          get_data();
        }
        if(introController.sliders.isNotEmpty){
          slider.clear();
          slider.addAll(introController.sliders);
        }else{
          introController.get_data();
          get_data();
        }
      }else{
        introController.get_data();
        get_data();
      }
    }catch (e){
      get_data();
    }
  }


  set_bottom_bar(int index){
    selected_bottom_nav_bar.value=index;
  }

  go_to_product(int index){
    Get.to(()=>ProductView(bestSellers[index].id));
  }

  go_to_product_by_id(int id){
    Get.to(()=>ProductView(id));
  }
}