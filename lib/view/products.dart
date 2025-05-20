// ignore_for_file: must_be_immutable, non_constant_identifier_names, unrelated_type_equality_checks

import 'dart:async';
import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/controler/products_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:albassel_version_1/my_model/my_product.dart';
import 'package:albassel_version_1/my_model/sub_category.dart';
import 'package:albassel_version_1/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductsView extends StatelessWidget {

  ProductsController productsController = Get.put(ProductsController());
  WishListController wishListController = Get.find();
  CartController cartController = Get.find();
  List<SubCategory> sub_categories;
  List<MyProduct> my_products;
  int selected_sub_category=0;
  HomeController homeController = Get.find();
  ScrollController scrollController = ScrollController();
  TextEditingController search_controller = TextEditingController();

  ProductsView(this.sub_categories, this.my_products,this.selected_sub_category, {Key? key}) : super(key: key){
    productsController.my_products.addAll(my_products);
    productsController.sub_categories.addAll(sub_categories);
    productsController.selected_sub_category.value=selected_sub_category;
    if(productsController.my_products.length>10){
      productsController.productCountShow.value = 10;
    }else{
      productsController.productCountShow.value = productsController.my_products.length;
    }

    // After 1 second, it takes you to the bottom of the ListView
    Timer(
      const Duration(milliseconds: 500),
          () =>scrollController.animateTo(
            double.parse((150*(selected_sub_category)).toString()),
            duration: const Duration(seconds: 1),
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
    return Scaffold(
      floatingActionButton: App.live_chate(),
backgroundColor: App.midOrange,
      bottomNavigationBar: _bottom_nav_bar(context),
      body:  Obx((){
        return SafeArea(
            child: Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/background/background.png"),
                      fit: BoxFit.cover
                  )
              ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    // _header(context),
                    SizedBox(height: MediaQuery.of(context).size.height*0.2+40,),
                    // _sub_category(context),
                        productsController.my_products.isEmpty?
                        Container(height:MediaQuery.of(context).size.height*0.8,color: Colors.transparent,child: Center(child: Column(
                          children: [
                            const SizedBox(height: 50,),
                            Icon(Icons.error,size: 50,color: App.midOrange,),
                            const SizedBox(height: 10,),
                            Text(App_Localization.of(context).translate("empty_elm"),style: App.textNormal(Colors.black, 20),)
                          ],
                        )),)
                        :Column(
                          children: [
                            _products(context),
                            showMoreBtn(context),
                            const SizedBox(height: 30,)
                          ],
                        )

                  ],
                ),
              ),
              Positioned(child: Column(
                children: [
                  _header(context),
                  _sub_category(context),
                ],
              )),

              Positioned(top: 0,child: productsController.loading.value?Container(height:MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.grey.withOpacity(0.4),child: const Center(child: CircularProgressIndicator()),):const Center())
            ],
          ),
        ));
      }),
    );
  }

  showMoreBtn(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width,
      child: Center(
        child:  productsController.productCountShow.value==productsController.my_products.length?Center():GestureDetector(
          onTap: (){
            productsController.showMore();
          },
          child: Container(
            width: 90,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: App.orange
            ),
            child: Center(child: Text(App_Localization.of(context).translate("show_more"),style: TextStyle(fontSize: 12,color: Colors.white),),),
          ),
        ),
      ),
    );
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
                                Get.back();
                              },
                              icon: const Icon(Icons.arrow_back_ios,size: 30,color: Colors.white,),
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.offAll(()=>Home());
                              },
                              child: Container(
                                width: 70,
                                height: 70,

                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/logo/logo.png")
                                    )
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                              },
                              icon: const Icon(Icons.list,size: 30,color: Colors.transparent,),
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
              style: const TextStyle(color: Colors.grey,fontSize: 14),
              textAlignVertical: TextAlignVertical.top,
              controller: controller,
              // onChanged: (query){
              //   homeController.search(query);
              // },
              // onSubmitted: homeController.on_submit(),
              onEditingComplete: (){
              },

              onSubmitted: (query){
                if(query.isNotEmpty){
                  // search_controller.text="";
                  productsController.get_products_by_search(query,context);
                }
              },
              keyboardType: TextInputType.none,
              onTap: ()async{
                final result = await showSearch(
                    context: context,
                    delegate: SearchTextField(suggestion_list: Global.suggestion_list,homeController: homeController));
                productsController.get_products_by_search(result!, context);
              },
              decoration: InputDecoration(

                  icon: const Icon(Icons.search),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)
                  ),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)
                  ),

                  hintText: App_Localization.of(context).translate("search"),
                  hintStyle: const TextStyle(color: Colors.grey,fontSize: 11)
              ),
            ),
            Positioned(
                right: Global.lang_code=="en"?0:null,
                left: Global.lang_code=="en"?null:0,
                child: IconButton(onPressed: (){
                  controller.clear();
                  FocusManager.instance.primaryFocus!.unfocus();
                },icon: Icon(Icons.close,color:MediaQuery.of(context).viewInsets.bottom==0?Colors.transparent:Colors.grey,),))
          ],
        ),
      ),
    );
  }

  _bottom_nav_bar(BuildContext context){
    return Obx((){
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color:  homeController.product_loading.value?Colors.grey.withOpacity(0.4):Colors.transparent,
              image: const DecorationImage(
                  image: AssetImage("assets/background/background.png"),
                  fit: BoxFit.cover
              ),
            ),
            child: Container(

                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                    boxShadow: const [
                      BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                    ],
                    gradient:App.orangeGradient()
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    onTap: (index){
                      if(index==0){
                        homeController.loading.value=true;
                        homeController.sub_Category.clear();
                        homeController.loading.value=false;
                      }
                      homeController.selected_bottom_nav_bar.value=index;
                      Get.back();
                      Get.back();
                    },
                    currentIndex: homeController.selected_bottom_nav_bar.value,

                    showUnselectedLabels: false,
                    showSelectedLabels: false,
                    type: BottomNavigationBarType.fixed,
                    iconSize: 25,
                    selectedItemColor: Colors.grey[800],
                    unselectedItemColor: Colors.white,
                    items: <BottomNavigationBarItem>[
                      const BottomNavigationBarItem(
                        label: "",
                        icon: Icon(Icons.home),
                      ),
                      BottomNavigationBarItem(
                        label: "",
                        icon: SvgPicture.asset("assets/icon/category.svg",color: homeController.selected_bottom_nav_bar==1?Colors.blueGrey[800]:Colors.white,),
                      ),
                      const BottomNavigationBarItem(
                        label: "",
                        icon: Icon(Icons.shopping_cart_outlined,),
                      ),
                      const BottomNavigationBarItem(
                        label: "",
                        icon: Icon(Icons.favorite_border,),
                      ),
                      const BottomNavigationBarItem(
                        label: "",
                        icon: Icon(Icons.person,),
                      ),
                    ],
                  ),
                )
            ),
          ),
          Positioned(
            top: 5,
            left: Global.lang_code=="en"?MediaQuery.of(context).size.width*0.5-26:null,
            right: Global.lang_code=="ar"?MediaQuery.of(context).size.width*0.5-26:null,
            child: CircleAvatar(radius: 8,backgroundColor: cartController.my_order.isEmpty?Colors.transparent:Colors.red,child: Text(cartController.my_order.length.toString(),style: App.textNormal(cartController.my_order.isEmpty?Colors.transparent: Colors.white, 10),)),
          )
        ],
      );
    });
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
  //           if(query.isEmpty){
  //             search_controller.text="";
  //             homeController.on_submit();
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
          padding: const EdgeInsets.only(left: 0,right: 0),
          child: GestureDetector(
            onTap: (){
              productsController.update_product(index);
            },
            child: SizedBox(
              width: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(homeController.sub_Category[index].title,style: App.textNormal(Colors.black, 12),),
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
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: productsController.productCountShow.value,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                              color: const Color(0xffF1F1F1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5,right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(productsController.my_products[index].title,style: const TextStyle(color: Colors.black,fontSize: 10,),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                  // Text(App_Localization.of(context).translate("aed")+" "+productsController.my_products[index].price.toStringAsFixed(2),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14,),maxLines: 1,overflow: TextOverflow.ellipsis),
                                  App.price(context, productsController.my_products[index].price, productsController.my_products[index].offer_price),
                                  GestureDetector(
                                    onTap: (){
                                      cartController.add_to_cart(productsController.my_products[index], 1,context);
                                      // App.sucss_msg(context, App_Localization.of(context).translate("cart_msg"));
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
                      wishListController.delete_from_wishlist(productsController.my_products[index]);
                    }else{
                      productsController.my_products[index].favorite.value=true;
                      wishListController.add_to_wishlist(productsController.my_products[index],context);
                    }

                  }, icon: Obx((){
                    return Icon(productsController.my_products[index].favorite.value?Icons.favorite:Icons.favorite_border,color: App.midOrange,);
                  }))),
                  App.outOfStock(productsController.my_products[index].availability)
                ],
              ),
            ),
          );
        });
  }
}
