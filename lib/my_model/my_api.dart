import 'dart:convert';
import 'dart:ffi';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/helper/api_v2.dart';
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
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class MyApi {

  static String url = "";

  // static Future<StartUp?> startUp()async{
  //
  //   var request = http.Request('GET', Uri.parse(url+'api/start_up'));
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     var json = await response.stream.bytesToString();
  //     return StartUp.fromJson(json);
  //   }
  //   else {
  //     return null;
  //   }
  //
  // }

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
  static Future<Result> sign_up(String email,String pass,String firstname,String lastname,String phone,String country,int? sealsId)async{
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
      "sells_id": sealsId,
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
  static Future<Result> login(String email,String pass,String firebase_token,String app_version)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'log_in'));
    request.body = json.encode({
      "email": email,
      "pass": pass,
      "firebase_token":firebase_token,
      "app_version":app_version
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      Result result = Result.fromJson(json);
      Global.customer=result.data.first;
      Global.customer_type = result.data.first.customer_type;
      Global.customer_type_decoder = result.data.first.customer_type;
      ApiV2.token = result.data.first.token;
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

  static Future<DiscountCode?> discountCode(String code)async{
    try{
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(url+'api/active_discount_code'));
      request.body = json.encode({
        "code": code,
        "account_id":Global.customer==null?null:Global.customer!.id,
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