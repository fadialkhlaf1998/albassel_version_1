import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/category_view_nav_controller.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/helper/api_v2.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/model_v2/product.dart';
import 'package:albassel_version_1/my_model/my_product.dart';
import 'package:albassel_version_1/my_model/product_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WishListController extends GetxController{

  List<Product> wishlist = <Product>[].obs;

  RxBool loading = false.obs;


  // @override
  // void onInit() {
  //   super.onInit();
  //   getData();
  // }

  Future<void> getData()async{
    if(Global.customer == null){
      return;
    }
    loading(true);
    wishlist = await ApiV2.getWishList();
    loading(false);
    return ;
  }

  addToWishlist(int product_id,BuildContext context)async{
    if(Global.customer == null){
      App.error_msg(context, "login_first");
      return false;
    }
    loading(true);
    await ApiV2.addToWishlist(product_id);
    App.sucss_msg(context, App_Localization.of(context).translate("wishlist_msg"));
    getData();
  }
  deleteFromWishlist(int product_id,BuildContext context)async {
    if(Global.customer == null){
      App.error_msg(context, "login_first");
      return false;
    }
    loading(true);
    await ApiV2.deleteFromWishlist(product_id);
    getData();
  }
  moveToCart(int product_id,BuildContext context)async{
    //todo add product to cart
    // loading(true);
    CartController cartController = Get.find();
    var succ = await cartController.addOrUpdateCart(product_id, null, 1, context);
    if(succ){
      deleteFromWishlist(product_id,context);
    }else{
      // loading(false);
    }
  }
  // CategoryViewNavController categoryViewNavController = Get.find();
  // HomeController homeController = Get.find();
  //
  // add_to_wishlist(MyProduct product,BuildContext context){
  //   App.sucss_msg(context, App_Localization.of(context).translate("wishlist_msg"));
  //   oldWishlist.add(product);
  //   product.favorite.value=true;
  //   // Store.save_wishlist(wishlist);
  //   // for(int i=0;i<categoryViewNavController.my_products.length;i++){
  //   //   if(categoryViewNavController.my_products[i].id==product.id){
  //   //     categoryViewNavController.my_products[i].favorite.value=true;
  //   //     break;
  //   //   }
  //   // }
  //   //
  //   // for(int i=0;i<homeController.bestSellers.length;i++){
  //   //   if(homeController.bestSellers[i].id==product.id){
  //   //     homeController.bestSellers[i].favorite.value=true;
  //   //     break;
  //   //   }
  //   // }
  // }
  // delete_from_wishlist(MyProduct product){
  //   for( int i=0 ;i < oldWishlist.length ; i++){
  //     if(oldWishlist[i].id==product.id){
  //       oldWishlist.removeAt(i);
  //       product.favorite.value=false;
  //       break;
  //     }
  //   }
  //   // Store.save_wishlist(wishlist);
  //   // for(int i=0;i<categoryViewNavController.my_products.length;i++){
  //   //   if(categoryViewNavController.my_products[i].id==product.id){
  //   //     categoryViewNavController.my_products[i].favorite.value=false;
  //   //     break;
  //   //   }
  //   // }
  //   //
  //   // for(int i=0;i<homeController.bestSellers.length;i++){
  //   //   if(homeController.bestSellers[i].id==product.id){
  //   //     homeController.bestSellers[i].favorite.value=false;
  //   //     break;
  //   //   }
  //   // }
  //
  // }
  // add_to_recently(Product myProduct){
  //
  //   if(recently.length>=10){
  //     recently.removeAt(0);
  //     for(int i=0;i<recently.length;i++){
  //       if(recently[i].id==myProduct.id){
  //         return;
  //       }
  //     }
  //     recently.add(myProduct);
  //   }else{
  //     for(int i=0;i<recently.length;i++){
  //       if(recently[i].id==myProduct.id){
  //         return;
  //       }
  //     }
  //     recently.add(myProduct);
  //   }
  //   Store.save_recently(recently);
  // }
  // add_to_rate(Product myProduct,double rating){
  //     myProduct.rate=rating;
  //     rate.add(myProduct);
  //   Store.save_rate(rate);
  // }
  // bool is_favorite(Product product){
  //   for(int i=0;i<oldWishlist.length;i++){
  //     if(product.id==oldWishlist[i].id){
  //       // product.is_favoirite.value=true;
  //       return true;
  //     }
  //   }
  //   // product.is_favoirite.value=false;
  //   return false;
  // }

}