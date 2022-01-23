import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:albassel_version_1/model/product.dart';
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
  ProductInfo? myProduct;
  var loading = false.obs;




  increase(){
    cart_count.value++;
  }

  decrease(){
    if(cart_count.value>1)
    cart_count.value--;
  }

  add_to_cart(){
    MyProduct myProduct1 = MyProduct(id: myProduct!.id, subCategoryId: myProduct!.subCategoryId, brandId: myProduct!.brandId, title: myProduct!.title, subTitle: myProduct!.subTitle, description: myProduct!.description, price: myProduct!.price, rate: myProduct!.rate, image: myProduct!.image, ratingCount: myProduct!.ratingCount,availability: myProduct!.availability);
    cartController.add_to_cart(myProduct1, cart_count.value);
  }

  favorite(ProductInfo product,BuildContext context){
    product.is_favoirite.value = !product.is_favoirite.value;
    if(product.is_favoirite.value){
      MyProduct myProduct1 = MyProduct(id: myProduct!.id, subCategoryId: myProduct!.subCategoryId, brandId: myProduct!.brandId, title: myProduct!.title, subTitle: myProduct!.subTitle, description: myProduct!.description, price: myProduct!.price, rate: myProduct!.rate, image: myProduct!.image, ratingCount: myProduct!.ratingCount,availability: myProduct!.availability);
      wishListController.add_to_wishlist(myProduct1,context);
    }else{
      MyProduct myProduct1 = MyProduct(id: myProduct!.id, subCategoryId: myProduct!.subCategoryId, brandId: myProduct!.brandId, title: myProduct!.title, subTitle: myProduct!.subTitle, description: myProduct!.description, price: myProduct!.price, rate: myProduct!.rate, image: myProduct!.image, ratingCount: myProduct!.ratingCount,availability: myProduct!.availability);
      wishListController.delete_from_wishlist(myProduct1);
    }
  }

  add_review(String text ,int product_id,BuildContext context){
    print(Global.customer);
    if(Global.customer!=null){
      //todo change global customer
      MyApi.add_review(Global.customer!.id, product_id, text);
      App.sucss_msg(context, App_Localization.of(context).translate("publish_success"));
    }else{
      App.error_msg(context, App_Localization.of(context).translate("login_first"));
    }
  }


}