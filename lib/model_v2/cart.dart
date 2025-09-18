import 'dart:convert';

import 'package:albassel_version_1/model_v2/product.dart';

class CartResponse {
  final int code;
  final String message;
  final CartData data;

  CartResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      code: json['code'] as int,
      message: json['message'] as String,
      data: CartData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class CartData {
  final double total;
  final double subTotal;
  final double discount;
  final double coupon;
  final double shipping;
  final double tax;
  final String discountErrorMsg;
  final CartDiscountCode? discountCode;
  final List<CartItem> cartList;

  CartData({
    required this.total,
    required this.subTotal,
    required this.discount,
    required this.coupon,
    required this.shipping,
    required this.tax,
    required this.discountErrorMsg,
    this.discountCode,
    required this.cartList,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      total: (json['total'] as num).toDouble(),
      subTotal: (json['sub_total'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      coupon: (json['coupon'] as num).toDouble(),
      shipping: (json['shipping'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      discountErrorMsg: json['discountErrorMsg'] as String,
      discountCode: json['discountCode'] != null
          ? CartDiscountCode.fromJson(json['discountCode'] as Map<String, dynamic>)
          : null,
      cartList: List<CartItem>.from(
        (json['cart_list'] as List).map(
              (item) => CartItem.fromJson(item as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'sub_total': subTotal,
      'discount': discount,
      'shipping': shipping,
      'tax': tax,
      'discountErrorMsg': discountErrorMsg,
      'discountCode': discountCode?.toJson(),
      'cart_list': cartList.map((item) => item.toJson()).toList(),
    };
  }
}

class CartDiscountCode {
  final int id;
  final String code;
  final int minimumQuantity;
  final int isActive;
  final int forAll;
  final double amount;
  final double persent;
  final int customerType;
  final int frequency;
  final int accountActivationTime;
  final List<Product> products;
  final List<Category> categories;
  final List<Brand> brands;
  final List<SubCategory> subCategories;

  CartDiscountCode({
    required this.id,
    required this.code,
    required this.minimumQuantity,
    required this.isActive,
    required this.forAll,
    required this.amount,
    required this.persent,
    required this.customerType,
    required this.frequency,
    required this.accountActivationTime,
    required this.products,
    required this.categories,
    required this.brands,
    required this.subCategories,
  });

  factory CartDiscountCode.fromJson(Map<String, dynamic> json) {
    return CartDiscountCode(
      id: json['id'] as int,
      code: json['code'] as String,
      minimumQuantity: json['minimum_quantity'] as int,
      isActive: json['is_active'] as int,
      forAll: json['for_all'] as int,
      amount: (json['amount'] as num).toDouble(),
      persent: (json['persent'] as num).toDouble(),
      customerType: json['customer_type'] as int,
      frequency: json['frequency'] as int,
      accountActivationTime: json['account_activation_time'] as int,
      products: List<Product>.from(
        (json['products'] as List).map(
              (item) => Product.fromJson(item as Map<String, dynamic>),
        ),
      ),
      categories: List<Category>.from(
        (json['category'] as List).map(
              (item) => Category.fromJson(item as Map<String, dynamic>),
        ),
      ),
      brands: List<Brand>.from(
        (json['brands'] as List).map(
              (item) => Brand.fromJson(item as Map<String, dynamic>),
        ),
      ),
      subCategories: List<SubCategory>.from(
        (json['sub_category'] as List).map(
              (item) => SubCategory.fromJson(item as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'minimum_quantity': minimumQuantity,
      'is_active': isActive,
      'for_all': forAll,
      'amount': amount,
      'persent': persent,
      'customer_type': customerType,
      'frequency': frequency,
      'account_activation_time': accountActivationTime,
      'products': products,
      'category': categories.map((item) => item.toJson()).toList(),
      'brands': brands.map((item) => item.toJson()).toList(),
      'sub_category': subCategories.map((item) => item.toJson()).toList(),
    };
  }
}

class Category {
  final int categoryId;
  final String title;

  Category({
    required this.categoryId,
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['category_id'] as int,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'title': title,
    };
  }
}

class Brand {
  final int brandId;
  final String title;

  Brand({
    required this.brandId,
    required this.title,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      brandId: json['brand_id'] as int,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brand_id': brandId,
      'title': title,
    };
  }
}

class SubCategory {
  final int subCategoryId;
  final String title;

  SubCategory({
    required this.subCategoryId,
    required this.title,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      subCategoryId: json['sub_category_id'] as int,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sub_category_id': subCategoryId,
      'title': title,
    };
  }
}

class CartItem {
  final int cartId;
  final int id;
  final int userId;
  final int productId;
  final int count;
  final int? optionId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int subCategoryId;
  final int brandId;
  final String title;
  final String subTitle;
  final String description;
  final String image;
  final double price;
  final int ratingCount;
  final double rate;
  final String sku;
  final int shopifyId;
  final int availability;
  final double? offerPrice;
  final double salonPrice;
  final double wholeSallerPrice;
  final int isDraft;
  final int categoryId;
  final String category;
  final String brand;
  final String optionTitle;
  final String arOptionTitle;
  final double extraPrice;
  final bool isAutoDiscount;
  final double totalPrice;
  final bool includeDiscount;

  CartItem({
    required this.cartId,
    required this.id,
    required this.userId,
    required this.productId,
    required this.count,
    this.optionId,
    required this.createdAt,
    required this.updatedAt,
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
    required this.categoryId,
    required this.category,
    required this.brand,
    required this.optionTitle,
    required this.arOptionTitle,
    required this.extraPrice,
    required this.isAutoDiscount,
    required this.totalPrice,
    required this.includeDiscount,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      cartId: json['cart_id'] as int,
      id: json['id'] as int,
      userId: json['user_id'] as int,
      productId: json['product_id'] as int,
      count: json['count'] as int,
      optionId: json['option_id'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      subCategoryId: json['sub_category_id'] as int,
      brandId: json['brand_id'] as int,
      title: json['title'] as String,
      subTitle: json['sub_title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
      ratingCount: json['rating_count'] as int,
      rate: (json['rate'] as num).toDouble(),
      sku: json['sku'] as String,
      shopifyId: (json['shopify_id']?? -1) as int,
      availability: json['availability'] as int,
      offerPrice: json['offer_price'] != null ? (json['offer_price'] as num).toDouble() : null,
      salonPrice: (json['salon_price'] as num).toDouble(),
      wholeSallerPrice: (json['whole_saller_price'] as num).toDouble(),
      isDraft: json['is_draft'] as int,
      categoryId: json['category_id'] as int,
      category: json['category'] as String,
      brand: json['brand'] as String,
      optionTitle: json['option_title'] as String,
      arOptionTitle: json['ar_option_title'] as String,
      extraPrice: (json['extra_price'] as num).toDouble(),
      isAutoDiscount: json['is_auto_discount'] as bool,
      totalPrice: (json['total_price'] as num).toDouble(),
      includeDiscount: json['include_discount'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (cartId != null) 'cart_id': cartId,
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'count': count,
      if (optionId != null) 'option_id': optionId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
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
      if (offerPrice != null) 'offer_price': offerPrice,
      'salon_price': salonPrice,
      'whole_saller_price': wholeSallerPrice,
      'is_draft': isDraft,
      'category_id': categoryId,
      'category': category,
      'brand': brand,
      'option_title': optionTitle,
      'ar_option_title': arOptionTitle,
      'extra_price': extraPrice,
      'is_auto_discount': isAutoDiscount,
      'total_price': totalPrice,
      'include_discount': includeDiscount,
    };
  }
}