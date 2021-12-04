import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:albassel_version_1/model/product.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  Product? product;
  var selected_slider=0.obs;
  var cart_count=1.obs;
  CartController cartController = Get.find();
  WishListController wishListController = Get.find();

  increase(){
    cart_count.value++;
  }

  decrease(){
    if(cart_count.value>1)
    cart_count.value--;
  }

  add_to_cart(){
    cartController.add_to_cart(product!, cart_count.value);
  }

  favorite(Product product){
    product.is_favoirite.value = !product.is_favoirite.value;
    if(product.is_favoirite.value){
      wishListController.add_to_wishlist(product);
    }else{
      wishListController.delete_from_wishlist(product);
    }
  }

}