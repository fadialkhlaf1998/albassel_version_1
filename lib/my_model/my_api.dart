import 'dart:convert';
import 'dart:ffi';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/model/my_order.dart';
import 'package:albassel_version_1/model/my_responce.dart';
import 'package:albassel_version_1/my_model/auto_discount.dart';
import 'package:albassel_version_1/my_model/brand.dart';
import 'package:albassel_version_1/my_model/category.dart';
import 'package:albassel_version_1/my_model/customer.dart';
import 'package:albassel_version_1/my_model/customer_order.dart';
import 'package:albassel_version_1/my_model/discount_code.dart';
import 'package:albassel_version_1/my_model/my_product.dart';
import 'package:albassel_version_1/my_model/product_info.dart';
import 'package:albassel_version_1/my_model/shipping.dart';
import 'package:albassel_version_1/my_model/slider.dart';
import 'package:albassel_version_1/my_model/start_up.dart';
import 'package:albassel_version_1/my_model/sub_category.dart';
import 'package:albassel_version_1/my_model/top_category.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class MyApi {

  // static String url = "https://phpstack-715372-2373312.cloudwaysapps.com/";
  static String url = "https://app.albaselco.com/";
  // static String url = "http://10.0.2.2:3000/";

  static Future<StartUp?> startUp()async{

    var request = http.Request('GET', Uri.parse(url+'api/start_up'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      return StartUp.fromJson(json);
    }
    else {
      return null;
    }

  }
  static Future<List<MyProduct>> sliderProducts(List<MyProduct> wishlist,int id)async{

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/slider_mobile'));
    request.body = json.encode({
      "id": id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var jsonlist = jsonDecode(json) as List;
      List<MyProduct> list = <MyProduct>[];

      for(int i=0;i<jsonlist.length;i++){
        list.add(MyProduct.fromMap(jsonlist[i]));
      }
      return get_favorite(wishlist,list);
    }
    else {
      return <MyProduct>[];
    }

  }
  static Future<bool> getShipping()async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('GET', Uri.parse(url+'api/shipping'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var list = jsonDecode(json) as List;
      List<Shipping> shippingList = <Shipping>[];
      for(int i=0;i<list.length;i++){
        shippingList.add(Shipping.fromMap(list[i]));
      }
      Global.shipping = shippingList.first;
      return true;
    }
    else {
      return getShipping();
    }
  }

  static Future<List<Brand>> getBrands()async{

    var request = http.Request('GET', Uri.parse(url+'api/brand'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var list = jsonDecode(json) as List;
      List<Brand> brands = <Brand>[];
      for(int i=0;i<list.length;i++){
        brands.add(Brand.fromMap(list[i]));
      }
      return brands;
    }
    else {
      return <Brand>[];
    }

  }
  static Future<List<MyProduct>> getOrderItems(int order_id)async{

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/order_item'));
    request.body = json.encode({
      "id": order_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var jsonlist = jsonDecode(json) as List;
      List<MyProduct> list = <MyProduct>[];

      for(int i=0;i<jsonlist.length;i++){
        list.add(MyProduct.fromMap(jsonlist[i]));
      }
      return list;
    }
    else {
      return <MyProduct>[];
    }

  }
  static Future<bool> cancelOrder(int order_id)async{

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/refuse_order'));
    request.body = json.encode({
      "id": order_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      return true;
    }
    else {
      return false;
    }

  }

  static Future<List<MySlider>> getSlider()async{

    var request = http.Request('GET', Uri.parse(url+'api/slider'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var list = jsonDecode(json) as List;
      List<MySlider> sliders = <MySlider>[];
      for(int i=0;i<list.length;i++){
        sliders.add(MySlider.fromMap(list[i]));
      }
      return sliders;
    }
    else {
      return <MySlider>[];
    }

  }

  static Future<List<MyProduct>> getBestSellers(List<MyProduct> wishlist)async{

    var request = http.Request('GET', Uri.parse(url+'api/best_sellers_mobile'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var jsonlist = jsonDecode(json) as List;
      List<MyProduct> list = <MyProduct>[];

      for(int i=0;i<jsonlist.length;i++){
        list.add(MyProduct.fromMap(jsonlist[i]));
      }
      return get_favorite(wishlist, list);
    }
    else {
      return <MyProduct>[];
    }

  }

  static Future<List<Category>> getCategory()async{

    var request = http.Request('GET', Uri.parse(url+'api/category'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var jsonlist = jsonDecode(json) as List;
      List<Category> list = <Category>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(Category.fromMap(jsonlist[i]));
      }
      return list;
    }
    else {
      return <Category>[];
    }
  }
  static Future<List<TopCategory>> getTopCategory()async{

    var request = http.Request('GET', Uri.parse(url+'api/top_category'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var jsonlist = jsonDecode(json) as List;
      List<TopCategory> list = <TopCategory>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(TopCategory.fromMap(jsonlist[i]));
      }
      return list;
    }
    else {
      return <TopCategory>[];
    }
  }
  static Future<List<SubCategory>> getSubCategory(int category_id)async{

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/sub_category_category'));
    request.body = json.encode({
      "id": category_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var jsonlist = jsonDecode(json) as List;
      List<SubCategory> list = <SubCategory>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(SubCategory.fromMap(jsonlist[i]));
      }
      return list;
    }
    else {
      return <SubCategory>[];
    }

  }
  static Future<List<SubCategory>> getMakeupSubSubCategory()async{

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('GET', Uri.parse(url+'api/makeup_sub_category'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var jsonlist = jsonDecode(json) as List;
      List<SubCategory> list = <SubCategory>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(SubCategory.fromMap(jsonlist[i]));
      }
      return list;
    }
    else {
      return <SubCategory>[];
    }

  }
  static Future<List<SubCategory>> getMakeupSubCategory(int category_id)async{

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/sub_category_makeup'));

    request.headers.addAll(headers);
    request.body = json.encode({
      "id": category_id
    });
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var jsonlist = jsonDecode(json) as List;
      List<SubCategory> list = <SubCategory>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(SubCategory.fromMap(jsonlist[i]));
      }
      return list;
    }
    else {
      return <SubCategory>[];
    }

  }
  static Future<List<MyProduct>> getProducts(List<MyProduct> wishlist,int sub_category_id)async{

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/product_sub_category'));
    request.body = json.encode({
      "id": sub_category_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var jsonlist = jsonDecode(json) as List;
      List<MyProduct> list = <MyProduct>[];

      for(int i=0;i<jsonlist.length;i++){
        list.add(MyProduct.fromMap(jsonlist[i]));
      }
      return get_favorite(wishlist,list);
    }
    else {
      return <MyProduct>[];
    }

  }

  static Future<List<MyProduct>> getCart(List<int> arr)async{

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/cart_info'));
    request.body = json.encode({
      "arr": arr
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var jsonlist = jsonDecode(json) as List;
      List<MyProduct> list = <MyProduct>[];

      for(int i=0;i<jsonlist.length;i++){
        list.add(MyProduct.fromMap(jsonlist[i]));
      }
      return list;
    }
    else {
      return <MyProduct>[];
    }
  }

  static Future<bool> delete_acount()async{

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('DELETE', Uri.parse(url+'api/delete-acount'));
    request.body = json.encode({
      "id": Global.customer!.id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('--------- response ---------');
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      print(jsonString);
      return true;
    }
    else {
      return false;
    }
  }

  static List<MyProduct> get_favorite(List<MyProduct> wishlist,List<MyProduct> prods){

    for(int i=0 ; i<wishlist.length;i++){
      for(int j=0 ; j<prods.length;j++){
        if(prods[j].id==wishlist[i].id){
          prods[j].favorite.value=true;
          wishlist[i]=prods[j];
        }
      }
    }
    return prods;
  }

  static Future<List<MyProduct>> getProductsSearch(List<MyProduct> wishlist,String q)async{

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/product/search'));
    request.body = json.encode({
      "title": q
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      var jsonlist = jsonDecode(jsonString) as List;
      List<MyProduct> list = <MyProduct>[];

      for(int i=0;i<jsonlist.length;i++){
        list.add(MyProduct.fromMap(jsonlist[i]));
      }
      return get_favorite(wishlist, list);
    }
    else {
      return <MyProduct>[];
    }

  }
  static Future<List<MyProduct>> getProductsByBrand(List<MyProduct> wishlist,int brand_id)async{

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/product_brand'));
    request.body = json.encode({
      "id": brand_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var jsonlist = jsonDecode(json) as List;
      List<MyProduct> list = <MyProduct>[];

      for(int i=0;i<jsonlist.length;i++){
        list.add(MyProduct.fromMap(jsonlist[i]));
      }
      return get_favorite(wishlist, list);
    }
    else {
      return <MyProduct>[];
    }

  }

  static Future<ProductInfo?> getProductsInfo(int id)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/product_info'));
    request.body = json.encode({
      "id": id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var jsonlist = jsonDecode(json) as List;
      List<ProductInfo> list = <ProductInfo>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(ProductInfo.fromMap(jsonlist[i]));
      }
      return list.first;
    }
    else {
      return null;
    }

  }

  static Future<bool> upload_customer_file(String path,int id)async{
    var request = http.MultipartRequest('POST', Uri.parse(url+'customer-file'));
    request.fields.addAll({
      'id': id.toString()
    });
    request.files.add(await http.MultipartFile.fromPath('profile-file', path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    return true;
    }
    else {
    print(response.reasonPhrase);
    return false;
    }

  }


  ///-------------logIn-------------
  static Future<MyReult> resend_code(String email)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'resend_code'));
    request.body = json.encode({
      "email": email
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      return MyReult(200,msg["message"],true);
    }
    else {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      return MyReult(500,msg["message"],false);
    }

  }
  static Future<Result> sign_up(String email,String pass,String firstname,String lastname,String phone,String country)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'add_user'));
    request.body = json.encode({
      "email": email,
      "pass": pass,
      "firstname":firstname,
      "lastname":lastname,
      "customer_type":Global.customer_type,
      "phone":phone,
      "country":country,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      Result result = Result.fromJson(json);
      // Global.customer=result.data.first;
      return result;
    }
    else {
      String json = await response.stream.bytesToString();
      Result result = Result.fromJson(json);
      return result;
    }

  }
  static Future<Result> login(String email,String pass)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'log_in'));
    request.body = json.encode({
      "email": email,
      "pass": pass
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      Result result = Result.fromJson(json);
      Global.customer=result.data.first;
      Global.customer_type = result.data.first.customer_type;
      Global.customer_type_decoder = result.data.first.customer_type;
      Store.save_verificat();
      return result;
    }
    else {
      String json = await response.stream.bytesToString();
      Result result = Result.fromJson(json);
      return result;
    }
  }
  static Future<MyReult> change_password(String email,String newpass)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'change_password'));
    request.body = json.encode({
      "email": email,
      "pass": newpass
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      Store.saveLoginInfo(email, newpass);
      return MyReult(200,msg["message"],true);
    }
    else {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      return MyReult(500,msg["message"],false);
    }
  }
  static Future<MyReult> forget_password(String email)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'forget_password'));
    request.body = json.encode({
      "email": email
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      return MyReult(200,msg["message"],true);
    }
    else {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      return MyReult(500,msg["message"],false);
    }
  }
  static Future<MyReult> verify_code(String email,String code)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'verify_email'));
    request.body = json.encode({
      "email": email,
      "code": code
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      return MyReult(200,msg["message"],true);
    }
    else {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      return MyReult(500,msg["message"],false);
    }
  }
  static Future<bool> check_internet()async{
    // return false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    }else{
      return false;
    }

  }
  static add_review(int customer_id,int product_id,String text)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/review'));
    request.body = json.encode({
      "priduct_id": product_id,
      "customer_id": customer_id,
      "body": text
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
     print(response.reasonPhrase);
    }

  }

  static rate(ProductInfo productInfo , double rate)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    double x= productInfo.rate*productInfo.ratingCount;
    double result = (x+rate)/(productInfo.ratingCount+1);
    var request = http.Request('POST', Uri.parse(url+'api/rate'));
    request.body = json.encode({
      "rate": result,
      "rating_count": productInfo.ratingCount++,
      "id": productInfo.id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }
  }

  static Future<bool> add_order(String first,String last,String address,String apartment,String city,String country,String emirate,String phone,String details,double sub_total,double shipping, double total,bool is_paid,List<LineItem> lineItems,String discount)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/v2/order'));
    request.body = json.encode({
      "customer_id": Global.customer!.id,
      "email":  Global.customer!.email,
      "apartment": apartment,
      "firstname": first,
      "lastname": last,
      "country": country,
      "emirate": emirate,
      "phone": phone,
      "details": details,
      "sub_total": sub_total.toStringAsFixed(2),
      "shipping": shipping,
      "total": total.toStringAsFixed(2),
      "is_paid": is_paid,
      "address": city+"/"+address,
      "lineItems": List<dynamic>.from(lineItems.map((x) => x.toMap())),
      "discount":discount
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }

  }


  static Future<List<AutoDiscount>> getAutoDiscount()async{

    var request = http.Request('GET', Uri.parse(url+'api/auto_discount_mobile'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var list = jsonDecode(json) as List;
      List<AutoDiscount> brands = <AutoDiscount>[];
      for(int i=0;i<list.length;i++){
        brands.add(AutoDiscount.fromMap(list[i]));
      }
      return brands;
    }
    else {
      return <AutoDiscount>[];
    }

  }

  static Future<DiscountCode?> discountCode(String code)async{
    try{
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(url+'api/active_discount_code'));
      request.body = json.encode({
        "code": code
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        var json = await response.stream.bytesToString();
        var list = jsonDecode(json) as List;
        print(list.isEmpty);
        if(list.isEmpty){
          return null;
        }
        print(response.statusCode);
        List<DiscountCode> brands = <DiscountCode>[];
        for(int i=0;i<list.length;i++){
          brands.add(DiscountCode.fromMap(list[i]));
        }
        Store.save_discount_code(code);
        return brands.first;
      }
      else {
        print(response.reasonPhrase);
        return null;
      }
    }catch(e){
      return null;
    }

  }

  // static search_sub_category(String title)async{
  //   var headers = {
  //     'Content-Type': 'application/json',
  //   };
  //   var request = http.Request('GET', Uri.parse(url+'api/sub_category/search'));
  //   request.body = json.encode({
  //     "title": title
  //   });
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //   }
  //   else {
  //   print(response.reasonPhrase);
  //   }
  //
  // }

  static search_product(String title)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/product/search'));
    request.body = json.encode({
      "title": title
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }

  }
  static Future<List<CustomerOrder>> get_customer_order(int id)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'api/customer_order'));
    request.body = json.encode({
      "id": id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var jsonlist = jsonDecode(json) as List;
      List<CustomerOrder> list = <CustomerOrder>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(CustomerOrder.fromMap(jsonlist[i]));
      }
      return list;
    }
    else {
      return <CustomerOrder>[];
    }


  }
}