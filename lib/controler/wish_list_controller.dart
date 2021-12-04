import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/model/product.dart';
import 'package:get/get.dart';

class WishListController extends GetxController{
  List<Product> wishlist = <Product>[].obs;

  add_to_wishlist(Product product){
    wishlist.add(product);
    Store.save_wishlist(wishlist);
  }
  delete_from_wishlist(Product product){
    for( int i=0 ;i < wishlist.length ; i++){
      if(wishlist[i].id==product.id){
        wishlist.removeAt(i);
        break;
      }
    }
    Store.save_wishlist(wishlist);
  }
  bool is_favorite(Product product){
    for(int i=0;i<wishlist.length;i++){
      if(product.id==wishlist[i].id){
        product.is_favoirite.value=true;
        return true;
      }
    }
    product.is_favoirite.value=false;
    return false;
  }

}