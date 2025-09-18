// ignore_for_file: must_be_immutable, non_constant_identifier_names, unrelated_type_equality_checks

import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/view/home.dart';
import 'package:albassel_version_1/view/products_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoryView extends StatelessWidget {

  HomeController homeController=Get.find();
  CartController cartController=Get.find();
  WishListController wishListController=Get.find();
  TextEditingController search_controller = TextEditingController();

  CategoryView({Key? key}) : super(key: key);


  // CategoryView(List<SubCategory> sub_Category){
  //   homeController.sub_Category.addAll(sub_Category);
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      floatingActionButton: App.live_chate(),
      backgroundColor: App.midOrange,
      body: Obx((){
        return _home(context);
      }),
      bottomNavigationBar: _bottom_nav_bar(context),
    );
  }
  _home(BuildContext context){
    return SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background/background.png"),
                  fit: BoxFit.cover
              )
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                physics:  homeController.product_loading.value?const NeverScrollableScrollPhysics():null,
                child: Stack(
                  children: [
                    Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child:homeController.loading.value?

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.transparent,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                          : Column(
                        children: [
                          // _header(context),
                          SizedBox(height: MediaQuery.of(context).size.height*0.35,),
                          _body(context)
                        ],
                      ),
                    ),
                    // Positioned(
                    //   top: 0,
                    //   child: homeController.product_loading.value? Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.height,
                    //   color: Colors.grey.withOpacity(0.75),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       CircularProgressIndicator()
                    //     ],
                    //   ),
                    // ):Center(),)
                  ],
                ),
              ),
              Positioned(top: 0,child:_header(context)),
              Positioned(top: 0,child: homeController.product_loading.value?Container(height:MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.grey.withOpacity(0.4),child: const Center(child: CircularProgressIndicator()),):const Center())
            ],
          ),
        )
    );
  }
  _header(BuildContext context){
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.35,
        child: Stack(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.35,width: MediaQuery.of(context).size.width,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.25,
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
                                  icon: const Icon(Icons.arrow_back_ios,size: 35,color: Colors.white,),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Get.back();
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
            Positioned(
              bottom: MediaQuery.of(context).size.height*0.05,
              child: _categories_list(context),
            )
          ],
        )
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
              keyboardType: TextInputType.none,
              onTap: ()async{
                final result = await showSearch(
                    context: context,
                    delegate: SearchTextField(suggestion_list: Global.suggestion_list,homeController: homeController));
                homeController.get_products_by_search(result!, context);
              },
              onSubmitted: (query){
                if(query.isNotEmpty){
                  search_controller.clear();
                  homeController.get_products_by_search(query,context);
                  FocusManager.instance.primaryFocus!.unfocus();
                }

                // if(query.isNotEmpty){
                //   controller.clear();
                //   homeController.get_products_by_search(query,context);
                //   FocusManager.instance.primaryFocus!.unfocus();
                // }
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
  // _search(BuildContext context,TextEditingController controller){
  //   return Container(
  //
  //     width: MediaQuery.of(context).size.width*0.9,
  //     decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(5)
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.only(left: 8,right: 8),
  //       child: TextField(
  //         style: TextStyle(color: Colors.grey,fontSize: 14),
  //         textAlignVertical: TextAlignVertical.top,
  //         controller: controller,
  //         // onChanged: (query){
  //         //   homeController.search(query);
  //         // },
  //         // onSubmitted: homeController.on_submit(),
  //         onEditingComplete: (){
  //           print('****************');
  //         },
  //         onSubmitted: (query){
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
  _categories_list(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:  MediaQuery.of(context).size.width*0.05),
      child: Container(
        width: MediaQuery.of(context).size.width*0.9,
        height: MediaQuery.of(context).size.height*0.1,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.16),
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: const Offset(0, 3)
              )
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: ListView.builder(
              controller: homeController.scrollController,
              // reverse: true,
              scrollDirection: Axis.horizontal,
              itemCount: homeController.category.length,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    homeController.selected_category.value=index;
                    homeController.get_sub_category(homeController.category[index].id,context);
                  },
                  child: Padding(padding: const EdgeInsets.all(4),
                    child: Container(
                        width: (MediaQuery.of(context).size.width*0.9)/5-10,
                        height: MediaQuery.of(context).size.height*0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: (MediaQuery.of(context).size.width*0.9)/5-10,
                              height: MediaQuery.of(context).size.height*0.08-10,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(homeController.category[index].image),
                                    fit: BoxFit.contain,
                                  )
                              ),

                            ),
                            Text(homeController.category[index].getTitle(),style: App.textNormal(homeController.selected_category.value==index?App.midOrange:Colors.black, 8))
                          ],
                        )
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  _body(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: [
          homeController.sub_Category_category_view.isNotEmpty?
          _sub_category(context)
              :SizedBox(
            height: MediaQuery.of(context).size.height*0.4,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error,size: 50,color: App.midOrange,),
                const SizedBox(height: 10,),
                Text(App_Localization.of(context).translate("empty_elm"),style: App.textNormal(Colors.black, 20),),

              ],
            ),
          ),
          // _top_category(context),
          // SizedBox(height: 20,),
          _best_sellers(context),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }

  _best_sellers(BuildContext context){
    return Padding(
      padding: EdgeInsets.all( MediaQuery.of(context).size.width*0.05),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(App_Localization.of(context).translate("best_sellers"),style: App.textBlod(Colors.black, 16),),
              GestureDetector(
                onTap: (){
                  Get.to(()=>ProductsSearchView(homeController.bestSellers, ""));
                },
                child: Text(App_Localization.of(context).translate("see_all"),style: App.textNormal(Colors.black, 14),),
              )
            ],
          ),
          const SizedBox(height: 15,),
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:  homeController.bestSellers.length<=6?homeController.bestSellers.length:6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4/6
              ),
              itemBuilder: (context,index){
                return Obx(()=>Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: (){
                      homeController.go_to_product(index);
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
                                          image: NetworkImage(homeController.bestSellers[index].image),
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
                                        Text(homeController.bestSellers[index].getTitle(),style: const TextStyle(color: Colors.black,fontSize: 10,),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                        // Text(App_Localization.of(context).translate("aed")+" "+homeController.bestSellers[index].price.toStringAsFixed(2),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14,),maxLines: 1,overflow: TextOverflow.ellipsis),
                                        App.price(context, homeController.bestSellers[index].price, homeController.bestSellers[index].offerPrice),
                                        GestureDetector(
                                          onTap: ()async{
                                            homeController.bestSellers[index].cartLoading(true);
                                            await cartController.addOrUpdateCart(homeController.bestSellers[index].id, null, 1, context);
                                            homeController.bestSellers[index].cartLoading(false);
                                          },
                                          child:
                                          homeController.bestSellers[index].cartLoading.value
                                              ?App.cartBtnLoading()
                                              :Container(
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
                        Positioned(child: IconButton(onPressed: ()async{
                          homeController.bestSellers[index].wishlistLoading(true);
                          if(homeController.bestSellers[index].favorite.value){
                            homeController.bestSellers[index].favorite.value=false;
                            await wishListController.deleteFromWishlist(homeController.bestSellers[index].id,context);
                          }else{
                            homeController.bestSellers[index].favorite.value=true;
                            await wishListController.addToWishlist(homeController.bestSellers[index].id,context);
                          }
                          homeController.bestSellers[index].wishlistLoading(false);
                        }, icon: Obx((){
                          return homeController.bestSellers[index].wishlistLoading.value
                              ?CircularProgressIndicator()
                              :Icon(homeController.bestSellers[index].favorite.value?Icons.favorite:Icons.favorite_border,color: App.midOrange,);
                        })))
                      ],
                    ),
                  ),
                ));
              }),
          // GridView.builder(
          //     physics: NeverScrollableScrollPhysics(),
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 3,
          //         childAspectRatio: 9/10
          //     ),
          //     shrinkWrap: true,
          //     itemCount: homeController.bestSellers.length<=6?homeController.bestSellers.length:6,
          //     itemBuilder: (context,index){
          //       return Padding(
          //         padding: const EdgeInsets.all(10.0),
          //         child: GestureDetector(
          //           onTap: (){
          //             homeController.go_to_product(index);
          //           },
          //           child: Container(
          //             width: MediaQuery.of(context).size.width*0.9,
          //             height: MediaQuery.of(context).size.height * 0.2,
          //             decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.circular(10),
          //
          //             ),
          //             child: Column(
          //               children: [
          //                 Expanded(
          //                   flex:2,
          //                   child: Container(
          //                     width: MediaQuery.of(context).size.width*0.9,
          //                     height: MediaQuery.of(context).size.height * 0.2,
          //                     decoration: BoxDecoration(
          //                         color: Colors.white,
          //                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
          //                         image: DecorationImage(
          //                           fit: BoxFit.contain,
          //                           image: NetworkImage(homeController.bestSellers[index].image.replaceAll("localhost", "10.0.2.2"),),
          //                         )
          //                     ),
          //
          //                   ),
          //                 ),
          //                 Expanded(
          //                   flex:1,
          //                   child: Container(
          //                     decoration: BoxDecoration(
          //                       color: Colors.grey[300],
          //                       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
          //                     ),
          //                     child: Padding(
          //                       padding: const EdgeInsets.only(top: 2,bottom: 2,left: 5,right: 5),
          //                       child: Container(
          //                         width: MediaQuery.of(context).size.width*0.9,
          //                         height: MediaQuery.of(context).size.height * 0.2,
          //                         decoration: BoxDecoration(
          //
          //                           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
          //                         ),
          //                       child: Column(
          //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                         children: [
          //                           Text(homeController.bestSellers[index].title,style: App.textNormal(Colors.black, 8),),
          //                           Row(
          //                             mainAxisAlignment: MainAxisAlignment.center,
          //                             children: [
          //                               Text(App_Localization.of(context).translate("aed")+" "+homeController.bestSellers[index].price.toString(),style: App.textBlod(Colors.black, 8),),
          //                             ],
          //                           )
          //                         ],
          //                       )
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       );
          //     }),

        ],
      ),
    );
  }
  _sub_category(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric( horizontal: MediaQuery.of(context).size.width*0.05),
      child: Column(
        children: [

          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: homeController.sub_Category_category_view.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                    onTap: (){
                      if(homeController.makeup){
                        homeController.get_productsMakeup(homeController.sub_Category_category_view[index].id,0,context);
                      }else{
                        homeController.get_products(homeController.sub_Category_category_view[index].id,index,context);

                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      height: MediaQuery.of(context).size.height * 0.2,

                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(homeController.sub_Category_category_view[index].image.replaceAll("localhost", "10.0.2.2"),),
                          )
                      ),
                      // child: Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 20),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.end,
                      //       children: [
                      //         Text(homeController.sub_Category[index].title,style: App.textBlod(Colors.black,18),),
                      //         SizedBox(width: 15,),
                      //         Icon(Icons.arrow_forward_ios)
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                );
              }),
          const SizedBox(height: 10,),
        ],
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
            child: Global.cartCircleCount(),
          )
        ],
      );
    });
  }

}
