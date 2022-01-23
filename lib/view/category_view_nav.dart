import 'dart:async';

import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/category_view_nav_controller.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/controler/products_controller.dart';
import 'package:albassel_version_1/controler/products_search_controller.dart';
import 'package:albassel_version_1/model/product.dart';
import 'package:albassel_version_1/my_model/my_product.dart';
import 'package:albassel_version_1/my_model/sub_category.dart';
import 'package:albassel_version_1/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryViewnave extends StatelessWidget {

  CategoryViewNavController productsController = Get.find();
  int selected_sub_category=0;
  HomeController homeController = Get.find();
  ScrollController scrollController = ScrollController();
  TextEditingController search_controller = TextEditingController();

  CategoryViewnave(){

    //double.parse((100*(this.selected_sub_category+1)).toString())
    // After 1 second, it takes you to the bottom of the ListView
    Timer(
      Duration(milliseconds: 500),
          () =>scrollController.animateTo(
        double.parse((150*(productsController.selected_sub_category.value)).toString()),
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

       return Obx((){
          return SafeArea(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background/background.png"),
                        fit: BoxFit.cover
                    )
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      // physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          _header(context),
                          _category(context),
                          _sub_category(context),
                          productsController.my_products.isEmpty?
                          Container(height:MediaQuery.of(context).size.height*0.8,color: Colors.transparent,child: Center(child: Column(
                            children: [
                              SizedBox(height: 50,),
                              Icon(Icons.error,size: 50,color: App.midOrange,),
                              SizedBox(height: 10,),
                              Text(App_Localization.of(context).translate("empty_elm"),style: App.textNormal(Colors.black, 20),)
                            ],
                          )),)
                              :Column(
                            children: [
                              _products(context),
                              SizedBox(height: 30,)
                            ],
                          )

                        ],
                      ),
                    ),
                    Positioned(top: 0,child: homeController.product_loading.value || productsController.loading.value?Container(height:MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.grey.withOpacity(0.4),child: Center(child: CircularProgressIndicator()),):Center())
                  ],
                ),
              ));
        });

  }
  _header(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.2,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.20,
            decoration: BoxDecoration(
                gradient: App.orangeGradient()
            ),

            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.18,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: (){
                              // Get.back();
                            },
                            icon: Icon(Icons.arrow_back_ios,size: 30,color: Colors.transparent,),
                          ),
                          GestureDetector(
                            onTap: (){
                              homeController.selected_bottom_nav_bar.value=0;
                            },
                            child: Container(
                              width: 70,
                              height: 70,

                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/logo/logo.png")
                                  )
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: (){
                            },
                            icon: Icon(Icons.list,size: 30,color: Colors.transparent,),
                          ),
                        ],
                      ),
                      _search(context,search_controller)
                    ],
                  ),
                )
              ],
            ),

          ),

        ],
      ),
    );
  }
  _search(BuildContext context,TextEditingController controller){
    return Container(

      width: MediaQuery.of(context).size.width*0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8,right: 8),
        child: Stack(
          children: [
            TextField(
              style: TextStyle(color: Colors.grey,fontSize: 14),
              textAlignVertical: TextAlignVertical.top,
              controller: controller,
              // onChanged: (query){
              //   homeController.search(query);
              // },
              // onSubmitted: homeController.on_submit(),
              onEditingComplete: (){
                print('****************');
              },

              onSubmitted: (query){
                if(query.isNotEmpty){
                  search_controller.text="";
                  homeController.get_products_by_search(query,context);
                }
              },
              decoration: InputDecoration(

                  icon: Icon(Icons.search),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)
                  ),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)
                  ),

                  hintText: App_Localization.of(context).translate("search"),
                  hintStyle: TextStyle(color: Colors.grey,fontSize: 11)
              ),
            ),
            Positioned(
                right: Global.lang_code=="en"?0:null,
                left: Global.lang_code=="en"?null:0,
                child: IconButton(onPressed: (){
                  controller.clear();
                  FocusManager.instance.primaryFocus!.unfocus();
                },icon: Icon(Icons.close,color: MediaQuery.of(context).viewInsets.bottom==0?Colors.transparent:Colors.grey,),))
          ],
        ),
      ),
    );
  }
  // _search(BuildContext context,TextEditingController controller){
  //   return Container(
  //     width: MediaQuery.of(context).size.width*0.9,
  //     decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(5)
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.only(left: 8,right: 8),
  //       child: TextField(
  //         textAlignVertical: TextAlignVertical.top,
  //         style: TextStyle(color: Colors.grey,fontSize: 14),
  //         controller: controller,
  //         onChanged: (query){
  //           homeController.search(query);
  //         },
  //         // onSubmitted: homeController.on_submit(),
  //         onSubmitted: (query){
  //           // if(query.isEmpty){
  //           //   search_controller.text="";
  //           //   homeController.on_submit();
  //           // }
  //           if(query.isNotEmpty){
  //             search_controller.text="";
  //             homeController.get_products_by_search(query,context);
  //           }
  //         },
  //         decoration: InputDecoration(
  //           icon: Icon(Icons.search),
  //           enabledBorder: const UnderlineInputBorder(
  //               borderSide: BorderSide(color: Colors.transparent)
  //           ),
  //           focusedBorder: const UnderlineInputBorder(
  //               borderSide: BorderSide(color: Colors.transparent)
  //           ),
  //
  //             hintText: App_Localization.of(context).translate("search"),
  //             hintStyle: TextStyle(color: Colors.grey,fontSize: 11)
  //         ),
  //       ),
  //     ),
  //   );
  // }
  _category(BuildContext context){
    return Container(
      height: 40,
      color: Colors.white,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productsController.categories.length,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(left: 0,right: 0),
              child: GestureDetector(
                onTap: (){
                  productsController.update_sub_category(index);
                },
                child: Container(
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(productsController.categories[index].title,style: App.textNormal(Colors.black, 12),),
                      productsController.selected_category.value==index?Container(color: App.midOrange,height: 2,):Container(color: Colors.transparent,height: 2,)
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
  _sub_category(BuildContext context){
    return Container(
      height: 40,
      color: Colors.white,
      child: ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: productsController.sub_categories.length,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: GestureDetector(
                onTap: (){
                  productsController.update_product(index);
                },
                child: Container(
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(productsController.sub_categories[index].title,style: App.textNormal(Colors.black, 12),),
                      productsController.selected_sub_category.value==index?Container(color: App.midOrange,height: 2,):Container(color: Colors.transparent,height: 2,)
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
  _products(BuildContext context){
    return Container(
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          // physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: productsController.my_products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4/6
          ),
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: (){
                  productsController.go_to_product(index);
                },
                child: Stack(
                  children: [
                    Container(
                      decoration:BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(productsController.my_products[index].image),
                                      fit: BoxFit.contain
                                  )
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffF1F1F1),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 5,right: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(productsController.my_products[index].title,style: TextStyle(color: Colors.black,fontSize: 10,),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                    Text(App_Localization.of(context).translate("aed")+" "+productsController.my_products[index].price.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14,),maxLines: 1,overflow: TextOverflow.ellipsis),
                                    GestureDetector(
                                      onTap: (){
                                        productsController.cartController.add_to_cart(productsController.my_products[index], 1);
                                        App.sucss_msg(context, App_Localization.of(context).translate("cart_msg"));
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width*0.4,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color:App.midOrange)
                                        ),
                                        child: Center(
                                          child: Text(App_Localization.of(context).translate("add_cart"),style: App.textNormal(App.midOrange, 12),),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(child: IconButton(onPressed: (){
                      if(productsController.my_products[index].favorite.value){
                        productsController.my_products[index].favorite.value=false;
                        productsController.wishListController.delete_from_wishlist(productsController.my_products[index]);
                      }else{
                        productsController.my_products[index].favorite.value=true;
                        productsController.wishListController.add_to_wishlist(productsController.my_products[index],context);
                      }

                    }, icon: Obx((){
                      return Icon(productsController.my_products[index].favorite.value?Icons.favorite:Icons.favorite_border,color: App.midOrange,);
                    })))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
