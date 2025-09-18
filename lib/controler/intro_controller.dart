import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:albassel_version_1/helper/api_v2.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/model_v2/product.dart';
import 'package:albassel_version_1/my_model/brand.dart';
import 'package:albassel_version_1/my_model/category.dart';
import 'package:albassel_version_1/my_model/marquee.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/my_model/my_product.dart';
import 'package:albassel_version_1/my_model/slider.dart';
import 'package:albassel_version_1/my_model/start_up.dart';
import 'package:albassel_version_1/my_model/sub_category.dart';
import 'package:albassel_version_1/view/home.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:albassel_version_1/view/verification_code.dart';
import 'package:albassel_version_1/view/welcome.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../my_model/top_category.dart';

class IntroController extends GetxController{
  List<Category> category=<Category>[];
  List<SubCategory> sub_Category=<SubCategory>[];
  List<Brand> brands=<Brand>[];
  List<MySlider> sliders=<MySlider>[];
  List<Marquee> marquee=<Marquee>[];

  List<TopCategory> topCategory=<TopCategory>[];
  List<Product> bestSellers=<Product>[];
  CartController cartController = Get.put(CartController());
  WishListController wishListController = Get.put(WishListController());

  @override
  Future<void> onInit() async {
    super.onInit();
    get_data();
  }

  get_data()async{
    Store.load_customer_type();
    // Store.load_recently().then((rec) {
    //   wishListController.recently=rec.obs;
    // });
    // Store.load_rate().then((rate) {
    //   wishListController.rate=rate.obs;
    // });
    Store.load_remember();
    // Store.load_address();
    // var t = await get_customer_type();
    if(category.isEmpty)
    {
      print('*-*Start*-*');
      String code = await Store.load_discount_code();
      if(code!="non" && code!=""){
        var value = await MyApi.discountCode(code);
        if(value!=null){
          Global.discountCode = value.code;
        }
      }
      print('*-*End*-*');
      var val = await getHomeData();

      Future.delayed(Duration(milliseconds: 800),(){
        get_nav();
      });

    }
  }


  Future<bool> getHomeData()async{
    StartUp? value = await ApiV2.startUp();
    if(value == null){
      return await getHomeData();
    }
    category = value.category;
    brands = value.brand;
    sliders = value.slider;
    topCategory = value.topCategories;
    bestSellers = value.bestSellers;
    marquee = value.marquee;
    return true;
  }

  // get_data(){
  //   Api.check_internet().then((internet) {
  //     if(internet){
  //       if(collections.isEmpty)
  //       {
  //         Api.get_collections().then((value) {
  //           if(value.isNotEmpty){
  //             collections.addAll(value);
  //             get_nav();
  //           }else{
  //             get_nav();
  //           }
  //         }).catchError((err){
  //           collections=<Collection>[];
  //         });
  //       }
  //       Store.load_order().then((my_order) {
  //         cartController.my_order.value = my_order;
  //       });
  //       Store.load_wishlist().then((wishlist) {
  //         wishListController.wishlist.addAll(wishlist);
  //       });
  //     }else{
  //       Future.delayed(Duration(milliseconds: 1000),(){
  //         Get.to(()=>NoInternet())!.then((value) {
  //           get_data();
  //         });
  //       });
  //
  //     }
  //   });
  // }

  get_nav(){
    print('get_nave');
    Store.load_remember();
    Store.loadLogInInfo().then((info) async{
      if(info.email=="non"){
        Get.offAll(()=>Welcome());
      }else{
        final packageInfo = await PackageInfo.fromPlatform();

        MyApi.login(info.email,info.pass,Global.firebase_token,packageInfo.version).then((value) {
          print(value.message);
          if(value.state==200){
            print('home');
            wishListController.getData();
            cartController.getData(null);
            if(Global.customer_type==0 && Global.customer!.isActive == 0){
              Get.offAll(()=>VerificationCode());
            }else{
              Get.offAll(()=>Home());
            }
          }else{
            Get.offAll(()=>Welcome());
          }
        });
        // final packageInfo = await PackageInfo.fromPlatform();
        // MyApi.login(info.email,info.pass,Global.firebase_token,packageInfo.version).then((value) {
        //   print(value.message);
        //   if(value.state==200){
        //     wishListController.getData();
        //     cartController.getData(null);
        //     Store.save_verificat();
        //     Get.offAll(()=>Home());
        //   }else{
        //     //todo check customer type
        //     // Get.offAll(()=>Welcome());
        //     if(Global.customer_type==0){
        //       Get.offAll(()=>VerificationCode());
        //     }else{
        //       Get.offAll(()=>Home());
        //     }
        //
        //   }
        // });
        // Store.load_verificat().then((verify)async {
        //   if(verify){
        //
        //
        //   }else{
        //
        //
        //   }
        // });
      }
    });
  }

  // get_customer_type()async{
  //   var info = await Store.loadLogInInfo();
  //   if(info.email=="non"){
  //     // Get.offAll(()=>Welcome());
  //     return;
  //   }else{
  //     final packageInfo = await PackageInfo.fromPlatform();
  //     var temp = await MyApi.login(info.email,info.pass,Global.firebase_token,packageInfo.version);
  //     return;
  //   }
  // }
}