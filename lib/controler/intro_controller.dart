import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:albassel_version_1/helper/api.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/model/collection.dart';
import 'package:albassel_version_1/view/home.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:albassel_version_1/view/verification_code.dart';
import 'package:albassel_version_1/view/welcome.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class IntroController extends GetxController{
  List<Collection> collections=<Collection>[];
  CartController cartController = Get.put(CartController());
  WishListController wishListController = Get.put(WishListController());

  @override
  Future<void> onInit() async {
    super.onInit();
    get_data();
  }

  get_data(){
   Api.check_internet().then((internet) {
     if(internet){
       if(collections.isEmpty)
       {
         Api.get_collections().then((value) {
           if(value.isNotEmpty){
             collections.addAll(value);
             get_nav();
           }else{
             get_nav();
           }
         }).catchError((err){
           collections=<Collection>[];
         });
       }
       Store.load_order().then((my_order) {
         cartController.my_order.value = my_order;
       });
       Store.load_wishlist().then((wishlist) {
         wishListController.wishlist.addAll(wishlist);
       });
     }else{
       Future.delayed(Duration(milliseconds: 1000),(){
          Get.to(()=>NoInternet())!.then((value) {
           get_data();
         });
       });

     }
   });
  }

  get_nav(){

    Store.loadLogInInfo().then((info) {
      if(info.email=="non"){
        Get.offAll(Welcome());
      }else{
        Store.load_verificat().then((verify){
          if(verify){
            Api.check_internet().then((internet) {
              if(internet){
                Api.login_customers(info.email);
                Get.offAll(()=>Home());
              }else{
                Get.to(()=>NoInternet())!.then((value) {
                  get_nav();
                });
              }
            });

          }else{
            Get.offAll(VerificationCode());
          }
        });
      }
    });
  }
}