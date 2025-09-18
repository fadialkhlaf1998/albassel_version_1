import 'dart:convert';
import 'dart:developer';

import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/model_v2/address.dart';
import 'package:albassel_version_1/model_v2/api_result.dart';
import 'package:albassel_version_1/model_v2/cart.dart';
import 'package:albassel_version_1/model_v2/country.dart';
import 'package:albassel_version_1/model_v2/product.dart';
import 'package:albassel_version_1/my_model/start_up.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ApiV2 {

  static String url = "";
  // static String url = "http://10.0.2.2:3000";
  // static String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoxNDAsImVtYWlsIjoiZmFkaS5raDM4NjEwMTMwQGdtYWlsLmNvbSIsImZpcnN0bmFtZSI6ImZhZGkiLCJsYXN0bmFtZSI6ImtoIiwiY29kZSI6Ijk0MjU3NyIsImlzX2FjdGl2ZSI6MSwicGFzcyI6InBhc3N3b3JkIiwiY3VzdG9tZXJfdHlwZSI6MCwidXBsb2FkZWRfbGluayI6bnVsbCwicGhvbmUiOiIrOTcxIiwiY291bnRyeSI6IkFFIiwic2VsbHNfaWQiOm51bGwsImZpcmViYXNlX3Rva2VuIjoiZm5uNzdQdGVURjZHYmx1NHJmM0JYVTpBUEE5MWJIczE0UWZxcGM3NjlhOE5acjNveHlIeWJsVE90N0o2YjlwLWV5WnhSamxGZER6R0lybDBEbW9nVlZXaGZjbnZRSkdvNGVXc1lLdWFES2dWNG1FcHY3ZTFkd3QyYUk1MmZsQVFSOUxkTWk1MGhVMUpLTSIsImFwcF92ZXJzaW9uIjoiMi4zLjkifSwiaWF0IjoxNzU3OTIwNDI2fQ.WRGznPloJcs7Yh2CFd3d5Ga2R6W_v_1FUknFZ66HBfA";
  static String token = "";


  static Future<bool> signUpVerfied(String email,String pass,String fName,String lName)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'/api/v2/mobile/account/signup-verfied'));
    request.body = json.encode({
      "email": email,
      "pass": pass,
      "firstname": fName,
      "lastname": lName
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Store.saveLoginInfo(email, pass);
      return true;
    }else {
      print(response.reasonPhrase);
      return true;
    }
  }
  static Future<bool> log(Object obj)async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'/api/v2/mobile/product/log'));
    request.body = json.encode(obj);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = (await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }

  }
  static Future<List<Product>> getProductsBySlider(int slider_id)async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'/api/v2/mobile/product/get-from-slider'));
    request.body = json.encode({
      "id": slider_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = (await response.stream.bytesToString());
      return ProductResponse.fromJson(jsonDecode(jsonString)).data;
    }
    else {
      print(response.reasonPhrase);
      return [];
    }

  }
  static Future<List<Product>> getProductsForOrder(int order_id)async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'/api/v2/mobile/product/get-for-order'));
    request.body = json.encode({
      "id": order_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();


    if (response.statusCode == 200) {
      String jsonString = (await response.stream.bytesToString());
      return ProductResponse.fromJson(jsonDecode(jsonString)).data;
    }
    else {
      print(response.reasonPhrase);
      return [];
    }
  }
  static Future<List<Product>> searchSuggestions()async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token
    };
    var request = http.Request('GET', Uri.parse(url+'/api/v2/mobile/product/search-suggestions'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = (await response.stream.bytesToString());
      Global.suggestion_list = ProductResponse.fromJson(jsonDecode(jsonString)).data;

      return Global.suggestion_list;
    }
    else {
      print(response.reasonPhrase);
      return [];
    }
  }
  static Future<List<Product>> getBeastSellersProducts()async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token
    };
    var request = http.Request('GET', Uri.parse(url+'/api/v2/mobile/product/best-sellers'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = (await response.stream.bytesToString());
      return ProductResponse.fromJson(jsonDecode(jsonString)).data;
    }
    else {
      print(response.reasonPhrase);
      return [];
    }
  }
  static Future<List<Product>> search(String query)async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'/api/v2/mobile/product/search'));
    request.body = json.encode({
      "query": query
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = (await response.stream.bytesToString());
      return ProductResponse.fromJson(jsonDecode(jsonString)).data;
    }
    else {
      print(response.reasonPhrase);
      return [];
    }
  }
  static Future<List<Product>> getProductsByBrand(int brand_id)async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'/api/v2/mobile/product/brand'));
    request.body = json.encode({
      "id": brand_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = (await response.stream.bytesToString());
      return ProductResponse.fromJson(jsonDecode(jsonString)).data;
    }
    else {
      print(response.reasonPhrase);
      return [];
    }
  }
  static Future<List<Product>> getProductsBySubCategory(int sub_category_id)async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'/api/v2/mobile/product/sub-category'));
    request.body = json.encode({
      "id": sub_category_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = (await response.stream.bytesToString());
      return ProductResponse.fromJson(jsonDecode(jsonString)).data;
    }
    else {
      print(response.reasonPhrase);
      return [];
    }

  }

  static Future<Product?> getProductDetails(int product_id)async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token
    };
    var request = http.Request('GET', Uri.parse(url+'/api/v2/mobile/product/details/'+product_id.toString()));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = (await response.stream.bytesToString());
      List<Product> pros = ProductResponse.fromJson(jsonDecode(jsonString)).data;
      if(pros.length > 0){
        return pros.first;
      }
      return null;
    }
    else {
      print(response.reasonPhrase);
      return null;
    }

  }

  static rateProduct(int productId , double rate)async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'/api/v2/mobile/product/add-rate'));
    request.body = json.encode({
      "rate": rate,
      "product_id": productId
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

  static Future<List<Product>> getWishList()async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token
    };
    var request = http.Request('GET', Uri.parse(url+'/api/v2/mobile/product/wishlist'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = (await response.stream.bytesToString());
      return ProductResponse.fromJson(jsonDecode(jsonString)).data;
    }
    else {
      print(response.reasonPhrase);
      return [];
    }
  }

  static Future<StartUp?> startUp()async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token
    };
    var request = http.Request('GET', Uri.parse(url+'/api/v2/mobile/start-up'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonData = (await response.stream.bytesToString());
      return StartUpResponse.fromJson(jsonDecode(jsonData)).data;
    }
    else {
      print(response.reasonPhrase);
      return null;
    }

  }

  static Future<bool> addToWishlist(int product_id)async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'/api/v2/mobile/wishlist'));
    request.body = json.encode({
      "product_id": product_id
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

  static Future<bool> deleteFromWishlist(int product_id)async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('DELETE', Uri.parse(url+'/api/v2/mobile/wishlist'));
    request.body = json.encode({
      "product_id": product_id
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

  static Future<bool> placeOrder(String? discountCode,String reference,int addressId,int isPaid)async{
    var headers = {
      'Authorization': 'bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'/api/v2/mobile/cart/checkout'));
    request.body = json.encode({
      "discount_code": discountCode,
      "reference": reference,
      "address_id": addressId,
      "is_paid": isPaid
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

  static Future<CartData?> getCart(String? discountCode,int? addressId)async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'/api/v2/mobile/cart'));
    request.body = json.encode({
      "discount_code": discountCode,
      "address_id":addressId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return CartResponse.fromJson(jsonDecode(jsonString)).data;
    }else {
      return null;
    }
  }

  static Future<ApiResult> addToCart(int product_id, int? option_id , int count)async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse(url+'/api/v2/mobile/cart'));
    request.body = json.encode({
      "product_id": product_id,
      "option_id": option_id,
      "count": count
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = (await response.stream.bytesToString());
      return ApiResult.fromJson(jsonDecode(jsonString));
    }
    else {
      String jsonString = (await response.stream.bytesToString());
      return ApiResult.fromJson(jsonDecode(jsonString));
    }

  }

  static Future<ApiResult> deleteFromCart(int cart_id)async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('DELETE', Uri.parse(url+'/api/v2/mobile/cart'));
    request.body = json.encode({
      "cart_id": cart_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = (await response.stream.bytesToString());
      return ApiResult.fromJson(jsonDecode(jsonString));
    }
    else {
      String jsonString = (await response.stream.bytesToString());
      return ApiResult.fromJson(jsonDecode(jsonString));
    }

  }

  static Future<List<Address>> getAddress()async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token
    };
    var request = http.Request('GET', Uri.parse(url+'/api/v2/mobile/address'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = (await response.stream.bytesToString());
      return AddressResponse.fromJson(jsonDecode(jsonString)).data;
    }
    else {
      print(response.reasonPhrase);
      return [];
    }

  }

  static Future<bool> addAddress(int country_id,int shipping_id,String nick_name,
      String address,String apartment,String city,String phone,String first_name,String last_name,int nick_name_status)async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'/api/v2/mobile/address'));
    request.body = json.encode({
      "country_id": country_id,
      "shipping_id": shipping_id,
      "nick_name": nick_name,
      "address": address,
      "apartment": apartment,
      "city": city,
      "first_name": first_name,
      "last_name": last_name,
      "nick_name_status": nick_name_status,
      "phone": phone
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


  static Future<bool> editAddress(int country_id,int shipping_id,String nick_name,
      String address,String apartment,String city,String phone,String first_name,String last_name,int nick_name_status,int id)async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse(url+'/api/v2/mobile/address'));
    request.body = json.encode({
      "country_id": country_id,
      "shipping_id": shipping_id,
      "nick_name": nick_name,
      "address": address,
      "apartment": apartment,
      "city": city,
      "phone": phone,
      "first_name": first_name,
      "last_name": last_name,
      "nick_name_status": nick_name_status,
      "id":id
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

  static Future<bool> deleteAddress(int id)async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('DELETE', Uri.parse(url+'/api/v2/mobile/address'));
    request.body = json.encode({
      "id": id
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

  static Future<List<Country>> getCountries()async{
    await checkInternet();
    var headers = {
      'Authorization': 'bearer '+token
    };
    var request = http.Request('GET', Uri.parse(url+'/api/v2/mobile/address/country'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = (await response.stream.bytesToString());
      return CountryResponse.fromJson(jsonDecode(jsonString)).data;
    }
    else {
      print(response.reasonPhrase);
      return [];
    }
  }

  static Future<bool> checkInternet()async{
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

// This condition is for demo purposes only to explain every connection type.
// Use conditions which work for your requirements.
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      // Mobile network available.
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      // Wi-fi is available.
      // Note for Android:
      // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      // Ethernet connection available.
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      // Vpn connection active.
      // Note for iOS and macOS:
      // There is no separate network interface type for [vpn].
      // It returns [other] on any device (also simulator)
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      // Bluetooth connection available.
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      // Connected to a network which is not in the above mentioned networks.
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      // No available network types

      await Get.to(()=>NoInternet());
      return false;
    }else{
      await Get.to(()=>NoInternet());
      return false;
    }


  }

}