import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/controler/product_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProductView extends StatelessWidget {

  HomeController homeController=Get.find();
  WishListController wishListController = Get.find();
  ProductController productController=Get.put(ProductController());
  ProductView(){
    productController.product=homeController.selected_product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        return SafeArea(child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top,
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    _slider(context),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(height: 30,),
                          _title(context),
                          SizedBox(height: 10,),
                          _price(context),
                          SizedBox(height: 10,),
                          _desc(context),
                          SizedBox(height: 10,),
                          _add_to_cart(context)
                        ],
                      ),
                    )

                  ],
              ),
            ),
          ),
        ));
      }),
    );
  }
  _slider(BuildContext context){
    return Stack(
      children: [
        Container(height: MediaQuery.of(context).size.height * 0.4,),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
                boxShadow: [
                  App.box_shadow()
                ]
            ),
            /**slider*/
            child: CarouselSlider(
              items:
              productController.product!.images!.map((e) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius:  BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
                      image: DecorationImage(
                          image: NetworkImage(
                              e.src!),
                          fit: BoxFit.cover)),
                );
              }).toList(),

              options: CarouselOptions(
                autoPlay: productController.product!.images!.length>1?true:false,
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: 1.0,
                initialPage: 0,
                onPageChanged: (index, reason) {
                  productController.selected_slider.value=index;
                },
              ),
            ),
          ),
        ),
        /**3 point*/
        Positioned(
          top: MediaQuery.of(context).size.height * 0.35,
          left: 20,
          child: Container(
            width: MediaQuery.of(context).size.width-20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: productController.product!.images!.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: productController.selected_slider.value == productController.product!.images!.indexOf(e)
                          ? App.orange
                          : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        /**header row*/
        Positioned(
          left: 10,
          top: 10,
          child: Container(
            width: MediaQuery.of(context).size.width-10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                  ],
                ),
                IconButton(onPressed: (){
                  productController.favorite(productController.product!);
                }, icon: Icon(productController.product!.is_favoirite.value?Icons.favorite:Icons.favorite_border,color: App.orange,))
              ],
            )
          ),
        )
      ],
    );
  }
  _title(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),
          child: Container(
            width: MediaQuery.of(context).size.width*0.9,
            child: Text(productController.product!.title!,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,overflow: TextOverflow.clip,),textAlign: TextAlign.left,),
          ),
        ),
      ],
    );
  }
  _price(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(App_Localization.of(context).translate("aed")+" "+productController.product!.variants!.first.price!,style: TextStyle(color: App.orange,fontSize: 24,overflow: TextOverflow.clip,),textAlign: TextAlign.center,),
            ],
          ),
        )
      ],
    );
  }
  _desc(BuildContext context){
    return  Padding(
      padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),
      child: Column(
        children: [
          Row(
            children: [
              Text(App_Localization.of(context).translate("desc"),style: App.textBlod(Colors.black, 18),textAlign: TextAlign.left,)
            ],
          ),
          Html(data: productController.product!.bodyHtml!),
        ],
      ),
    );
  }
  _add_to_cart(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),
            child: GestureDetector(
              onTap: (){
                productController.add_to_cart();
                App.sucss_msg(context, App_Localization.of(context).translate("cart_msg"));
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width*0.3,
                decoration: BoxDecoration(
                  color: App.orange,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: Text(App_Localization.of(context).translate("add_cart"),style: App.textNormal(Colors.white, 14),),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width*0.3,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){
                      productController.increase();
                    }, icon: Icon(Icons.add,)),
                    Text(productController.cart_count.toString()),
                    IconButton(onPressed: (){
                      productController.decrease();
                    }, icon: Icon(Icons.remove,))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
