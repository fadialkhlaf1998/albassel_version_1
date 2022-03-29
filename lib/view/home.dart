import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/category_view_nav_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:albassel_version_1/helper/api.dart';
import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/my_model/category.dart';
import 'package:albassel_version_1/view/cart.dart';
import 'package:albassel_version_1/view/category_view_nav.dart';
import 'package:albassel_version_1/view/chat_view.dart';
import 'package:albassel_version_1/view/product.dart';
import 'package:albassel_version_1/view/products_search.dart';
import 'package:albassel_version_1/view/profile.dart';
import 'package:albassel_version_1/view/wishlist.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:new_version/new_version.dart';

class Home extends StatelessWidget {

  HomeController homeController=Get.put(HomeController());
  CartController cartController=Get.find();
  WishListController wishListController=Get.find();
  CategoryViewNavController categoryViewNavController=Get.put(CategoryViewNavController());
  TextEditingController search_controller = TextEditingController();

  Home(){
    homeController.scaffoldKey = GlobalKey<ScaffoldState>();
  }




  _checkVersion(BuildContext context)async{
    //todo change IDS
    final newVersion = NewVersion(
      iOSId: 'com.Maxart.AlbasselVesrion4',
      androidId: 'com.maxart.albassel_version_1',
    );
    final state = await newVersion.getVersionStatus();
    if(state!.canUpdate){
      newVersion.showUpdateDialog(context: context, versionStatus: state);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(homeController.introController.sliders[0].image);
    // precacheImage(NetworkImage(homeController.introController.sliders[0].image), context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Future.delayed(Duration(milliseconds: 300)).then((value) {
      _checkVersion(context);
    });
    return Obx((){
      return Scaffold(
        key: homeController.scaffoldKey,
        drawer: App.get_drawer(context,homeController),
        floatingActionButton: App.live_chate(),
        backgroundColor: homeController.selected_bottom_nav_bar.value==2?Colors.white:App.midOrange,
        body:
        homeController.selected_bottom_nav_bar.value==0?_home(context)
            :homeController.selected_bottom_nav_bar.value==1?CategoryViewnave()
            :homeController.selected_bottom_nav_bar.value==2?Cart()
            :homeController.selected_bottom_nav_bar.value==3?Wishlist():Profile(),

        bottomNavigationBar: _bottom_nav_bar(context),
      );
    });
  }
  _home(BuildContext context){
    return SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background/background.png"),
                fit: BoxFit.cover
              )
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: homeController.product_loading.value?NeverScrollableScrollPhysics():null,
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
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                          : Column(
                        children: [
                          _header(context),
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
              Positioned(top: 0,child: homeController.product_loading.value?Container(height:MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.grey.withOpacity(0.4),child: Center(child: CircularProgressIndicator()),):Center())
            ],
          ),
        )
    );
  }
  _header(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.35,
      child: Stack(
        children: [
          Container(height: MediaQuery.of(context).size.height*0.35,width: MediaQuery.of(context).size.width,),
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
                                    homeController.openDrawer();
                                  },
                                  icon: Icon(Icons.list,size: 35,color: Colors.white,),
                              ),
                              GestureDetector(
                                onTap: (){
                                  homeController.loading.value=true;
                                 homeController.sub_Category.clear();
                                  homeController.loading.value=false;
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
                  controller.clear();
                  homeController.get_products_by_search(query,context);
                  FocusManager.instance.primaryFocus!.unfocus();
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
            },icon: Icon(Icons.close,color: MediaQuery.of(context).viewInsets.bottom==0?Colors.transparent:Colors.grey,)
                ,))
          ],
        ),
      ),
    );
  }
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
                  offset: Offset(0, 3)
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
                homeController.get_sub_categoryPage(homeController.category[index].id,context);
              },
              child: Padding(padding: EdgeInsets.all(4),
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
                            image: NetworkImage(homeController.category[index].image==null?"https://st2.depositphotos.com/1491329/8004/i/950/depositphotos_80041516-stock-photo-girl-with-healthy-brown-hair.jpg":homeController.category[index].image.replaceAll("localhost", "10.0.2.2")),
                            fit: BoxFit.contain,
                          )
                        ),

                      ),
                      Text(homeController.category[index].title,style: App.textNormal(Colors.black, 8))
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
    return Container(

      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.9+1,
              height: MediaQuery.of(context).size.width * 0.45+1,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        blurRadius: 5,
                        spreadRadius: 0,
                        offset: Offset(0, 3)
                    )
                  ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _slider(context),
                ],
              ),
            ),
            SizedBox(height: 15,),
            _top_category(context),
            // !homeController.product_loading.value&&homeController.sub_Category.isEmpty
            // ?_no_data(context)
            // :_product_list(context),

            _shop_by_brand(context),
            _best_sellers(context),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
  _shop_by_brand(BuildContext context){
    return Padding(
      padding: EdgeInsets.all( MediaQuery.of(context).size.width*0.05),
      child: Column(
        children: [
          Row(
            children: [
              Text(App_Localization.of(context).translate("shop_brand"),style: App.textBlod(Colors.black, 16),)
            ],
          ),
          SizedBox(height: 15,),
          GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3
              ),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: homeController.brands.length,
              itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: (){
                  homeController.get_products_by_brand(homeController.brands[index].id, context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(homeController.brands[index].image.replaceAll("localhost", "10.0.2.2"),),
                      )
                  ),
                ),
              ),
            );
          }),

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
          SizedBox(height: 15,),
           GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:  homeController.bestSellers.length<=6?homeController.bestSellers.length:6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4/6
              ),
              itemBuilder: (context,index){
                return Padding(
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
                                    color: Color(0xffF1F1F1),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 5,right: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(homeController.bestSellers[index].title,style: TextStyle(color: Colors.black,fontSize: 10,),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                        Text(App_Localization.of(context).translate("aed")+" "+homeController.bestSellers[index].price.toStringAsFixed(2),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14,),maxLines: 1,overflow: TextOverflow.ellipsis),
                                        GestureDetector(
                                          onTap: (){
                                            cartController.add_to_cart(homeController.bestSellers[index], 1,context);

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
                          if(homeController.bestSellers[index].favorite.value){
                            homeController.bestSellers[index].favorite.value=false;
                            wishListController.delete_from_wishlist(homeController.bestSellers[index]);
                          }else{
                            homeController.bestSellers[index].favorite.value=true;
                            wishListController.add_to_wishlist(homeController.bestSellers[index],context);
                          }

                        }, icon: Obx((){
                          return Icon(homeController.bestSellers[index].favorite.value?Icons.favorite:Icons.favorite_border,color: App.midOrange,);
                        })))
                      ],
                    ),
                  ),
                );
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
  _top_category(BuildContext context){
    return Padding(
      padding: EdgeInsets.all( MediaQuery.of(context).size.width*0.05),
      child: Column(
        children: [
          Row(
            children: [
              Text(App_Localization.of(context).translate("top_category"),style: App.textBlod(Colors.black, 16),)
            ],
          ),
          SizedBox(height: 0,),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: homeController.topCategory.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: (){
                      homeController.get_sub_categoryPage(homeController.topCategory[index].categoryId,context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        // image: DecorationImage(
                        //   fit: BoxFit.cover,
                        //   image: NetworkImage(homeController.topCategory[index].mainImage.replaceAll("localhost", "10.0.2.2"),),
                        // )
                      ),
                      child: CachedNetworkImage(
                        // placeholder: (context, url) => const CircularProgressIndicator(),
                        imageUrl: homeController.topCategory[index].mainImage,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      // child: Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 20),
                      //     child: Text(homeController.topCategory[index].category,style: App.textBlod(Colors.black,18),),
                      //   ),
                      // ),
                    ),
                  ),
                );
              }),
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
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: homeController.sub_Category.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                    onTap: (){
                      homeController.get_products(homeController.sub_Category[index].id,index,context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      height: MediaQuery.of(context).size.height * 0.2,

                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(homeController.sub_Category[index].image.replaceAll("localhost", "10.0.2.2"),),
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
          SizedBox(height: 30,),
        ],
      ),
    );
  }
  _slider(BuildContext context){
    return Stack(
      children: [
        Container(

          width: MediaQuery.of(context).size.width*0.9,
          height: MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(

            height: MediaQuery.of(context).size.width * 0.45,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            /**slider*/
            child: CarouselSlider(
              items: homeController.slider.map((e){
                return GestureDetector(
                  onTap: (){
                    homeController.go_to_product_page(e);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height:
                    MediaQuery.of(context).size.width * 0.48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // image: DecorationImage(
                        //     image: CachedNetworkImageProvider(e.image),
                        //     fit: BoxFit.cover)
                    ),
                    child: CachedNetworkImage(
                      // placeholder: (context, url) => const CircularProgressIndicator(),
                      imageUrl: e.image,
                        imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                          ),
                        ),
                    ),
                    )
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: 2.0,
                initialPage: 0,
                onPageChanged: (index, reason) {
                  homeController.selder_selected.value=index;
                },
              ),
            ),
          ),
        ),
        /**3 point*/
        Positioned(
          bottom: 10,
          child: Container(
            width: MediaQuery.of(context).size.width*0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:homeController.slider.map((e) {
                return  Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: homeController.selder_selected.value == homeController.slider.indexOf(e)
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
      ],
    );
  }
  _bottom_nav_bar(BuildContext context){
    return Obx((){
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color:  homeController.product_loading.value?Colors.grey.withOpacity(0.4):Colors.transparent,
              image: DecorationImage(
                  image: AssetImage("assets/background/background.png"),
                  fit: BoxFit.cover
              ),
            ),
            child: Container(

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                    ],
                    gradient:App.orangeGradient()
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
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
                    },
                    currentIndex: homeController.selected_bottom_nav_bar.value,

                    showUnselectedLabels: false,
                    showSelectedLabels: false,
                    type: BottomNavigationBarType.fixed,
                    iconSize: 25,
                    selectedItemColor: Colors.grey[800],
                    unselectedItemColor: Colors.white,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        label: "",
                        icon: Icon(Icons.home),
                      ),
                      BottomNavigationBarItem(
                        label: "",
                        icon: SvgPicture.asset("assets/icon/category.svg",color: homeController.selected_bottom_nav_bar==1?Colors.blueGrey[800]:Colors.white,),
                      ),
                      BottomNavigationBarItem(
                        label: "",
                        icon: Icon(Icons.shopping_cart_outlined,),
                      ),
                      BottomNavigationBarItem(
                        label: "",
                        icon: Icon(Icons.favorite_border,),
                      ),
                      BottomNavigationBarItem(
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
              child: CircleAvatar(radius: 8,backgroundColor: cartController.my_order.length==0?Colors.transparent:Colors.red,child: Text(cartController.my_order.length.toString(),style: App.textNormal(cartController.my_order.length==0?Colors.transparent: Colors.white, 10),)),
          )
        ],
      );
    });
  }
  _no_data(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.2,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error,size: 30,),
            SizedBox(height: 10,),
            Text(App_Localization.of(context).translate("no_data"),style: App.textNormal(Colors.black, 20),overflow: TextOverflow.ellipsis,)
          ],
        ),
      ),
    );
  }
  _product_list(BuildContext context){
    return Container(
      child: Center(
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            ///no.of items in the horizontal axis
            crossAxisCount: 3,
            childAspectRatio: 3/4
          ),
            itemCount: homeController.sub_Category.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              // homeController.go_to_product_page(index);

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.16),
                      blurRadius: 5,
                      spreadRadius: 0,
                        offset: Offset(0, 3)
                    )
                  ]
                ),

                child: Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                            image: DecorationImage(
                              image: NetworkImage(homeController.sub_Category[index].image,),
                                fit: BoxFit.cover
                            )
                        ),
                        ),),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
                            child: Container(
                                child: Center(child: Text(homeController.sub_Category[index].title,overflow: TextOverflow.clip,maxLines: 3,style: TextStyle(fontSize: 10,),)),
                            ),
                          ),

                        ],
                      ),),
                  ],
                ),

              ),
            ),
          );
        }),
      ),
    );
  }
}
