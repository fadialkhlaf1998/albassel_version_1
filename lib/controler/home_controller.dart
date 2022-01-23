import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
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
  List<MyProduct> bestSellers=<MyProduct>[];
  bool makeup=false;

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
    Get.offAll(()=>Welcome());
  }


  search(String query){
    // if(query.isEmpty){
    //   products.clear();
    //   products.addAll(temp_products);
    // }else {
    //   products.clear();
    //   for (int i = 0; i < temp_products.length; i++) {
    //     if(temp_products[i].title!.toLowerCase().contains(query.toLowerCase())){
    //       products.add(temp_products[i]);
    //     }
    //   }
    // }
  }
  on_submit(){
    // products.clear();
    // products.addAll(temp_products);

  }

  // get_product_by_collection(int id){
  //   Api.check_internet().then((internet) {
  //     if (internet) {
  //       product_loading.value=true;
  //       products.clear();
  //       temp_products.clear();
  //       Api.get_products(id).then((_products) {
  //         products.addAll(_products);
  //         temp_products.addAll(_products);
  //         for(int i=0;i<wishListController.wishlist.length;i++){
  //           for(int j=0;j<products.length;j++){
  //             if(wishListController.wishlist[i].id==products[j].id){
  //               products[j].is_favoirite.value=true;
  //               temp_products[j].is_favoirite.value=true;
  //             }
  //           }
  //         }
  //         product_loading.value=false;
  //       });
  //     }else{
  //       Get.to(NoInternet())!.then((value) {
  //         get_product_by_collection(id);
  //       });
  //     }
  //   });
  // }

  // go_to_product_page(int index){
  //   Api.check_internet().then((internet) {
  //     if (internet) {
  //       loading.value=true;
  //       Api.get_products_variants_by_id(products[index].id!).then((variants){
  //         selected_product=products[index];
  //         selected_product!.variants=variants;
  //         wishListController.is_favorite(products[index]);
  //         Get.to(()=>ProductView())!.then((value){
  //           loading.value=false;
  //         });
  //       });
  //     }else{
  //       Get.to(NoInternet())!.then((value) {
  //         go_to_product_page(index);
  //       });
  //     }
  //   });
  //
  // }

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
  go_to_product_page(int product_id){
    loading.value=true;
    MyApi.check_internet().then((internet) {
      if (internet) {
        MyApi.getProductsInfo(product_id).then((value) {
          // selected_sub_category.value=index;
          loading.value=false;
          //todo add favorite
          Get.to(()=>ProductView(value!));
        }).catchError((err){
          loading.value=false;
        });
      }else{
        Get.to(()=>NoInternet())!.then((value) {
          go_to_product(product_id);
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



  // get_data(){
  //     try{
  //       Api.check_internet().then((internet) {
  //         if (internet) {
  //           if(introController.category.length>0){
  //             collections.addAll(introController.collections);
  //             loading.value=false;
  //             Api.get_products(collections.first.id!).then((_products) {
  //               products.addAll(_products);
  //               temp_products.addAll(_products);
  //               for(int i=0;i<wishListController.wishlist.length;i++){
  //                 for(int j=0;j<products.length;j++){
  //                   if(wishListController.wishlist[i].id==products[j].id){
  //                     products[j].is_favoirite.value=true;
  //                     temp_products[j].is_favoirite.value=true;
  //                   }
  //                 }
  //               }
  //               scrollController.animateTo(
  //                 80,
  //                 curve: Curves.easeOut,
  //                 duration: const Duration(milliseconds: 800),
  //               );
  //               product_loading.value=false;
  //             });
  //           }else{
  //             introController.get_data();
  //             get_data();
  //           }
  //         }else{
  //           Get.to(NoInternet())!.then((value) {
  //             get_data();
  //           });
  //         }
  //       });
  //     }catch (e){
  //       get_data();
  //     }
  //
  //
  //   }

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
}