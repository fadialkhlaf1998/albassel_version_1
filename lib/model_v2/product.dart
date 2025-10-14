import 'dart:convert';

import 'package:albassel_version_1/const/global.dart';
import 'package:get/get.dart';

class ProductResponse {
  int code;
  String message;
  List<Product> data;

  ProductResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => Product.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message,
    'data': data.map((e) => e.toJson()).toList(),
  };

  /// Helper to decode from raw JSON string
  static ProductResponse fromRawJson(String str) =>
      ProductResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class Product {
  int id;
  int subCategoryId;
  int brandId;
  String title;
  String subTitle;
  String description;
  String image;
  double price;
  int ratingCount;
  double rate;
  String sku;
  int shopifyId;
  int availability;
  double? offerPrice;
  double salonPrice;
  double wholeSallerPrice;
  int isDraft;
  int wishlist;
  int categoryId;
  String category;
  String brand;
  var favorite=false.obs;
  var wishlistLoading=false.obs;
  var cartLoading=false.obs;
  int countForOrderItem;

  List<Image> images;
  List<Review> reviews;
  List<Option> options;
  List<Product> recently;
  Review? myReview;
  double myRate;

  String arTitle;
  String arDescription;
  List<PromotionalText> promotionalText;

  getTitle(){
    if(Global.lang_code == "en"){
      return title;
    }else{
      return arTitle;
    }
  }

  getDescription(){
    if(Global.lang_code == "en"){
      return description;
    }else{
      return arDescription;
    }
  }

  Product({
    required this.id,
    required this.subCategoryId,
    required this.brandId,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.image,
    required this.price,
    required this.ratingCount,
    required this.rate,
    required this.sku,
    required this.shopifyId,
    required this.availability,
    this.offerPrice,
    required this.salonPrice,
    required this.wholeSallerPrice,
    required this.isDraft,
    required this.wishlist,
    required this.categoryId,
    required this.category,
    required this.brand,
    required this.favorite,
    required this.countForOrderItem,
    required this.images,
    required this.reviews,
    required this.options,
    required this.recently,
    required this.myReview,
    required this.myRate,
    required this.arTitle,
    required this.arDescription,
    required this.promotionalText,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      subCategoryId: json['sub_category_id'] ?? 0,
      brandId: json['brand_id'] ?? 0,
      title: json['title'] ?? '',
      subTitle: json['sub_title'] ?? '',
      description: json['description'] ?? '',
      arTitle: json['ar_title'] ?? '',
      arDescription: json['ar_description'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      ratingCount: json['rating_count'] ?? 0,
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      sku: json['sku'] ?? '',
      shopifyId: json['shopify_id'] ?? 0,
      availability: json['availability'] ?? 0,
      offerPrice: (json['offer_price'] as num?)?.toDouble(),
      salonPrice: (json['salon_price'] as num?)?.toDouble() ?? 0.0,
      wholeSallerPrice:
      (json['whole_saller_price'] as num?)?.toDouble() ?? 0.0,
      isDraft: json['is_draft'] ?? 0,
      wishlist: json['wishlist'] ?? 0,
      countForOrderItem: json['count'] ?? 0,
      favorite: json['wishlist']==null?false.obs:json['wishlist']==1?true.obs:false.obs ,
      categoryId: json['category_id'] ?? 0,
      category: json['category'] ?? '',
      brand: json['brand'] ?? '',
      images: json["images"]==null?[]: List<Image>.from(json["images"].map((x) => Image.fromMap(x))),
      reviews: json["reviews"]==null?[]: List<Review>.from(json["reviews"].map((x) => Review.fromMap(x))),
      options: json["options"]==null?[]: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      recently: json["recently"]==null?[]: List<Product>.from(json["recently"].map((x) => Product.fromJson(x))),
      myReview: json["my_review"]==null?null: Review.fromMap(json["my_review"]),
      promotionalText: json["promotional_text"]==null?[]: List<PromotionalText>.from(json["promotional_text"].map((x) => PromotionalText.fromJson(x))),
      myRate: (json['my_rate'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'sub_category_id': subCategoryId,
    'brand_id': brandId,
    'title': title,
    'sub_title': subTitle,
    'description': description,
    'image': image,
    'price': price,
    'rating_count': ratingCount,
    'rate': rate,
    'sku': sku,
    'shopify_id': shopifyId,
    'availability': availability,
    'offer_price': offerPrice,
    'salon_price': salonPrice,
    'whole_saller_price': wholeSallerPrice,
    'is_draft': isDraft,
    'wishlist': wishlist,
    'category_id': categoryId,
    'category': category,
    'brand': brand,
  };
}

class Image {
  Image({
    required this.link,
  });

  String link;

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Image.fromMap(Map<String, dynamic> json) => Image(
    link: json["link"],
  );

  Map<String, dynamic> toMap() => {
    "link": link,
  };
}

class Review {
  Review({
    required this.id,
    required this.productId,
    required this.customerId,
    required this.body,
    required this.customerName
  });

  int id;
  int productId;
  int customerId;
  String body;
  String customerName;

  factory Review.fromJson(String str) => Review.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Review.fromMap(Map<String, dynamic> json) => Review(
      id: json["id"],
      productId: json["product_id"],
      customerId: json["customer_id"],
      body: json["body"],
      customerName: json["customer"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "product_id": productId,
    "customer_id": customerId,
    "body": body,
    "customer":customerName
  };
}

class Option {
  final int id;
  final int productId;
  final String title;
  final String arTitle;
  final double extraPrice;
  final String sku;
  final List<String> images; // parsed from comma-separated string
  final DateTime createdAt;
  final DateTime updatedAt;
  final int position;
  final int availability;
  final String mainImage;

  Option({
    required this.id,
    required this.productId,
    required this.title,
    required this.arTitle,
    required this.extraPrice,
    required this.sku,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
    required this.position,
    required this.availability,
    required this.mainImage,
  });

  getTitle(){
    if(Global.lang_code == "en"){
      return title;
    }else{
      return arTitle;
    }
  }

  factory Option.fromJson(Map<String, dynamic> json) {
    // images could be a comma separated string
    final rawImages = json['images'];
    List<String> imageList = [];
    if (rawImages != null) {
      if (rawImages is String) {
        imageList = rawImages
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
      } else if (rawImages is List) {
        imageList = rawImages.map((e) => e.toString()).toList();
      }
    }

    return Option(
      id: json['id'],
      productId: json['product_id'],
      title: json['title'],
      arTitle: json['ar_title'],
      extraPrice: (json['extra_price'] as num).toDouble(),
      sku: json['sku'],
      images: imageList,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      position: json['position'],
      availability: json['availability'],
      mainImage: json['main_image'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_id': productId,
    'title': title,
    'ar_title': arTitle,
    'extra_price': extraPrice,
    'sku': sku,
    'images': images.join(','), // back to comma-separated string
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'position': position,
    'availability': availability,
    'main_image': mainImage,
  };
}


class PromotionalText {
  final int id;
  final int productId;
  final String title;
  final String arTitle;


  PromotionalText({
    required this.id,
    required this.productId,
    required this.title,
    required this.arTitle,
  });

  getTitle(){
    if(Global.lang_code == "en"){
      return title;
    }else{
      return arTitle;
    }
  }

  factory PromotionalText.fromJson(Map<String, dynamic> json) {
    return PromotionalText(
      id: json['id'],
      productId: json['product_id'],
      title: json['title'],
      arTitle: json['ar_title'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_id': productId,
    'title': title,
    'ar_title': arTitle,
  };
}
