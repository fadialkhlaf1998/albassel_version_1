import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/model/product.dart';
import 'package:albassel_version_1/my_model/my_product.dart';
import 'package:albassel_version_1/my_model/product_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WishListController extends GetxController{
  List<MyProduct> wishlist = <MyProduct>[].obs;
  List<MyProduct> recently = <MyProduct>[].obs;
  List<MyProduct> rate = <MyProduct>[].obs;

  add_to_wishlist(MyProduct product,BuildContext context){
    App.sucss_msg(context, App_Localization.of(context).translate("wishlist_msg"));
    wishlist.add(product);
    Store.save_wishlist(wishlist);
  }
  delete_from_wishlist(MyProduct product){
    for( int i=0 ;i < wishlist.length ; i++){
      if(wishlist[i].id==product.id){
        wishlist.removeAt(i);
        break;
      }
    }
    Store.save_wishlist(wishlist);
  }
  add_to_recently(MyProduct myProduct){

    if(recently.length>=10){
      recently.removeAt(0);
      for(int i=0;i<recently.length;i++){
        if(recently[i].id==myProduct.id){
          return;
        }
      }
      recently.add(myProduct);
    }else{
      for(int i=0;i<recently.length;i++){
        if(recently[i].id==myProduct.id){
          return;
        }
      }
      recently.add(myProduct);
    }
    Store.save_recently(recently);
  }
  add_to_rate(MyProduct myProduct,double rating){
      myProduct.rate=rating;
      rate.add(myProduct);
    Store.save_rate(rate);
  }
  bool is_favorite(MyProduct product){
    for(int i=0;i<wishlist.length;i++){
      if(product.id==wishlist[i].id){
        // product.is_favoirite.value=true;
        return true;
      }
    }
    // product.is_favoirite.value=false;
    return false;
  }

}