// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/cart_controller.dart';
import 'package:albassel_version_1/controler/home_controller.dart';
import 'package:albassel_version_1/controler/product_controller.dart';
import 'package:albassel_version_1/controler/wish_list_controller.dart';
import 'package:albassel_version_1/helper/api_v2.dart';
import 'package:albassel_version_1/model_v2/product.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/view/cashew_details.dart';
import 'package:albassel_version_1/view/custom_web_view.dart';
import 'package:albassel_version_1/view/image_show.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:albassel_version_1/view/sign_in.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class ProductView extends StatelessWidget {

  HomeController homeController=Get.find();
  WishListController wishListController = Get.find();
  CartController cartController = Get.find();
  ProductController productController=Get.put(ProductController());
  TextEditingController reviewController = TextEditingController();


  ProductView(int product_id, {Key? key}) : super(key: key){
    productController.getData(product_id);
  }

  go_to_product(int index){
    productController.getData(productController.myProduct!.recently[index].id);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx((){
        return SafeArea(child: SingleChildScrollView(

          child: SizedBox(
            width: MediaQuery.of(context).size.width,

            child: productController.loading.value?
            Container(color: Colors.white,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,child: const Center(child: CircularProgressIndicator(),))
                :SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                  children: [
                    _slider(context),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          const SizedBox(height: 30,),
                          _title(context),
                          const SizedBox(height: 10,),
                          _price_avalibilty(context),
                          productController.myProduct!.options.isEmpty?Center():
                          Column(
                            children: [
                              const SizedBox(height: 10,),
                              Container(
                                width: Get.width*0.9,
                                height: 100,
                                child: Container(
                                  width: Get.width,
                                  child: ListView.builder(
                                    itemCount: productController.myProduct!.options.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context,index){
                                      var option = productController.myProduct!.options[index];
                                      return GestureDetector(
                                        onTap: (){

                                          productController.loading(true);
                                          productController.selected_slider(0);
                                          if(productController.selectedOptions!=null&&productController.selectedOptions!.id == option.id){
                                            productController.selectedOptions = null;
                                          }else{
                                            productController.selectedOptions = option;
                                          }
                                          productController.loading(false);
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(image: NetworkImage(option.mainImage!),fit: BoxFit.cover),
                                                border: Border.all(color:  productController.selectedOptions!=null&&productController.selectedOptions!.id== option.id?App.midOrange:Colors.grey),
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                            ),
                                            Text(option.getTitle(),style: App.textBlod(productController.selectedOptions!=null&&productController.selectedOptions!.id== option.id?App.midOrange:Colors.grey, 14),)
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          _desc(context),
                          const SizedBox(height: 10,),
                          _add_to_cart(context),
                          const SizedBox(height: 10,),
                          _rate(context),
                          const SizedBox(height: 10,),
                          _add_review(context),
                          const SizedBox(height: 10,),
                          _review(context),
                          const SizedBox(height: 10,),
                          _recently(context),
                          const SizedBox(height: 10,),
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

  _rate(BuildContext context){
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.1,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(App_Localization.of(context).translate("add_rate"),style: App.textBlod(Colors.black, 16),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  initialRating: productController.myProduct!.myRate,
                  minRating: 1,
                  direction: Axis.horizontal,
                  // ignoreGestures: true,
                  itemSize: 35,
                  // allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: App.midOrange,
                  ),
                  onRatingUpdate: (rating) {
                    // wishListController.add_to_rate(productController.myProduct!, rating);
                    productController.loading(true);
                    productController.myProduct!.myRate = rating;
                    productController.loading(false);
                    ApiV2.rateProduct(productController.myProduct!.id, rating);
                  },

                )
              ],
            ),
          ],
        ),
      ),
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
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
                boxShadow: [
                  App.box_shadow()
                ]
            ),
            /**slider*/
            child: CarouselSlider(
              items:
              productController.selectedOptions!= null
                  ? productController.selectedOptions!.images.map((e) {
                return GestureDetector(
                  onTap: (){
                    Get.to(()=>ImageShow(e));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius:  const BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
                        image: DecorationImage(
                            image: NetworkImage(
                                e),
                            fit: BoxFit.contain)),
                  ),
                );
              }).toList()
                  : productController.myProduct!.images.map((e) {
                return GestureDetector(
                  onTap: (){
                    Get.to(()=>ImageShow(e.link));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius:  const BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
                        image: DecorationImage(
                            image: NetworkImage(
                                e.link),
                            fit: BoxFit.contain)),
                  ),
                );
              }).toList(),

              options: CarouselOptions(
                autoPlay: productController.selectedOptions!= null
                    &&productController.selectedOptions!.images.length>1?true
                    :productController.myProduct!.images.length>1?true:false,
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
          right: 20,
          child: SizedBox(
            width: MediaQuery.of(context).size.width-20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              productController.selectedOptions!= null
                  ? productController.selectedOptions!.images.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: productController.selected_slider.value == productController.selectedOptions!.images.indexOf(e)
                          ? App.orange
                          : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }).toList():
              productController.myProduct!.images.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: productController.selected_slider.value == productController.myProduct!.images.indexOf(e)
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
          child: SizedBox(
            width: MediaQuery.of(context).size.width-10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){
                  Get.back();
                }, icon: Icon(Icons.arrow_back_ios,color: App.orange,)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(onPressed: (){
                      productController.favorite(productController.myProduct!,context);
                    }, icon: productController.myProduct!.wishlistLoading.value
                        ?CircularProgressIndicator()
                        :Icon(productController.myProduct!.favorite.value?Icons.favorite:Icons.favorite_border,color: App.orange,)),


                    Stack(
                      children: [
                        IconButton(onPressed: (){
                          Get.back();
                          Get.back();
                          Get.back();
                          Get.back();
                          homeController.selected_bottom_nav_bar.value=2;
                        }, icon: Icon(Icons.shopping_cart_outlined,color: App.orange,)),
                        Positioned(
                            top: 5,
                            right: 5,
                            child:  cartController.cart!.cartList.isEmpty?Center():Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle
                          ),
                          child: Center(
                            child:Text(cartController.cart!.cartList.length.toString(),style: TextStyle(color: Colors.white,fontSize: 10),),
                          ),
                        ))
                      ],
                    ),
                  ],
                ),

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
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            child: Text(productController.myProduct!.getTitle(),style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,overflow: TextOverflow.clip,),textAlign: TextAlign.left,),
          ),
        ),
      ],
    );
  }
  _price_avalibilty(BuildContext context){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width*0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(App_Localization.of(context).translate("aed")+" "+productController.myProduct!.price.toStringAsFixed(2),style: TextStyle(color: App.orange,fontSize: 24,overflow: TextOverflow.clip,),textAlign: TextAlign.center,),
                 // App.price(context, productController.myProduct!.price, productController.myProduct!.offer_price),

                  productController.myProduct!.offerPrice==null?
                  Text(App_Localization.of(context).translate("aed")+" "+(productController.myProduct!.price
                      +(productController.selectedOptions==null?0:productController.selectedOptions!.extraPrice)).toStringAsFixed(2),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14,),maxLines: 1,overflow: TextOverflow.ellipsis)
                      :Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(App_Localization.of(context).translate("aed")+" "+
                            (productController.myProduct!.price
                            +(productController.selectedOptions==null?0:productController.selectedOptions!.extraPrice)).toStringAsFixed(2),maxLines: 2,overflow: TextOverflow.clip,textAlign: TextAlign.center,style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 10,),
                        Text(App_Localization.of(context).translate("aed")+" "+productController.myProduct!.offerPrice!.toStringAsFixed(2),maxLines: 2,overflow: TextOverflow.clip,textAlign: TextAlign.center,style: TextStyle(color: Colors.grey[700], fontSize: 9, fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough),),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: App.midOrange,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(productController.myProduct!.rate.toStringAsFixed(1),style: const TextStyle(color: Colors.white,fontSize: 28,overflow: TextOverflow.clip,),textAlign: TextAlign.center,),
                          const SizedBox(width: 7,),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Icon(Icons.star,color: Colors.white,size: 18,),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 10,),
        Container(
          width: Get.width * 0.9,
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: (){
                Get.to(()=>CashewDetails());
              },
              child: Container(
                width: Get.width * 0.9,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffd6d6d3)),
                    borderRadius: BorderRadius.circular(7)
                ),
                child: Row(
                  children: [
                    Container(
                      width: Get.width*0.9 - 92,
                      child: Column(
                        children: [
                          Text(App_Localization.of(context).translate("cashew_description"),style: TextStyle(fontSize: 12),)
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 25,
                      child: SvgPicture.asset("assets/icon/cashew.svg"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          width: Get.width * 0.9,
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: (){
                Get.to(()=>TabbyWebView("https://checkout.tabby.ai/promos/product-page/installments/en/?price=${productController.myProduct!.price.toStringAsFixed(2)}&currency=AED"));
              },
              child: Container(
                width: Get.width * 0.9,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffd6d6d3)),
                    borderRadius: BorderRadius.circular(7)
                ),
                child: Row(
                  children: [
                    Container(
                      width: Get.width*0.9 - 92,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(App_Localization.of(context).translate("tabby_promotion"),style: TextStyle(fontSize: 12),)
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 25,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/logo/tabby.png"))
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(App_Localization.of(context).translate("availability")+": ",style: const TextStyle(color: Colors.black,fontSize: 14,overflow: TextOverflow.clip,),textAlign: TextAlign.center,),
                    Text(productController.myProduct!.availability<0?"0":productController.myProduct!.availability.toString(),style: const TextStyle(color: Colors.black,fontSize: 14,overflow: TextOverflow.clip,),textAlign: TextAlign.center,),
                  ],
                ),
              ),
            )
          ],
        ),
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
          Html(data: productController.myProduct!.getDescription()),
        ],
      ),
    );
  }
  _add_to_cart(BuildContext context){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),
            child:
            productController.myProduct!.availability==0?
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width*0.3,
              decoration: BoxDecoration(
                  color: App.midOrange,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Center(
                child: Text(App_Localization.of(context).translate("out_of_stock"),style: App.textNormal(Colors.white, 14),),
              ),
            )
                :GestureDetector(
              onTap: ()async{
                // if(productController.myProduct!.availability>0)
                productController.myProduct!.cartLoading(true);
                if(await productController.add_to_cart(context)){
                  showAlertDialog(context,productController.myProduct!);
                }
                productController.myProduct!.cartLoading(false);
                // App.sucss_msg(context, App_Localization.of(context).translate("cart_msg"));


              },
              child:
              productController.myProduct!.cartLoading.value
                  ?SizedBox(width: Get.width*0.3,child: App.cartBtnLoading(height: 40))
                  :Container(
                height: 40,
                width: Get.width*0.3,
                decoration: BoxDecoration(
                  color: App.midOrange,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: Text(App_Localization.of(context).translate("add_cart"),style: App.textNormal(Colors.white, 14),),
                ),
              ),
            ),
          ),
          productController.myProduct!.availability==0?
          const Center()
              :Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),
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
                      productController.decrease();
                    }, icon: const Icon(Icons.remove,)),
                    Text(productController.cart_count.toString()),
                    IconButton(onPressed: (){
                      productController.increase();
                    }, icon: const Icon(Icons.add,)),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  _add_review(BuildContext context){
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.1,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(App_Localization.of(context).translate("review"),style: App.textBlod(Colors.black, 16),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.6,
                    child: App.textField(reviewController, "write_yours", context,validate:reviewController.text.isNotEmpty),
                ),

                GestureDetector(
                  onTap: (){
                    // print( productController.myProduct!.id.toString());
                    if(Global.customer!=null){
                      if(reviewController.text.isNotEmpty){
                        List<Review> reviews=<Review>[];
                        reviews.add(Review(customerName: Global.customer!.firstname,body: reviewController.text,customerId: Global.customer!.id,id: -1,productId: productController.myProduct!.id));
                        reviews.addAll(productController.myProduct!.reviews);
                        productController.loading.value=false;
                        productController.myProduct!.reviews=reviews;
                        productController.add_review(reviewController.text, productController.myProduct!.id, context);
                        reviewController.text="";
                      }
                    }else{
                      // App.error_msg(context, App_Localization.of(context).translate("login_first"));
                      Get.to(()=>SignIn(true));
                    }

                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.25,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Center(child: Text(App_Localization.of(context).translate("publish"),style: App.textNormal(App.midOrange, 14),)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  _review(BuildContext context){
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
          itemCount: productController.myProduct!.reviews.length,
          itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(productController.myProduct!.reviews[index].customerName,style: App.textBlod(Colors.black, 16),),
              Text(productController.myProduct!.reviews[index].body,style: const TextStyle(fontSize: 12,color: Colors.grey),),
              const Divider(height: 2,color: Colors.black,)
            ],
          ),
        );
      }),
    );
  }

  _recently(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(App_Localization.of(context).translate("recently_view"),style: App.textBlod(Colors.black, 16)),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.2,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productController.myProduct!.recently.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  productController.selected_slider.value=0;
                 go_to_product(index);
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height*0.2,
                  width: MediaQuery.of(context).size.height*0.2,
                  child: Column(
                    children: [
                      Expanded(flex :3,
                          child: Container(decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(productController.myProduct!.recently[index].image)
                            )
                          ),),),
                      Expanded(flex:1,child: Text(productController.myProduct!.recently[index].getTitle(),textAlign: TextAlign.center,style: App.textNormal(Colors.black, 10),maxLines: 2,))
                    ],
                  ),
                ),
              );
            })
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context,Product product) {

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        height: 180,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 18,child: const Icon(Icons.check),backgroundColor: App.midOrange,),
                const SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width*0.5,child: Text(product.getTitle(),style: App.textBlod(Colors.black, 12),)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(App_Localization.of(context).translate("added_cart"),style: App.textNormal(Colors.grey, 12),),
                      ],
                    ),

                  ],
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Text(App_Localization.of(context).translate("cart_total")+": ",style: App.textBlod(Colors.black, 10),),
                    Text(App_Localization.of(context).translate("aed")+" ",style: App.textNormal(Colors.black, 10),),
                    Text(productController.cartController.cart!.total.toStringAsFixed(2),style: App.textNormal(Colors.black, 10),),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width*0.25,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          border: Border.all(color:App.midOrange,width: 2)
                        ),
                        child: Center(
                          child: Text(App_Localization.of(context).translate("continue_shopping"),style: App.textNormal(App.midOrange, 8),),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.back();
                        Get.back();
                        Get.back();
                        Get.back();
                        homeController.selected_bottom_nav_bar.value=2;
                      },
                      child: Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width*0.25,
                        decoration: BoxDecoration(
                            color: App.midOrange,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: Text(App_Localization.of(context).translate("checkout"),style: App.textNormal(Colors.white, 8),),
                        ),
                      ),
                    ),
                    ],
                ),

              ],
            )
          ],
        ),
      ),

    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
