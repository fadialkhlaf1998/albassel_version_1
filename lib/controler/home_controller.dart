import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/category_view_nav_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:albassel_version_1/helper/api.dart';
import 'package:albassel_version_1/controler/intro_controller.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/view/about_us.dart';
import 'package:albassel_version_1/model/collection.dart';
import 'package:albassel_version_1/model/product.dart';
import 'package:albassel_version_1/my_model/best_sellers.dart';
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
  RxList<MyProduct> bestSellers=<MyProduct>[].obs;
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
  var loading=true.obs;
  var selder_selected=0.obs;
  var selected_category=0.obs;
  var bottom_selected=0.obs;
  List<ImageProvider> imageProvider = <ImageProvider>[];

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
    cartController.clear_cart();
    updateBestSellersSubCategory();
    wishListController.wishlist.clear();
    Get.offAll(()=>Welcome());
  }
  updateBestSellersSubCategory()async{
    print(Global.customer_type_decoder);
    print('best sellers');
    List<MyProduct> list = await MyApi.getBestSellers(wishListController.wishlist);
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
    MyApi.check_internet().then((internet) {
      if (internet) {
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

      }else{
        Get.to(NoInternet())!.then((value) {
          get_sub_category(category_id,context);
        });
      }
    });
  }
  get_sub_categoryPage(int category_id,BuildContext context){

    MyApi.check_internet().then((internet) {
      if (internet) {
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

      }else{
        Get.to(NoInternet())!.then((value) {
          get_sub_category(category_id,context);
        });
      }
    });
  }

  get_products(int sub_category,index,BuildContext context){
    MyApi.check_internet().then((internet) {
      if (internet) {
        product_loading.value=true;
        MyApi.getProducts(wishListController.wishlist,sub_category).then((value) {
          product_loading.value=false;
          Get.to(()=>ProductsView(sub_Category, value,index));
        }).catchError((err){
          product_loading.value=false;
          // App.error_msg(context, App_Localization.of(context).translate("wrong"));

        });
      }else{
        Get.to(NoInternet())!.then((value) {
          get_products(sub_category,index,context);
        });
      }
    });
  }
  get_productsMakeup(int sub_category,index,BuildContext context){
    MyApi.check_internet().then((internet) {
      if (internet) {
        product_loading.value=true;
        MyApi.getMakeupSubCategory(sub_category).then((sub_cat) {
          if(sub_cat.isNotEmpty){
            MyApi.getProducts(wishListController.wishlist,sub_cat.first.id).then((value) {
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

      }else{
        Get.to(NoInternet())!.then((value) {
          get_products(sub_category,index,context);
        });
      }
    });
  }

  get_products_by_search(String query,BuildContext context){
    MyApi.check_internet().then((internet) {
      if (internet) {
        product_loading.value=true;
        MyApi.getProductsSearch(wishListController.wishlist,query).then((value) {
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
      }else{
        Get.to(NoInternet())!.then((value) {
          get_products_by_search(query,context);
        });
      }
    });
  }

  get_products_by_brand(int brand_id,BuildContext context){
    MyApi.check_internet().then((internet) {
      if (internet) {
        product_loading.value=true;
        MyApi.getProductsByBrand(wishListController.wishlist,brand_id).then((value) {
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
      }else{
        Get.to(NoInternet())!.then((value) {
          get_products_by_brand(brand_id,context);
        });
      }
    });
  }
  go_to_product_page(MySlider slid){
    product_loading.value=true;
    MyApi.check_internet().then((internet) {
      if (internet) {
        if(slid.product_id!=null&&slid.is_product==1){
          MyApi.getProductsInfo(slid.product_id!).then((value) {
            product_loading.value=false;
            //todo add favorite
            Get.to(()=>ProductView(value!));
          }).catchError((err){
            product_loading.value=false;
          });
        }else{
          MyApi.sliderProducts(wishListController.wishlist,slid.id).then((value) {
            product_loading.value=false;
            if(value.isNotEmpty){
              Get.to(()=>ProductsSearchView(value,""));
            }
          }).catchError((err){
            product_loading.value=false;
          });
        }

      }else{
        Get.to(()=>NoInternet())!.then((value) {
          go_to_product_page(slid);
        });
      }
    });
  }

  get_data(){
    try{
      MyApi.check_internet().then((internet) {
        if (internet) {
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

  go_to_product(int index){
    product_loading.value=true;
    MyApi.check_internet().then((internet) {
      if (internet) {
        MyApi.getProductsInfo(bestSellers[index].id).then((value) {
          product_loading.value=false;
          //todo add favorite
          Get.to(()=>ProductView(value!));
        });
      }else{
        Get.to(()=>NoInternet())!.then((value) {
          go_to_product(index);
        });
      }
    });
  }

  go_to_product_by_id(int id){
    loading.value=true;
    MyApi.check_internet().then((internet) {
      if (internet) {
        MyApi.getProductsInfo(id).then((value) {
          loading.value=false;
          //todo add favorite
          Get.to(()=>ProductView(value!));
        });
      }else{
        Get.to(()=>NoInternet())!.then((value) {
          go_to_product_by_id(id);
        });
      }
    });
  }
}