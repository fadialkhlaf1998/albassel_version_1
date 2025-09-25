import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:albassel_version_1/helper/api_v2.dart';
import 'package:albassel_version_1/model/product.dart';
import 'package:albassel_version_1/model_v2/product.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/my_model/my_product.dart';
import 'package:albassel_version_1/my_model/product_info.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:albassel_version_1/view/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  var selected_slider=0.obs;
  var cart_count=1.obs;
  CartController cartController = Get.find();
  WishListController wishListController = Get.find();
  Product? myProduct;
  double product_rating=0;
  var loading = true.obs;
  Option? selectedOptions;

  getData(int product_id)async{
    loading(true);
    myProduct = await ApiV2.getProductDetails(product_id);
    if(myProduct == null){
      Get.back();
      return;
    }
    // for(int i=0;i<wishListController.rate.length;i++){
    //   if(myProduct!.id==wishListController.rate[i].id){
    //     product_rating=wishListController.rate[i].rate;
    //   }
    // }
    // wishListController.add_to_recently(myProduct!);
    loading(false);
  }


  increase(){
    if(cart_count<myProduct!.availability)
    cart_count.value++;
  }

  decrease(){
    if(cart_count.value>1)
    cart_count.value--;
  }

  Future<bool> add_to_cart(BuildContext context)async{
    return await cartController.addOrUpdateCart(myProduct!.id,selectedOptions?.id, cart_count.value,context);
  }

  Future<void> favorite(Product product,BuildContext context)async{
    product.wishlistLoading(true);
    product.favorite.value = !product.favorite.value;
    if(product.favorite.value){
      await wishListController.addToWishlist(product.id,context);
    }else{
      await wishListController.deleteFromWishlist(product.id,context);
    }
    product.wishlistLoading(false);
  }

  add_review(String text ,int product_id,BuildContext context){
    if(Global.customer!=null){
      loading(true);
      myProduct!.reviews.add(Review(id: 100, productId: myProduct!.id,
          customerId: Global.customer!.id, body: text, customerName: Global.customer!.firstname+" "+Global.customer!.lastname));
      MyApi.add_review(Global.customer!.id, product_id, text);
      loading(false);
      App.sucss_msg(context, App_Localization.of(context).translate("publish_success"));
    }else{
      App.error_msg(context, App_Localization.of(context).translate("login_first"));
    }
  }


}