

import 'dart:convert';

import 'package:albassel_version_1/const/global.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:albassel_version_1/model/collection.dart';
import 'package:albassel_version_1/model/customer.dart';
import 'package:albassel_version_1/model/order.dart';
import 'package:albassel_version_1/model/product.dart';

class Api{
  static String url="https://9648ea095b3463e808d603550b53f666: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@albasel-cosmetics.myshopify.com/admin/api/2021-10/";


  static Future<Customer?> add_customer(String first_name,String last_name,String email)async{
    try{
      FormData form_data=FormData.fromMap(

          {
            "customer": {
              "first_name": first_name,
              "last_name": last_name,
              "email": email,
              "verified_email": true,
              "addresses": []
            }
          }

      );
      Response response =await Dio().post(url+'customers.json',data: form_data,);
      print(response.data);
      print('********SIGNUP*******');
      Global.customer = Customer.fromMap(response.data);
      return  Global.customer;

    }catch (e){
      // print(e.toString());
      Customer? customer = await login_customers(email);
      return customer;
    }
  }
  static Future<Customer?> login_customers(String email)async{
    try{
      //&verified_email=true
      Response response =await Dio().get(url+"customers/search.json?email=$email");
      var customers_json=response.data['customers'] as List;
      Global.customer = Customer.fromMap(customers_json[0]);
      return Global.customer;
    }catch (e){
      print(e.toString());
      return null;
    }
  }
  static Future<List<Variant>> get_products_variants_by_id(int id)async{
    try {
      Response response = await Dio().get(
        url + "products/$id/variants.json",
      );
      print(response.data);
      return List<Variant>.from(response.data['variants'].map((x) => Variant.fromMap(x)));
    }catch (e){
      return <Variant>[];
    }
  }
  static Future<Customer?> get_customer(int customer_id)async{
    try{
      Response response =await Dio().get(url+"customers/${customer_id}.json");

      return Customer.fromMap(response.data['customer']);
    }catch (e){
      print(e.toString());
      return null;
    }
  }
  static Future<List<Collection>> get_collections ()async{
    try {
    Response response = await Dio().get(
          url + "smart_collections.json"
      );
      return Collections
          .fromJson(response.toString())
          .smartCollections ?? <Collection>[];

    }catch(e){
      print(e);
      return <Collection>[];
    }
  }
  static Future<List<Product>> get_products_by_Collection(String collection)async{
    try {
      Response response = await Dio().get(
          url + "products.json",
          queryParameters:{
            "product_type":collection
          }
      );
      List<Product> pros = Products.fromJson(response.toString()).products??<Product>[];
      for(var i in pros){
        i.variants = await get_products_variants_by_id(i.id!);
        print(i.variants!.first.price);
      }
      return pros;
    }catch (e){
      return <Product>[];
    }
  }
  static Future<List<Product>> get_products_by_ID(int id)async{
    try {
      Response response = await Dio().get(
          url + "products.json",
          queryParameters:{
            "id":id
          }
      );
      // return Products.fromJson(response.toString()).products??<Product>[];
      List<Product> pros = Products.fromJson(response.toString()).products??<Product>[];
      for(var i in pros){
        i.variants = await get_products_variants_by_id(i.id!);
        print(i.variants!.first.price);
      }
      return pros;
    }catch (e){
      return <Product>[];
    }
  }

  static Future<List<Product>> get_products(int collection_id)async{
    try {
      Response response = await Dio().get(
        url + "collections/$collection_id/products.json",
      );
      // List<Product> pros = Products.fromJson(response.toString()).products??<Product>[];
      // for(var i in pros){
      //   i.variants = await get_products_variants_by_id(i.id!);
      //   print(i.variants!.first.price);
      // }
      // return pros;
       return Products.fromJson(response.toString()).products??<Product>[];


    }catch (e){
      return <Product>[];
    }
  }
  static Future<List<Order>> get_customer_orders(int cusomer_id)async{
    try {
      Response response = await Dio().get(
          url + "customers/$cusomer_id/orders.json"
      );
      return Ordres.fromJson(response.toString()).orders??<Order>[];
    }catch (e){
      return <Order>[];
    }
  }
  static create_address(Customer customer,String first_name,String last_name,String address_1,String address_2,String phone,String country,String city,String province,bool _default)async{
    try {
      FormData form_data=FormData.fromMap(
          {
            "address": {
              "address1": address_1,
              "address2": address_2,
              "city": city,
              "company": "",
              "first_name": first_name,
              "last_name": last_name,
              "phone": phone,
              "province": province,
              "country": country,
              "zip": "",
              "name": "",
              "province_code": "",
              "country_code": "",
              "country_name": "",
              "default": _default
            }
          }
      );
      Response response =await Dio().post(url+"customers/${customer.id}/addresses.json",data: form_data,);
      print(response);
    }catch (e){

    }
  }
  static update_address(Customer customer,DefaultAddress defaultAddress)async{
    try {
      FormData form_data=FormData.fromMap(
          {
            "customer_address": {
              "customer_id": 207119551,
              "zip": "90210",
              "country": "United States",
              "province": "Kentucky",
              "city": "Louisville",
              "address1": "Chestnut Street 92",
              "address2": "",
              "first_name": null,
              "last_name": null,
              "company": null,
              "phone": "555-625-1199",
              "id": 207119551,
              "name": "",
              "province_code": "KY",
              "country_code": "US",
              "country_name": "United States",
              "default": true
            }
          }
      );
      Response response =await Dio().put(url+"/admin/helper/2021-07/customers/${customer.id}/addresses/${defaultAddress.id}.json",data: form_data,);
    }catch (e){
      print(e.toString());
      return <Order>[];
    }
  }
  static Future<bool> delete_address(Customer customer,int Address_id)async{
    try {
      Response response =await Dio().delete(url+"customers/${customer.id}/addresses/${Address_id}.json",);
      return true;
    }catch (e){
      return false;
    }
  }
  static Future<List<DefaultAddress>> get_address(Customer customer)async{
    try {
      List<DefaultAddress> address=<DefaultAddress>[];
      Response response =await Dio().get(url+"customers/${customer.id}/addresses.json",);

      var json_address = jsonDecode(response.toString())['addresses'] as List;
      for(int i=0 ; i<json_address.length;i++){
        address.add(DefaultAddress.fromMap(json_address[i]));
      }
      return address;
    }catch (e){
      return <DefaultAddress>[];
    }
  }
  static Future<bool> set_address_default(Customer customer,int Address_id)async{
    try {
      List<DefaultAddress> address=<DefaultAddress>[];
      Response response =await Dio().put(url+"customers/${customer.id}/addresses/${Address_id}/default.json",);
      return true;
    }catch (e){
      return false;
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


}