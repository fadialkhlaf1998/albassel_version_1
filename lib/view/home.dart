import 'package:albassel_version_1/helper/api.dart';
import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/view/cart.dart';
import 'package:albassel_version_1/view/product.dart';
import 'package:albassel_version_1/view/profile.dart';
import 'package:albassel_version_1/view/wishlist.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Home extends StatelessWidget {

  HomeController homeController=Get.put(HomeController());
  TextEditingController search_controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeController.scaffoldKey,
      drawer: App.get_drawer(context,homeController),
      backgroundColor: Colors.white,
      body: Obx((){
        return homeController.selected_bottom_nav_bar.value==0?_home(context)
            :homeController.selected_bottom_nav_bar.value==1?Cart()
            :homeController.selected_bottom_nav_bar.value==2?Wishlist():Profile();
      }),
      bottomNavigationBar: _bottom_nav_bar(context),
    );
  }
  _home(BuildContext context){
    return SafeArea(
        child: SingleChildScrollView(
          physics: homeController.product_loading.value?NeverScrollableScrollPhysics():null,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child:homeController.loading.value?

                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
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
              Positioned(
                top: 0,
                child: homeController.product_loading.value? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.grey.withOpacity(0.75),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    CircularProgressIndicator()
                  ],
                ),
              ):Center(),)
            ],
          ),
        )
    );
  }
  _header(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.35,
      color: Colors.white,
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
                                  icon: Icon(Icons.list,size: 30,color: Colors.white,),
                              ),
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/logo/logo.png")
                                  )
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
      height: 35,
      width: MediaQuery.of(context).size.width*0.9,
      decoration: BoxDecoration(
        color: Colors.white,  
        borderRadius: BorderRadius.circular(5)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8,right: 8),
        child: TextField(
          style: TextStyle(color: Colors.grey,fontSize: 14),
          controller: controller,
          onChanged: (query){
            homeController.search(query);
          },
          // onSubmitted: homeController.on_submit(),
          onSubmitted: (query){
            if(query.isEmpty){
              search_controller.text="";
              homeController.on_submit();
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
            hintStyle: TextStyle(color: Colors.grey,fontSize: 14)
          ),
          textAlignVertical: TextAlignVertical.center,
        ),
      ),
    );
  }


  _categories_list(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),
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
              scrollDirection: Axis.horizontal,
              itemCount: homeController.collections.length,
              itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                search_controller.text="";
                homeController.on_submit();
                homeController.get_product_by_collection(homeController.collections[index].id!);
              },
              child: Padding(padding: EdgeInsets.all(4),
                child: Container(
                  width: MediaQuery.of(context).size.height*0.10,
                  height: MediaQuery.of(context).size.height*0.08,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),

                    ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height*0.10,
                        height: MediaQuery.of(context).size.height*0.08-10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(homeController.collections[index].image==null?"https://st2.depositphotos.com/1491329/8004/i/950/depositphotos_80041516-stock-photo-girl-with-healthy-brown-hair.jpg":homeController.collections[index].image!.src!),
                            fit: BoxFit.contain,
                          )
                        ),

                      ),
                      Text(homeController.collections[index].title!,style: App.textNormal(Colors.black, 8))
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
          Container(
            width: MediaQuery.of(context).size.width*0.9+1,
            height: MediaQuery.of(context).size.height * 0.2+1,
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
          SizedBox(height: 30,),
          !homeController.product_loading.value&&homeController.products.isEmpty 
          ?_no_data(context)
          :_product_list(context),

          SizedBox(height: 30,)
        ],
      ),
    );
  }
  _slider(BuildContext context){
    return Stack(
      children: [
        Container(

          width: MediaQuery.of(context).size.width*0.9,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),

          ),
          child: Container(

            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            /**slider*/
            child: CarouselSlider(
              items: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/slider/slider_0.png"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height:
                  MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/slider/slider_1.png"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height:
                  MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/slider/slider_2.png"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  height:
                  MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/slider/slider_3.png"),
                          fit: BoxFit.cover)),
                ),
              ],
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
          top: MediaQuery.of(context).size.height * 0.17,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: homeController.selder_selected.value == 0
                            ? App.orange
                            : Colors.grey,
                        shape: BoxShape.circle,
                       ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: homeController.selder_selected.value == 1
                            ? App.orange
                            : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: homeController.selder_selected.value == 2
                            ? App.orange
                            : Colors.grey,
                        shape: BoxShape.circle,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: homeController.selder_selected.value == 3
                            ? App.orange
                            : Colors.grey,
                        shape: BoxShape.circle,

                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  _bottom_nav_bar(BuildContext context){
    return Obx((){
      return Container(
        color:  homeController.product_loading.value?Colors.grey.withOpacity(0.75):Colors.transparent,
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
                  // BottomNavigationBarItem(
                  //   label: "",
                  //   icon: Icon(Icons.search,),
                  // ),
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
            itemCount: homeController.products.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              homeController.go_to_product_page(index);

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
                              image: NetworkImage(homeController.products[index].image!.src!,),
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
                                child: Center(child: Text(homeController.products[index].title!,overflow: TextOverflow.clip,maxLines: 3,style: TextStyle(fontSize: 10,),)),
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
