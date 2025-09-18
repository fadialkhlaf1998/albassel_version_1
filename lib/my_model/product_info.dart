// // To parse this JSON data, do
// //
// //     final productInfo = productInfoFromMap(jsonString);
//
// import 'package:albassel_version_1/const/global.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:meta/meta.dart';
// import 'dart:convert';
//
// class ProductInfo {
//   ProductInfo({
//     required this.id,
//     required this.subCategoryId,
//     required this.brandId,
//     required this.title,
//     required this.subTitle,
//     required this.description,
//     required this.price,
//     required this.rate,
//     required this.image,
//     required this.ratingCount,
//     required this.images,
//     required this.reviews,
//     required this.availability,
//     required this.offer_price,
//     required this.categoryId,
//     required this.brand,
//     required this.category,
//     required this.sku,
//   });
//
//   int id;
//   int subCategoryId;
//   int categoryId;
//   int brandId;
//   String title;
//   String sku;
//   String subTitle;
//   String description;
//   double price;
//   double? offer_price;
//   double rate;
//   String image;
//   String brand;
//   String category;
//   int ratingCount;
//   List<Image> images;
//   List<Review> reviews;
//   int availability;
//   var is_favoirite=false.obs;
//
//   factory ProductInfo.fromJson(String str) => ProductInfo.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory ProductInfo.fromMap(Map<String, dynamic> json) => ProductInfo(
//     id: json["id"],
//     brand: json["brand"]==null?"":json["brand"],
//     category: json["category"]==null?"":json["category"],
//     sku: json["sku"]==null?"":json["sku"],
//     subCategoryId: json["sub_category_id"]??-1,
//     brandId: json["brand_id"]??-1,
//     categoryId: json["category_id"]??-1,
//     title: json["title"],
//     subTitle: json["sub_title"],
//     description: json["description"],
//       price: Global.customer_type_decoder==0?double.parse(json["price"].toString()):Global.customer_type_decoder==1?double.parse(json["salon_price"].toString()):double.parse(json["whole_saller_price"].toString()),
//       offer_price: json["offer_price"]==null?null:double.parse(json["offer_price"].toString()),
//     rate:double.parse(json["rate"].toString()),
//     image: json["image"],
//     ratingCount: json["rating_count"],
//     images: List<Image>.from(json["images"].map((x) => Image.fromMap(x))),
//     reviews: List<Review>.from(json["reviews"].map((x) => Review.fromMap(x))),
//     availability: json["availability"]==null?0:json["availability"]<0?0:json["availability"],
//       // availability:10
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "sub_category_id": subCategoryId,
//     "brand_id": brandId,
//     "brand": brand,
//     "category": category,
//     "category_id": categoryId,
//     "title": title,
//     "sub_title": subTitle,
//     "description": description,
//     "price": price,
//     "rate": rate,
//     "image": image,
//     "rating_count": ratingCount,
//     "images": List<dynamic>.from(images.map((x) => x.toMap())),
//     "reviews": List<dynamic>.from(reviews.map((x) => x.toMap())),
//     "availability":availability,
//     "offer_price":offer_price,
//   };
// }
//
// class Image {
//   Image({
//     required this.link,
//   });
//
//   String link;
//
//   factory Image.fromJson(String str) => Image.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory Image.fromMap(Map<String, dynamic> json) => Image(
//     link: json["link"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "link": link,
//   };
// }
//
// class Review {
//   Review({
//     required this.id,
//     required this.productId,
//     required this.customerId,
//     required this.body,
//     required this.customerName
//   });
//
//   int id;
//   int productId;
//   int customerId;
//   String body;
//   String customerName;
//
//   factory Review.fromJson(String str) => Review.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory Review.fromMap(Map<String, dynamic> json) => Review(
//     id: json["id"],
//       productId: json["product_id"],
//     customerId: json["customer_id"],
//     body: json["body"],
//     customerName: json["customer"]
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "product_id": productId,
//     "customer_id": customerId,
//     "body": body,
//     "customer":customerName
//   };
// }
