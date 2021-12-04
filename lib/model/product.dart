import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';


class Products {
  Products({
    this.products,
  });

  List<Product>? products;

  factory Products.fromJson(String str) => Products.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Products.fromMap(Map<String, dynamic> json) => Products(
    products: List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "products": List<dynamic>.from(products!.map((x) => x.toMap())),
  };
}

class Product {
  Product({
    this.id,
    this.title,
    this.bodyHtml,
    this.vendor,
    this.productType,
    this.createdAt,
    this.handle,
    this.updatedAt,
    this.publishedAt,
    this.templateSuffix,
    this.status,
    this.publishedScope,
    this.tags,
    this.adminGraphqlApiId,
    this.variants,
    this.options,
    this.images,
    this.image,
  });
  Rx<bool> is_favoirite=false.obs;
  int? id;
  String? title;
  String? bodyHtml;
  String? vendor;
  String? productType;
  String? createdAt;
  String? handle;
  String? updatedAt;
  dynamic? publishedAt;
  String? templateSuffix;
  String? status;
  String? publishedScope;
  String? tags;
  String? adminGraphqlApiId;
  List<Variant>? variants;
  List<Option>? options;
  List<ProductImage>? images;
  ProductImage? image;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) {

    return Product(
    id: json["id"],
    title: json["title"],
    bodyHtml: json["body_html"],
    vendor: json["vendor"],
    productType: json["product_type"],
    createdAt: json["created_at"],
    handle: json["handle"],
    updatedAt: json["updated_at"],
    publishedAt: json["published_at"],
    templateSuffix: json["template_suffix"],
    status: json["status"],
    publishedScope: json["published_scope"],
    tags: json["tags"],
    adminGraphqlApiId: json["admin_graphql_api_id"],
    variants:json["variants"]==null?<Variant>[]: List<Variant>.from(json["variants"].map((x) => Variant.fromMap(x))),
    options:json["options"]==null?null: List<Option>.from(json["options"].map((x) => Option.fromMap(x))),
    images:json["images"]==null?null: List<ProductImage>.from(json["images"].map((x) => ProductImage.fromMap(x))),
    image: json["image"]==null?null:ProductImage.fromMap(json["image"]),
  );}

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "body_html": bodyHtml,
    "vendor": vendor,
    "product_type": productType,
    "created_at": createdAt,
    "handle": handle,
    "updated_at": updatedAt,
    "published_at": publishedAt,
    "template_suffix": templateSuffix,
    "status": status,
    "published_scope": publishedScope,
    "tags": tags,
    "admin_graphql_api_id": adminGraphqlApiId,
    "variants": List<dynamic>.from(variants!.map((x) => x.toMap())),
    "options": options==null?null:List<dynamic>.from(options!.map((x) => x.toMap())),
    "images": images==null?null: List<dynamic>.from(images!.map((x) => x.toMap())),
    "image": image==null?null:image!.toMap(),
  };
}

class ProductImage {

  ProductImage({
    this.id,
    this.productId,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.alt,
    this.width,
    this.height,
    this.src,
    this.adminGraphqlApiId,
  });

  int? id;
  int? productId;
  int? position;
  String? createdAt;
  String? updatedAt;
  dynamic? alt;
  int? width;
  int? height;
  String? src;
  String? adminGraphqlApiId;

  factory ProductImage.fromJson(String str) => ProductImage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductImage.fromMap(Map<String, dynamic> json) => ProductImage(
    id: json["id"],
    productId: json["product_id"],
    position: json["position"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    alt: json["alt"],
    width: json["width"],
    height: json["height"],
    src: json["src"],
    adminGraphqlApiId: json["admin_graphql_api_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "product_id": productId,
    "position": position,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "alt": alt,
    "width": width,
    "height": height,
    "src": src,

    "admin_graphql_api_id": adminGraphqlApiId,
  };


}

class Option {
  Option({
    this.id,
    this.productId,
    this.name,
    this.position,
    this.values,
  });

  int? id;
  int? productId;
  String? name;
  int? position;
  List<String>? values;

  factory Option.fromJson(String str) => Option.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Option.fromMap(Map<String, dynamic> json) => Option(
    id: json["id"],
    productId: json["product_id"],
    name: json["name"],
    position: json["position"],
    values:json["values"]==null? <String>[] : List<String>.from(json["values"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "product_id": productId,
    "name": name,
    "position": position,
    "values": List<dynamic>.from(values!.map((x) => x)),
  };
}

class Variant {
  Variant({
    this.id,
    this.productId,
    this.title,
    this.price,
    this.sku,
    this.position,
    this.inventoryPolicy,
    this.compareAtPrice,
    this.fulfillmentService,
    this.inventoryManagement,
    this.option1,
    this.option2,
    this.option3,
    this.createdAt,
    this.updatedAt,
    this.taxable,
    this.barcode,
    this.grams,
    this.imageId,
    this.weight,
    this.weightUnit,
    this.inventoryItemId,
    this.inventoryQuantity,
    this.oldInventoryQuantity,
    this.requiresShipping,
    this.adminGraphqlApiId,
  });

  int? id;
  int? productId;
  String? title;
  String? price;
  String? sku;
  int? position;
  String? inventoryPolicy;
  dynamic? compareAtPrice;
  String? fulfillmentService;
  dynamic? inventoryManagement;
  String? option1;
  dynamic? option2;
  dynamic? option3;
  String? createdAt;
  String? updatedAt;
  bool? taxable;
  String? barcode;
  int? grams;
  dynamic? imageId;
  double? weight;
  String? weightUnit;
  int? inventoryItemId;
  int? inventoryQuantity;
  int? oldInventoryQuantity;
  bool? requiresShipping;
  String? adminGraphqlApiId;

  factory Variant.fromJson(String str) => Variant.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Variant.fromMap(Map<String, dynamic> json) => Variant(
    id: json["id"],
    productId: json["product_id"],
    title: json["title"],
    price: json["price"],
    sku: json["sku"],
    position: json["position"],
    inventoryPolicy: json["inventory_policy"],
    compareAtPrice: json["compare_at_price"],
    fulfillmentService: json["fulfillment_service"],
    inventoryManagement: json["inventory_management"],
    option1: json["option1"],
    option2: json["option2"],
    option3: json["option3"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    taxable: json["taxable"],
    barcode: json["barcode"],
    grams: json["grams"],
    imageId: json["image_id"],
    weight: json["weight"],
    weightUnit: json["weight_unit"],
    inventoryItemId: json["inventory_item_id"],
    inventoryQuantity: json["inventory_quantity"],
    oldInventoryQuantity: json["old_inventory_quantity"],
    requiresShipping: json["requires_shipping"],
    adminGraphqlApiId: json["admin_graphql_api_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "product_id": productId,
    "title": title,
    "price": price,
    "sku": sku,
    "position": position,
    "inventory_policy": inventoryPolicy,
    "compare_at_price": compareAtPrice,
    "fulfillment_service": fulfillmentService,
    "inventory_management": inventoryManagement,
    "option1": option1,
    "option2": option2,
    "option3": option3,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "taxable": taxable,
    "barcode": barcode,
    "grams": grams,
    "image_id": imageId,
    "weight": weight,
    "weight_unit": weightUnit,
    "inventory_item_id": inventoryItemId,
    "inventory_quantity": inventoryQuantity,
    "old_inventory_quantity": oldInventoryQuantity,
    "requires_shipping": requiresShipping,
    "admin_graphql_api_id": adminGraphqlApiId,
  };
}
