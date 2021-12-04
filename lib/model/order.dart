// To parse this JSON data, do
//
//     final ordres = ordresFromMap(jsonString);

import 'dart:convert';
import 'package:albassel_version_1/model/product.dart';

import 'customer.dart';

class Ordres {
  Ordres({
    this.orders,
  });

  List<Order>? orders;

  factory Ordres.fromJson(String str) => Ordres.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ordres.fromMap(Map<String, dynamic> json) => Ordres(
    orders: List<Order>.from(json["orders"].map((x) => Order.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "orders": List<dynamic>.from(orders!.map((x) => x.toMap())),
  };
}

class Order {
  Order({
    this.id,
    this.adminGraphqlApiId,
    this.appId,
    this.browserIp,
    this.buyerAcceptsMarketing,
    this.cancelReason,
    this.cancelledAt,
    this.cartToken,
    this.checkoutId,
    this.checkoutToken,
    this.clientDetails,
    this.closedAt,
    this.confirmed,
    this.contactEmail,
    this.createdAt,
    this.currency,
    this.currentSubtotalPrice,
    this.currentSubtotalPriceSet,
    this.currentTotalDiscounts,
    this.currentTotalDiscountsSet,
    this.currentTotalDutiesSet,
    this.currentTotalPrice,
    this.currentTotalPriceSet,
    this.currentTotalTax,
    this.currentTotalTaxSet,
    this.customerLocale,
    this.deviceId,
    this.discountCodes,
    this.email,
    this.estimatedTaxes,
    this.financialStatus,
    this.fulfillmentStatus,
    this.gateway,
    this.landingSite,
    this.landingSiteRef,
    this.locationId,
    this.name,
    this.note,
    this.noteAttributes,
    this.number,
    this.orderNumber,
    this.orderStatusUrl,
    this.originalTotalDutiesSet,
    this.paymentGatewayNames,
    this.phone,
    this.presentmentCurrency,
    this.processedAt,
    this.processingMethod,
    this.reference,
    this.referringSite,
    this.sourceIdentifier,
    this.sourceName,
    this.sourceUrl,
    this.subtotalPrice,
    this.subtotalPriceSet,
    this.tags,
    this.taxLines,
    this.taxesIncluded,
    this.test,
    this.token,
    this.totalDiscounts,
    this.totalDiscountsSet,
    this.totalLineItemsPrice,
    this.totalLineItemsPriceSet,
    this.totalOutstanding,
    this.totalPrice,
    this.totalPriceSet,
    this.totalPriceUsd,
    this.totalShippingPriceSet,
    this.totalTax,
    this.totalTaxSet,
    this.totalTipReceived,
    this.totalWeight,
    this.updatedAt,
    this.userId,
    this.billingAddress,
    this.customer,
    this.discountApplications,
    this.fulfillments,
    this.lineItems,
    this.refunds,
    this.shippingAddress,
    this.shippingLines,
  });

  int? id;
  String? adminGraphqlApiId;
  int? appId;
  String? browserIp;
  bool? buyerAcceptsMarketing;
  String? cancelReason;
  String? cancelledAt;
  String? cartToken;
  int? checkoutId;
  String? checkoutToken;
  ClientDetails? clientDetails;
  String? closedAt;
  bool? confirmed;
  String? contactEmail;
  String? createdAt;
  String? currency;
  String? currentSubtotalPrice;
  Set? currentSubtotalPriceSet;
  String? currentTotalDiscounts;
  Set? currentTotalDiscountsSet;
  dynamic? currentTotalDutiesSet;
  String? currentTotalPrice;
  Set? currentTotalPriceSet;
  String? currentTotalTax;
  Set? currentTotalTaxSet;
  String? customerLocale;
  dynamic? deviceId;
  List<DiscountCode>? discountCodes;
  String? email;
  bool? estimatedTaxes;
  String? financialStatus;
  String? fulfillmentStatus;
  String? gateway;
  String? landingSite;
  dynamic? landingSiteRef;
  dynamic? locationId;
  String? name;
  String? note;
  List<dynamic>? noteAttributes;
  int? number;
  int? orderNumber;
  String? orderStatusUrl;
  dynamic? originalTotalDutiesSet;
  List<String>? paymentGatewayNames;
  String? phone;
  String? presentmentCurrency;
  String? processedAt;
  String? processingMethod;
  dynamic? reference;
  String? referringSite;
  dynamic? sourceIdentifier;
  String? sourceName;
  dynamic? sourceUrl;
  String? subtotalPrice;
  Set? subtotalPriceSet;
  String? tags;
  List<TaxLine>? taxLines;
  bool? taxesIncluded;
  bool? test;
  String? token;
  String? totalDiscounts;
  Set? totalDiscountsSet;
  String? totalLineItemsPrice;
  Set? totalLineItemsPriceSet;
  String? totalOutstanding;
  String? totalPrice;
  Set? totalPriceSet;
  String? totalPriceUsd;
  Set? totalShippingPriceSet;
  String? totalTax;
  Set? totalTaxSet;
  String? totalTipReceived;
  int? totalWeight;
  String? updatedAt;
  dynamic? userId;
  IngAddress? billingAddress;
  Customer? customer;
  List<DiscountApplication>? discountApplications;
  List<Fulfillment>? fulfillments;
  List<OrderLineItem>? lineItems;
  List<Refund>? refunds;
  IngAddress? shippingAddress;
  List<ShippingLine>? shippingLines;

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    id: json["id"],
    adminGraphqlApiId: json["admin_graphql_api_id"],
    appId: json["app_id"],
    browserIp: json["browser_ip"],
    buyerAcceptsMarketing: json["buyer_accepts_marketing"],
    cancelReason: json["cancel_reason"] == null ? null : json["cancel_reason"],
    cancelledAt: json["cancelled_at"] == null ? null : json["cancelled_at"],
    cartToken: json["cart_token"] == null ? null : json["cart_token"],
    checkoutId: json["checkout_id"],
    checkoutToken: json["checkout_token"],
    clientDetails:json["client_details"]==null?null: ClientDetails.fromMap(json["client_details"]),
    closedAt: json["closed_at"] == null ? null : json["closed_at"],
    confirmed: json["confirmed"],
    contactEmail: json["contact_email"] == null ? null : json["contact_email"],
    createdAt: json["created_at"],
    currency: json["currency"],
    currentSubtotalPrice: json["current_subtotal_price"],
    currentSubtotalPriceSet:json["current_subtotal_price_set"]==null?null: Set.fromMap(json["current_subtotal_price_set"]),
    currentTotalDiscounts: json["current_total_discounts"],
    currentTotalDiscountsSet:json["current_total_price_set"]==null?null: Set.fromMap(json["current_total_discounts_set"]),
    currentTotalDutiesSet: json["current_total_duties_set"],
    currentTotalPrice: json["current_total_price"],
    currentTotalPriceSet:json["current_total_price_set"]==null?null: Set.fromMap(json["current_total_price_set"]),
    currentTotalTax: json["current_total_tax"],
    currentTotalTaxSet: json["current_total_tax_set"]==null?null:Set.fromMap(json["current_total_tax_set"]),
    customerLocale: json["customer_locale"],
    deviceId: json["device_id"],
    discountCodes:json["discount_codes"]==null?null: List<DiscountCode>.from(json["discount_codes"].map((x) => DiscountCode.fromMap(x))),
    email: json["email"],
    estimatedTaxes: json["estimated_taxes"],
    financialStatus: json["financial_status"],
    fulfillmentStatus: json["fulfillment_status"] == null ? null : json["fulfillment_status"],
    gateway: json["gateway"] == null ? null : json["gateway"],
    landingSite: json["landing_site"],
    landingSiteRef: json["landing_site_ref"],
    locationId: json["location_id"],
    name: json["name"],
    note: json["note"] == null ? null : json["note"],
    noteAttributes: json["note_attributes"]==null?null:List<dynamic>.from(json["note_attributes"].map((x) => x)),
    number: json["number"],
    orderNumber: json["order_number"],
    orderStatusUrl: json["order_status_url"],
    originalTotalDutiesSet: json["original_total_duties_set"],
    paymentGatewayNames:json["payment_gateway_names"]==null?null: List<String>.from(json["payment_gateway_names"].map((x) => x)),
    phone: json["phone"] == null ? null : json["phone"],
    presentmentCurrency: json["presentment_currency"],
    processedAt: json["processed_at"],
    processingMethod: json["processing_method"],
    reference: json["reference"],
    referringSite: json["referring_site"],
    sourceIdentifier: json["source_identifier"],
    sourceName: json["source_name"],
    sourceUrl: json["source_url"],
    subtotalPrice: json["subtotal_price"],
    subtotalPriceSet:json["subtotal_price_set"]==null?null: Set.fromMap(json["subtotal_price_set"]),
    tags: json["tags"],
    taxLines:json["tax_lines"]==null?null: List<TaxLine>.from(json["tax_lines"].map((x) => TaxLine.fromMap(x))),
    taxesIncluded: json["taxes_included"],
    test: json["test"],
    token: json["token"],
    totalDiscounts: json["total_discounts"],
    totalDiscountsSet: json["total_discounts_set"]==null?null:Set.fromMap(json["total_discounts_set"]),
    totalLineItemsPrice: json["total_line_items_price"],
    totalLineItemsPriceSet: json["total_line_items_price_set"]==null?null:Set.fromMap(json["total_line_items_price_set"]),
    totalOutstanding: json["total_outstanding"],
    totalPrice: json["total_price"],
    totalPriceSet: json["total_price_set"]==null?null:Set.fromMap(json["total_price_set"]),
    totalPriceUsd: json["total_price_usd"],
    totalShippingPriceSet: json["total_shipping_price_set"]==null?null:Set.fromMap(json["total_shipping_price_set"]),
    totalTax: json["total_tax"],
    totalTaxSet:json["total_tax_set"] ==null?null:Set.fromMap(json["total_tax_set"]),
    totalTipReceived: json["total_tip_received"],
    totalWeight: json["total_weight"],
    updatedAt: json["updated_at"],
    userId: json["user_id"],
    billingAddress: json["billing_address"]==null?null:IngAddress.fromMap(json["billing_address"]),
    customer:json["customer"] ==null?null:Customer.fromMap(json["customer"]),
    discountApplications: json["discount_applications"]==null?null:List<DiscountApplication>.from(json["discount_applications"].map((x) => DiscountApplication.fromMap(x))),
    fulfillments: json["fulfillments"]==null?null:List<Fulfillment>.from(json["fulfillments"].map((x) => Fulfillment.fromMap(x))),
    lineItems: json["line_items"]==null?null:List<OrderLineItem>.from(json["line_items"].map((x) => OrderLineItem.fromMap(x))),
    refunds: json["refunds"]==null?null:List<Refund>.from(json["refunds"].map((x) => Refund.fromMap(x))),
    shippingAddress: json["shipping_address"]==null?null:IngAddress.fromMap(json["shipping_address"]),
    shippingLines:json["shipping_lines"] ==null?null:List<ShippingLine>.from(json["shipping_lines"].map((x) => ShippingLine.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "admin_graphql_api_id": adminGraphqlApiId,
    "app_id": appId,
    "browser_ip": browserIp,
    "buyer_accepts_marketing": buyerAcceptsMarketing,
    "cancel_reason": cancelReason == null ? null : cancelReason,
    "cancelled_at": cancelledAt == null ? null : cancelledAt,
    "cart_token": cartToken == null ? null : cartToken,
    "checkout_id": checkoutId,
    "checkout_token": checkoutToken,
    "client_details":clientDetails==null?null: clientDetails!.toMap(),
    "closed_at": closedAt == null ? null : closedAt,
    "confirmed": confirmed,
    "contact_email": contactEmail == null ? null : contactEmail,
    "created_at": createdAt,
    "currency": currency,
    "current_subtotal_price": currentSubtotalPrice,
    "current_subtotal_price_set": currentSubtotalPriceSet==null?null:currentSubtotalPriceSet!.toMap(),
    "current_total_discounts": currentTotalDiscounts,
    "current_total_discounts_set":currentTotalDiscountsSet==null?null: currentTotalDiscountsSet!.toMap(),
    "current_total_duties_set": currentTotalDutiesSet,
    "current_total_price": currentTotalPrice,
    "current_total_price_set":currentTotalPriceSet==null?null: currentTotalPriceSet!.toMap(),
    "current_total_tax": currentTotalTax,
    "current_total_tax_set":currentTotalTaxSet==null?null: currentTotalTaxSet!.toMap(),
    "customer_locale": customerLocale,
    "device_id": deviceId,
    "discount_codes":discountCodes==null?null: List<dynamic>.from(discountCodes!.map((x) => x.toMap())),
    "email": email,
    "estimated_taxes": estimatedTaxes,
    "financial_status": financialStatus,
    "fulfillment_status": fulfillmentStatus == null ? null : fulfillmentStatus,
    "gateway": gateway == null ? null : gateway,
    "landing_site": landingSite,
    "landing_site_ref": landingSiteRef,
    "location_id": locationId,
    "name": name,
    "note": note == null ? null : note,
    "note_attributes":noteAttributes==null?null: List<dynamic>.from(noteAttributes!.map((x) => x)),
    "number": number,
    "order_number": orderNumber,
    "order_status_url": orderStatusUrl,
    "original_total_duties_set": originalTotalDutiesSet,
    "payment_gateway_names":paymentGatewayNames==null?null: List<dynamic>.from(paymentGatewayNames!.map((x) => x)),
    "phone": phone == null ? null : phone,
    "presentment_currency": presentmentCurrency,
    "processed_at": processedAt,
    "processing_method": processingMethod,
    "reference": reference,
    "referring_site": referringSite,
    "source_identifier": sourceIdentifier,
    "source_name": sourceName,
    "source_url": sourceUrl,
    "subtotal_price": subtotalPrice,
    "subtotal_price_set":subtotalPriceSet==null?null: subtotalPriceSet!.toMap(),
    "tags": tags,
    "tax_lines":taxLines==null?null: List<dynamic>.from(taxLines!.map((x) => x.toMap())),
    "taxes_included": taxesIncluded,
    "test": test,
    "token": token,
    "total_discounts": totalDiscounts,
    "total_discounts_set": totalDiscountsSet==null?null:totalDiscountsSet!.toMap(),
    "total_line_items_price": totalLineItemsPrice,
    "total_line_items_price_set":totalLineItemsPriceSet==null?null: totalLineItemsPriceSet!.toMap(),
    "total_outstanding": totalOutstanding,
    "total_price": totalPrice,
    "total_price_set": totalPriceSet==null?null:totalPriceSet!.toMap(),
    "total_price_usd": totalPriceUsd,
    "total_shipping_price_set": totalShippingPriceSet==null?null:totalShippingPriceSet!.toMap(),
    "total_tax": totalTax,
    "total_tax_set": totalTaxSet==null?null:totalTaxSet!.toMap(),
    "total_tip_received": totalTipReceived,
    "total_weight": totalWeight,
    "updated_at": updatedAt,
    "user_id": userId,
    "billing_address":billingAddress==null?null: billingAddress!.toMap(),
    "customer":customer==null?null: customer!.toMap(),
    "discount_applications":discountApplications==null?null: List<dynamic>.from(discountApplications!.map((x) => x.toMap())),
    "fulfillments":fulfillments==null?null: List<dynamic>.from(fulfillments!.map((x) => x.toMap())),
    "line_items":lineItems==null?null: List<dynamic>.from(lineItems!.map((x) => x.toMap())),
    "refunds":refunds==null?null: List<dynamic>.from(refunds!.map((x) => x.toMap())),
    "shipping_address": shippingAddress==null?null:shippingAddress!.toMap(),
    "shipping_lines": shippingLines==null?null:List<dynamic>.from(shippingLines!.map((x) => x.toMap())),
  };
}

class IngAddress {
  IngAddress({
    this.firstName,
    this.address1,
    this.phone,
    this.city,
    this.zip,
    this.province,
    this.country,
    this.lastName,
    this.address2,
    this.company,
    this.latitude,
    this.longitude,
    this.name,
    this.countryCode,
    this.provinceCode,
  });

  String? firstName;
  String? address1;
  String? phone;
  String? city;
  dynamic? zip;
  String? province;
  String? country;
  String? lastName;
  String? address2;
  String? company;
  double? latitude;
  double? longitude;
  String? name;
  String? countryCode;
  String? provinceCode;

  factory IngAddress.fromJson(String str) => IngAddress.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IngAddress.fromMap(Map<String, dynamic> json) => IngAddress(
    firstName: json["first_name"],
    address1: json["address1"],
    phone: json["phone"],
    city: json["city"],
    zip: json["zip"],
    province: json["province"],
    country: json["country"],
    lastName: json["last_name"],
    address2: json["address2"],
    company: json["company"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    name: json["name"],
    countryCode: json["country_code"],
    provinceCode: json["province_code"],
  );

  Map<String, dynamic> toMap() => {
    "first_name": firstName,
    "address1": address1,
    "phone": phone,
    "city": city,
    "zip": zip,
    "province": province,
    "country": country,
    "last_name": lastName,
    "address2": address2,
    "company": company,
    "latitude": latitude,
    "longitude": longitude,
    "name": name,
    "country_code": countryCode,
    "province_code": provinceCode,
  };
}

class ClientDetails {
  ClientDetails({
    this.acceptLanguage,
    this.browserHeight,
    this.browserIp,
    this.browserWidth,
    this.sessionHash,
    this.userAgent,
  });

  String? acceptLanguage;
  int? browserHeight;
  String? browserIp;
  int? browserWidth;
  dynamic? sessionHash;
  String? userAgent;

  factory ClientDetails.fromJson(String str) => ClientDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClientDetails.fromMap(Map<String, dynamic> json) => ClientDetails(
    acceptLanguage: json["accept_language"],
    browserHeight: json["browser_height"],
    browserIp: json["browser_ip"],
    browserWidth: json["browser_width"],
    sessionHash: json["session_hash"],
    userAgent: json["user_agent"],
  );

  Map<String, dynamic> toMap() => {
    "accept_language": acceptLanguage,
    "browser_height": browserHeight,
    "browser_ip": browserIp,
    "browser_width": browserWidth,
    "session_hash": sessionHash,
    "user_agent": userAgent,
  };
}

class Set {
  Set({
    this.shopMoney,
    this.presentmentMoney,
  });

  Money? shopMoney;
  Money? presentmentMoney;

  factory Set.fromJson(String str) => Set.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Set.fromMap(Map<String, dynamic> json) => Set(
    shopMoney: Money.fromMap(json["shop_money"]),
    presentmentMoney: Money.fromMap(json["presentment_money"]),
  );

  Map<String, dynamic> toMap() => {
    "shop_money": shopMoney!.toMap(),
    "presentment_money": presentmentMoney!.toMap(),
  };
}

class Money {
  Money({
    this.amount,
    this.currencyCode,
  });

  String? amount;
  String? currencyCode;

  factory Money.fromJson(String str) => Money.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Money.fromMap(Map<String, dynamic> json) => Money(
    amount: json["amount"],
    currencyCode: json["currency_code"],
  );

  Map<String, dynamic> toMap() => {
    "amount": amount,
    "currency_code": currencyCode,
  };
}

class DefaultAddress {
  DefaultAddress({
    this.id,
    this.customerId,
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.province,
    this.country,
    this.zip,
    this.phone,
    this.name,
    this.provinceCode,
    this.countryCode,
    this.countryName,
    this.defaultAddressDefault,
  });

  int? id;
  int? customerId;
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? province;
  String? country;
  dynamic? zip;
  String? phone;
  String? name;
  String? provinceCode;
  String? countryCode;
  String? countryName;
  bool? defaultAddressDefault;

  factory DefaultAddress.fromJson(String str) => DefaultAddress.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DefaultAddress.fromMap(Map<String, dynamic> json) => DefaultAddress(
    id: json["id"],
    customerId: json["customer_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    company: json["company"],
    address1: json["address1"],
    address2: json["address2"],
    city: json["city"],
    province: json["province"],
    country: json["country"],
    zip: json["zip"],
    phone: json["phone"],
    name: json["name"],
    provinceCode: json["province_code"],
    countryCode: json["country_code"],
    countryName: json["country_name"],
    defaultAddressDefault: json["default"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "customer_id": customerId,
    "first_name": firstName,
    "last_name": lastName,
    "company": company,
    "address1": address1,
    "address2": address2,
    "city": city,
    "province": province,
    "country": country,
    "zip": zip,
    "phone": phone,
    "name": name,
    "province_code": provinceCode,
    "country_code": countryCode,
    "country_name": countryName,
    "default": defaultAddressDefault,
  };
}

class DiscountApplication {
  DiscountApplication({
    this.targetType,
    this.type,
    this.value,
    this.valueType,
    this.allocationMethod,
    this.targetSelection,
    this.code,
  });

  String? targetType;
  String? type;
  String? value;
  String? valueType;
  String? allocationMethod;
  String? targetSelection;
  String? code;

  factory DiscountApplication.fromJson(String str) => DiscountApplication.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DiscountApplication.fromMap(Map<String, dynamic> json) => DiscountApplication(
    targetType: json["target_type"],
    type: json["type"],
    value: json["value"],
    valueType: json["value_type"],
    allocationMethod: json["allocation_method"],
    targetSelection: json["target_selection"],
    code: json["code"],
  );

  Map<String, dynamic> toMap() => {
    "target_type": targetType,
    "type": type,
    "value": value,
    "value_type": valueType,
    "allocation_method": allocationMethod,
    "target_selection": targetSelection,
    "code": code,
  };
}

class DiscountCode {
  DiscountCode({
    this.code,
    this.amount,
    this.type,
  });

  String? code;
  String? amount;
  String? type;

  factory DiscountCode.fromJson(String str) => DiscountCode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DiscountCode.fromMap(Map<String, dynamic> json) => DiscountCode(
    code: json["code"],
    amount: json["amount"],
    type: json["type"],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "amount": amount,
    "type": type,
  };
}

class Fulfillment {
  Fulfillment({
    this.id,
    this.adminGraphqlApiId,
    this.createdAt,
    this.locationId,
    this.name,
    this.orderId,
    this.receipt,
    this.service,
    this.shipmentStatus,
    this.status,
    this.trackingCompany,
    this.trackingNumber,
    this.trackingNumbers,
    this.trackingUrl,
    this.trackingUrls,
    this.updatedAt,
    this.lineItems,
  });

  int? id;
  String? adminGraphqlApiId;
  String? createdAt;
  int? locationId;
  String? name;
  int? orderId;
  Receipt? receipt;
  String? service;
  dynamic? shipmentStatus;
  String? status;
  String? trackingCompany;
  String? trackingNumber;
  List<String>? trackingNumbers;
  String? trackingUrl;
  List<String>? trackingUrls;
  String? updatedAt;
  List<FulfillmentLineItem>? lineItems;

  factory Fulfillment.fromJson(String str) => Fulfillment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Fulfillment.fromMap(Map<String, dynamic> json) => Fulfillment(
    id: json["id"],
    adminGraphqlApiId: json["admin_graphql_api_id"],
    createdAt: json["created_at"],
    locationId: json["location_id"],
    name: json["name"],
    orderId: json["order_id"],
    receipt: Receipt.fromMap(json["receipt"]),
    service: json["service"],
    shipmentStatus: json["shipment_status"],
    status: json["status"],
    trackingCompany: json["tracking_company"],
    trackingNumber: json["tracking_number"],
    trackingNumbers: List<String>.from(json["tracking_numbers"].map((x) => x)),
    trackingUrl: json["tracking_url"],
    trackingUrls: List<String>.from(json["tracking_urls"].map((x) => x)),
    updatedAt: json["updated_at"],
    lineItems: List<FulfillmentLineItem>.from(json["line_items"].map((x) => FulfillmentLineItem.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "admin_graphql_api_id": adminGraphqlApiId,
    "created_at": createdAt,
    "location_id": locationId,
    "name": name,
    "order_id": orderId,
    "receipt": receipt!.toMap(),
    "service": service,
    "shipment_status": shipmentStatus,
    "status": status,
    "tracking_company": trackingCompany,
    "tracking_number": trackingNumber,
    "tracking_numbers": List<dynamic>.from(trackingNumbers!.map((x) => x)),
    "tracking_url": trackingUrl,
    "tracking_urls": List<dynamic>.from(trackingUrls!.map((x) => x)),
    "updated_at": updatedAt,
    "line_items": List<dynamic>.from(lineItems!.map((x) => x.toMap())),
  };
}

class FulfillmentLineItem {
  FulfillmentLineItem({
    this.id,
    this.adminGraphqlApiId,
    this.destinationLocation,
    this.fulfillableQuantity,
    this.fulfillmentService,
    this.fulfillmentStatus,
    this.giftCard,
    this.grams,
    this.name,
    this.originLocation,
    this.price,
    this.priceSet,
    this.productExists,
    this.productId,
    this.properties,
    this.quantity,
    this.requiresShipping,
    this.sku,
    this.taxable,
    this.title,
    this.totalDiscount,
    this.totalDiscountSet,
    this.variantId,
    this.variantInventoryManagement,
    this.variantTitle,
    this.vendor,
    this.taxLines,
    this.duties,
    this.discountAllocations,
  });

  int? id;
  String? adminGraphqlApiId;
  NLocation? destinationLocation;
  int? fulfillableQuantity;
  String? fulfillmentService;
  String? fulfillmentStatus;
  bool? giftCard;
  int? grams;
  String? name;
  NLocation? originLocation;
  String? price;
  Set? priceSet;
  bool? productExists;
  int? productId;
  List<PurpleProperty>? properties;
  int? quantity;
  bool? requiresShipping;
  String? sku;
  bool? taxable;
  String? title;
  String? totalDiscount;
  Set? totalDiscountSet;
  int? variantId;
  dynamic? variantInventoryManagement;
  String? variantTitle;
  String? vendor;
  List<TaxLine>? taxLines;
  List<dynamic>? duties;
  List<dynamic>? discountAllocations;

  factory FulfillmentLineItem.fromJson(String str) => FulfillmentLineItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FulfillmentLineItem.fromMap(Map<String, dynamic> json) => FulfillmentLineItem(
    id: json["id"],
    adminGraphqlApiId: json["admin_graphql_api_id"],
    destinationLocation: json["destination_location"] == null ? null : NLocation.fromMap(json["destination_location"]),
    fulfillableQuantity: json["fulfillable_quantity"],
    fulfillmentService: json["fulfillment_service"],
    fulfillmentStatus: json["fulfillment_status"],
    giftCard: json["gift_card"],
    grams: json["grams"],
    name: json["name"],
    originLocation: NLocation.fromMap(json["origin_location"]),
    price: json["price"],
    priceSet: Set.fromMap(json["price_set"]),
    productExists: json["product_exists"],
    productId: json["product_id"] == null ? null : json["product_id"],
    properties: List<PurpleProperty>.from(json["properties"].map((x) => PurpleProperty.fromMap(x))),
    quantity: json["quantity"],
    requiresShipping: json["requires_shipping"],
    sku: json["sku"],
    taxable: json["taxable"],
    title: json["title"],
    totalDiscount: json["total_discount"],
    totalDiscountSet: Set.fromMap(json["total_discount_set"]),
    variantId: json["variant_id"] == null ? null : json["variant_id"],
    variantInventoryManagement: json["variant_inventory_management"],
    variantTitle: json["variant_title"],
    vendor: json["vendor"],
    taxLines: List<TaxLine>.from(json["tax_lines"].map((x) => TaxLine.fromMap(x))),
    duties: List<dynamic>.from(json["duties"].map((x) => x)),
    discountAllocations: List<dynamic>.from(json["discount_allocations"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "admin_graphql_api_id": adminGraphqlApiId,
    "destination_location": destinationLocation == null ? null : destinationLocation!.toMap(),
    "fulfillable_quantity": fulfillableQuantity,
    "fulfillment_service": fulfillmentService,
    "fulfillment_status": fulfillmentStatus,
    "gift_card": giftCard,
    "grams": grams,
    "name": name,
    "origin_location": originLocation!.toMap(),
    "price": price,
    "price_set": priceSet!.toMap(),
    "product_exists": productExists,
    "product_id": productId == null ? null : productId,
    "properties": List<dynamic>.from(properties!.map((x) => x.toMap())),
    "quantity": quantity,
    "requires_shipping": requiresShipping,
    "sku": sku,
    "taxable": taxable,
    "title": title,
    "total_discount": totalDiscount,
    "total_discount_set": totalDiscountSet!.toMap(),
    "variant_id": variantId == null ? null : variantId,
    "variant_inventory_management": variantInventoryManagement,
    "variant_title": variantTitle,
    "vendor": vendor,
    "tax_lines": List<dynamic>.from(taxLines!.map((x) => x.toMap())),
    "duties": List<dynamic>.from(duties!.map((x) => x)),
    "discount_allocations": List<dynamic>.from(discountAllocations!.map((x) => x)),
  };
}

class NLocation {
  NLocation({
    this.id,
    this.countryCode,
    this.provinceCode,
    this.name,
    this.address1,
    this.address2,
    this.city,
    this.zip,
  });

  int? id;
  String? countryCode;
  String? provinceCode;
  String? name;
  String? address1;
  String? address2;
  String? city;
  String? zip;

  factory NLocation.fromJson(String str) => NLocation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NLocation.fromMap(Map<String, dynamic> json) => NLocation(
    id: json["id"],
    countryCode: json["country_code"],
    provinceCode: json["province_code"],
    name: json["name"],
    address1: json["address1"],
    address2: json["address2"],
    city: json["city"],
    zip: json["zip"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "country_code": countryCode,
    "province_code": provinceCode,
    "name": name,
    "address1": address1,
    "address2": address2,
    "city": city,
    "zip": zip,
  };
}

class PurpleProperty {
  PurpleProperty({
    this.name,
    this.value,
  });

  String? name;
  String? value;

  factory PurpleProperty.fromJson(String str) => PurpleProperty.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PurpleProperty.fromMap(Map<String, dynamic> json) => PurpleProperty(
    name: json["name"],
    value: json["value"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "value": value,
  };
}

class TaxLine {
  TaxLine({
    this.price,
    this.rate,
    this.title,
    this.priceSet,
    this.channelLiable,
  });

  String? price;
  double? rate;
  String? title;
  Set? priceSet;
  bool? channelLiable;

  factory TaxLine.fromJson(String str) => TaxLine.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TaxLine.fromMap(Map<String, dynamic> json) => TaxLine(
    price: json["price"],
    rate: json["rate"].toDouble(),
    title: json["title"],
    priceSet: Set.fromMap(json["price_set"]),
    channelLiable: json["channel_liable"],
  );

  Map<String, dynamic> toMap() => {
    "price": price,
    "rate": rate,
    "title": title,
    "price_set": priceSet!.toMap(),
    "channel_liable": channelLiable,
  };
}

class Receipt {
  Receipt();

  factory Receipt.fromJson(String str) => Receipt.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Receipt.fromMap(Map<String, dynamic> json) => Receipt(
  );

  Map<String, dynamic> toMap() => {
  };
}

class OrderLineItem {
  OrderLineItem({
    this.id,
    this.adminGraphqlApiId,
    this.fulfillableQuantity,
    this.fulfillmentService,
    this.fulfillmentStatus,
    this.giftCard,
    this.grams,
    this.name,
    this.originLocation,
    this.price,
    this.priceSet,
    this.productExists,
    this.productId,
    this.properties,
    this.quantity,
    this.requiresShipping,
    this.sku,
    this.taxable,
    this.title,
    this.totalDiscount,
    this.totalDiscountSet,
    this.variantId,
    this.variantInventoryManagement,
    this.variantTitle,
    this.vendor,
    this.taxLines,
    this.duties,
    this.discountAllocations,
    this.destinationLocation,
    this.product
  });

  Product? product;
  int? id;
  String? adminGraphqlApiId;
  int? fulfillableQuantity;
  String? fulfillmentService;
  String? fulfillmentStatus;
  bool? giftCard;
  int? grams;
  String? name;
  NLocation? originLocation;
  String? price;
  Set? priceSet;
  bool? productExists;
  int? productId;
  List<FluffyProperty>? properties;
  int? quantity=0;
  bool? requiresShipping;
  String? sku;
  bool? taxable;
  String? title;
  String? totalDiscount;
  Set? totalDiscountSet;
  int? variantId;
  dynamic? variantInventoryManagement;
  String? variantTitle;
  String? vendor;
  List<TaxLine>? taxLines;
  List<dynamic>? duties;
  List<DiscountAllocation>? discountAllocations;
  NLocation? destinationLocation;

  factory OrderLineItem.fromJson(String str) => OrderLineItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderLineItem.fromMap(Map<String, dynamic> json) => OrderLineItem(
    id: json["id"],
    product: json["product"]==null?null:Product.fromMap(json["product"]),
    adminGraphqlApiId: json["admin_graphql_api_id"],
    fulfillableQuantity: json["fulfillable_quantity"],
    fulfillmentService: json["fulfillment_service"],
    fulfillmentStatus: json["fulfillment_status"] == null ? null : json["fulfillment_status"],
    giftCard: json["gift_card"],
    grams: json["grams"],
    name: json["name"],
    originLocation:json["origin_location"]==null?null: NLocation.fromMap(json["origin_location"]),
    price: json["price"],
    priceSet: json["price_set"]==null?null:Set.fromMap(json["price_set"]),
    productExists: json["product_exists"],
    productId: json["product_id"] == null ? null : json["product_id"],
    properties:json["properties"] ==null?null:List<FluffyProperty>.from(json["properties"].map((x) => FluffyProperty.fromMap(x))),
    quantity: json["quantity"],
    requiresShipping: json["requires_shipping"],
    sku: json["sku"],
    taxable: json["taxable"],
    title: json["title"],
    totalDiscount: json["total_discount"],
    totalDiscountSet: json["total_discount_set"]==null?null:Set.fromMap(json["total_discount_set"]),
    variantId: json["variant_id"] == null ? null : json["variant_id"],
    variantInventoryManagement: json["variant_inventory_management"],
    variantTitle: json["variant_title"],
    vendor: json["vendor"],
    taxLines: json["tax_lines"]==null?null:List<TaxLine>.from(json["tax_lines"].map((x) => TaxLine.fromMap(x))),
    duties: json["duties"]==null?null:List<dynamic>.from(json["duties"].map((x) => x)),
    discountAllocations:json["discount_allocations"] ==null?null:List<DiscountAllocation>.from(json["discount_allocations"].map((x) => DiscountAllocation.fromMap(x))),
    destinationLocation: json["destination_location"] == null ? null : NLocation.fromMap(json["destination_location"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "product":product==null?null:product!.toMap(),
    "admin_graphql_api_id": adminGraphqlApiId,
    "fulfillable_quantity": fulfillableQuantity,
    "fulfillment_service": fulfillmentService,
    "fulfillment_status": fulfillmentStatus == null ? null : fulfillmentStatus,
    "gift_card": giftCard,
    "grams": grams,
    "name": name,
    "origin_location":originLocation==null?null: originLocation!.toMap(),
    "price": price,
    "price_set": priceSet==null?null:priceSet!.toMap(),
    "product_exists": productExists,
    "product_id": productId == null ? null : productId,
    "properties":properties==null?null: List<dynamic>.from(properties!.map((x) => x.toMap())),
    "quantity": quantity,
    "requires_shipping": requiresShipping,
    "sku": sku,
    "taxable": taxable,
    "title": title,
    "total_discount": totalDiscount,
    "total_discount_set":totalDiscountSet==null?null: totalDiscountSet!.toMap(),
    "variant_id": variantId == null ? null : variantId,
    "variant_inventory_management": variantInventoryManagement,
    "variant_title": variantTitle,
    "vendor": vendor,
    "tax_lines":taxLines==null?null: List<dynamic>.from(taxLines!.map((x) => x.toMap())),
    "duties":duties==null?null: List<dynamic>.from(duties!.map((x) => x)),
    "discount_allocations": discountAllocations==null?null:List<dynamic>.from(discountAllocations!.map((x) => x.toMap())),
    "destination_location": destinationLocation == null ? null : destinationLocation!.toMap(),
  };
}

class DiscountAllocation {
  DiscountAllocation({
    this.amount,
    this.amountSet,
    this.discountApplicationIndex,
  });

  String? amount;
  Set? amountSet;
  int? discountApplicationIndex;

  factory DiscountAllocation.fromJson(String str) => DiscountAllocation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DiscountAllocation.fromMap(Map<String, dynamic> json) => DiscountAllocation(
    amount: json["amount"],
    amountSet: Set.fromMap(json["amount_set"]),
    discountApplicationIndex: json["discount_application_index"],
  );

  Map<String, dynamic> toMap() => {
    "amount": amount,
    "amount_set": amountSet!.toMap(),
    "discount_application_index": discountApplicationIndex,
  };
}

class FluffyProperty {
  FluffyProperty({
    this.name,
    this.value,
  });

  String? name;
  String? value;

  factory FluffyProperty.fromJson(String str) => FluffyProperty.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FluffyProperty.fromMap(Map<String, dynamic> json) => FluffyProperty(
    name: json["name"],
    value: json["value"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "value": value,
  };
}

class Refund {
  Refund({
    this.id,
    this.adminGraphqlApiId,
    this.createdAt,
    this.note,
    this.orderId,
    this.processedAt,
    this.restock,
    this.totalDutiesSet,
    this.userId,
    this.orderAdjustments,
    this.transactions,
    this.refundLineItems,
    this.duties,
  });

  int? id;
  String? adminGraphqlApiId;
  String? createdAt;
  dynamic? note;
  int? orderId;
  String? processedAt;
  bool? restock;
  Set? totalDutiesSet;
  int? userId;
  List<dynamic>? orderAdjustments;
  List<Transaction>? transactions;
  List<RefundLineItem>? refundLineItems;
  List<dynamic>? duties;

  factory Refund.fromJson(String str) => Refund.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Refund.fromMap(Map<String, dynamic> json) => Refund(
    id: json["id"],
    adminGraphqlApiId: json["admin_graphql_api_id"],
    createdAt: json["created_at"],
    note: json["note"],
    orderId: json["order_id"],
    processedAt: json["processed_at"],
    restock: json["restock"],
    totalDutiesSet: Set.fromMap(json["total_duties_set"]),
    userId: json["user_id"],
    orderAdjustments: List<dynamic>.from(json["order_adjustments"].map((x) => x)),
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromMap(x))),
    refundLineItems: List<RefundLineItem>.from(json["refund_line_items"].map((x) => RefundLineItem.fromMap(x))),
    duties: List<dynamic>.from(json["duties"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "admin_graphql_api_id": adminGraphqlApiId,
    "created_at": createdAt,
    "note": note,
    "order_id": orderId,
    "processed_at": processedAt,
    "restock": restock,
    "total_duties_set": totalDutiesSet!.toMap(),
    "user_id": userId,
    "order_adjustments": List<dynamic>.from(orderAdjustments!.map((x) => x)),
    "transactions": List<dynamic>.from(transactions!.map((x) => x.toMap())),
    "refund_line_items": List<dynamic>.from(refundLineItems!.map((x) => x.toMap())),
    "duties": List<dynamic>.from(duties!.map((x) => x)),
  };
}

class RefundLineItem {
  RefundLineItem({
    this.id,
    this.lineItemId,
    this.locationId,
    this.quantity,
    this.restockType,
    this.subtotal,
    this.subtotalSet,
    this.totalTax,
    this.totalTaxSet,
    this.lineItem,
  });

  int? id;
  int? lineItemId;
  dynamic? locationId;
  int? quantity;
  String? restockType;
  int? subtotal;
  Set? subtotalSet;
  int? totalTax;
  Set? totalTaxSet;
  RefundLineItemLineItem? lineItem;

  factory RefundLineItem.fromJson(String str) => RefundLineItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RefundLineItem.fromMap(Map<String, dynamic> json) => RefundLineItem(
    id: json["id"],
    lineItemId: json["line_item_id"],
    locationId: json["location_id"],
    quantity: json["quantity"],
    restockType: json["restock_type"],
    subtotal: json["subtotal"],
    subtotalSet: Set.fromMap(json["subtotal_set"]),
    totalTax: json["total_tax"],
    totalTaxSet: Set.fromMap(json["total_tax_set"]),
    lineItem: RefundLineItemLineItem.fromMap(json["line_item"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "line_item_id": lineItemId,
    "location_id": locationId,
    "quantity": quantity,
    "restock_type": restockType,
    "subtotal": subtotal,
    "subtotal_set": subtotalSet!.toMap(),
    "total_tax": totalTax,
    "total_tax_set": totalTaxSet!.toMap(),
    "line_item": lineItem!.toMap(),
  };
}

class RefundLineItemLineItem {
  RefundLineItemLineItem({
    this.id,
    this.adminGraphqlApiId,
    this.destinationLocation,
    this.fulfillableQuantity,
    this.fulfillmentService,
    this.fulfillmentStatus,
    this.giftCard,
    this.grams,
    this.name,
    this.originLocation,
    this.price,
    this.priceSet,
    this.productExists,
    this.productId,
    this.properties,
    this.quantity,
    this.requiresShipping,
    this.sku,
    this.taxable,
    this.title,
    this.totalDiscount,
    this.totalDiscountSet,
    this.variantId,
    this.variantInventoryManagement,
    this.variantTitle,
    this.vendor,
    this.taxLines,
    this.duties,
    this.discountAllocations,
  });

  int? id;
  String? adminGraphqlApiId;
  NLocation? destinationLocation;
  int? fulfillableQuantity;
  String? fulfillmentService;
  dynamic? fulfillmentStatus;
  bool? giftCard;
  int? grams;
  String? name;
  NLocation? originLocation;
  String? price;
  Set? priceSet;
  bool? productExists;
  dynamic? productId;
  List<FluffyProperty>? properties;
  int? quantity;
  bool? requiresShipping;
  String? sku;
  bool? taxable;
  String? title;
  String? totalDiscount;
  Set? totalDiscountSet;
  dynamic? variantId;
  dynamic? variantInventoryManagement;
  String? variantTitle;
  String? vendor;
  List<TaxLine>? taxLines;
  List<dynamic>? duties;
  List<DiscountAllocation>? discountAllocations;

  factory RefundLineItemLineItem.fromJson(String str) => RefundLineItemLineItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RefundLineItemLineItem.fromMap(Map<String, dynamic> json) => RefundLineItemLineItem(
    id: json["id"],
    adminGraphqlApiId: json["admin_graphql_api_id"],
    destinationLocation: json["destination_location"] == null ? null : NLocation.fromMap(json["destination_location"]),
    fulfillableQuantity: json["fulfillable_quantity"],
    fulfillmentService: json["fulfillment_service"],
    fulfillmentStatus: json["fulfillment_status"],
    giftCard: json["gift_card"],
    grams: json["grams"],
    name: json["name"],
    originLocation: NLocation.fromMap(json["origin_location"]),
    price: json["price"],
    priceSet: Set.fromMap(json["price_set"]),
    productExists: json["product_exists"],
    productId: json["product_id"],
    properties: List<FluffyProperty>.from(json["properties"].map((x) => FluffyProperty.fromMap(x))),
    quantity: json["quantity"],
    requiresShipping: json["requires_shipping"],
    sku: json["sku"],
    taxable: json["taxable"],
    title: json["title"],
    totalDiscount: json["total_discount"],
    totalDiscountSet: Set.fromMap(json["total_discount_set"]),
    variantId: json["variant_id"],
    variantInventoryManagement: json["variant_inventory_management"],
    variantTitle: json["variant_title"],
    vendor: json["vendor"],
    taxLines: List<TaxLine>.from(json["tax_lines"].map((x) => TaxLine.fromMap(x))),
    duties: List<dynamic>.from(json["duties"].map((x) => x)),
    discountAllocations: List<DiscountAllocation>.from(json["discount_allocations"].map((x) => DiscountAllocation.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "admin_graphql_api_id": adminGraphqlApiId,
    "destination_location": destinationLocation == null ? null : destinationLocation!.toMap(),
    "fulfillable_quantity": fulfillableQuantity,
    "fulfillment_service": fulfillmentService,
    "fulfillment_status": fulfillmentStatus,
    "gift_card": giftCard,
    "grams": grams,
    "name": name,
    "origin_location": originLocation!.toMap(),
    "price": price,
    "price_set": priceSet!.toMap(),
    "product_exists": productExists,
    "product_id": productId,
    "properties": List<dynamic>.from(properties!.map((x) => x.toMap())),
    "quantity": quantity,
    "requires_shipping": requiresShipping,
    "sku": sku,
    "taxable": taxable,
    "title": title,
    "total_discount": totalDiscount,
    "total_discount_set": totalDiscountSet!.toMap(),
    "variant_id": variantId,
    "variant_inventory_management": variantInventoryManagement,
    "variant_title": variantTitle,
    "vendor": vendor,
    "tax_lines": List<dynamic>.from(taxLines!.map((x) => x.toMap())),
    "duties": List<dynamic>.from(duties!.map((x) => x)),
    "discount_allocations": List<dynamic>.from(discountAllocations!.map((x) => x.toMap())),
  };
}

class Transaction {
  Transaction({
    this.id,
    this.adminGraphqlApiId,
    this.amount,
    this.authorization,
    this.createdAt,
    this.currency,
    this.deviceId,
    this.errorCode,
    this.gateway,
    this.kind,
    this.locationId,
    this.message,
    this.orderId,
    this.parentId,
    this.processedAt,
    this.receipt,
    this.sourceName,
    this.status,
    this.test,
    this.userId,
  });

  int? id;
  String? adminGraphqlApiId;
  String? amount;
  dynamic? authorization;
  String? createdAt;
  String? currency;
  dynamic? deviceId;
  dynamic? errorCode;
  String? gateway;
  String? kind;
  dynamic? locationId;
  String? message;
  int? orderId;
  int? parentId;
  String? processedAt;
  Receipt? receipt;
  String? sourceName;
  String? status;
  bool? test;
  dynamic? userId;

  factory Transaction.fromJson(String str) => Transaction.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
    id: json["id"],
    adminGraphqlApiId: json["admin_graphql_api_id"],
    amount: json["amount"],
    authorization: json["authorization"],
    createdAt: json["created_at"],
    currency: json["currency"],
    deviceId: json["device_id"],
    errorCode: json["error_code"],
    gateway: json["gateway"],
    kind: json["kind"],
    locationId: json["location_id"],
    message: json["message"],
    orderId: json["order_id"],
    parentId: json["parent_id"],
    processedAt: json["processed_at"],
    receipt: Receipt.fromMap(json["receipt"]),
    sourceName: json["source_name"],
    status: json["status"],
    test: json["test"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "admin_graphql_api_id": adminGraphqlApiId,
    "amount": amount,
    "authorization": authorization,
    "created_at": createdAt,
    "currency": currency,
    "device_id": deviceId,
    "error_code": errorCode,
    "gateway": gateway,
    "kind": kind,
    "location_id": locationId,
    "message": message,
    "order_id": orderId,
    "parent_id": parentId,
    "processed_at": processedAt,
    "receipt": receipt!.toMap(),
    "source_name": sourceName,
    "status": status,
    "test": test,
    "user_id": userId,
  };
}

class ShippingLine {
  ShippingLine({
    this.id,
    this.carrierIdentifier,
    this.code,
    this.deliveryCategory,
    this.discountedPrice,
    this.discountedPriceSet,
    this.phone,
    this.price,
    this.priceSet,
    this.requestedFulfillmentServiceId,
    this.source,
    this.title,
    this.taxLines,
    this.discountAllocations,
  });

  int? id;
  dynamic? carrierIdentifier;
  String? code;
  dynamic? deliveryCategory;
  String? discountedPrice;
  Set? discountedPriceSet;
  dynamic? phone;
  String? price;
  Set? priceSet;
  dynamic? requestedFulfillmentServiceId;
  String? source;
  String? title;
  List<TaxLine>? taxLines;
  List<dynamic>? discountAllocations;

  factory ShippingLine.fromJson(String str) => ShippingLine.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShippingLine.fromMap(Map<String, dynamic> json) => ShippingLine(
    id: json["id"],
    carrierIdentifier: json["carrier_identifier"],
    code: json["code"],
    deliveryCategory: json["delivery_category"],
    discountedPrice: json["discounted_price"],
    discountedPriceSet: Set.fromMap(json["discounted_price_set"]),
    phone: json["phone"],
    price: json["price"],
    priceSet: Set.fromMap(json["price_set"]),
    requestedFulfillmentServiceId: json["requested_fulfillment_service_id"],
    source: json["source"],
    title: json["title"],
    taxLines: List<TaxLine>.from(json["tax_lines"].map((x) => TaxLine.fromMap(x))),
    discountAllocations: List<dynamic>.from(json["discount_allocations"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "carrier_identifier": carrierIdentifier,
    "code": code,
    "delivery_category": deliveryCategory,
    "discounted_price": discountedPrice,
    "discounted_price_set": discountedPriceSet!.toMap(),
    "phone": phone,
    "price": price,
    "price_set": priceSet!.toMap(),
    "requested_fulfillment_service_id": requestedFulfillmentServiceId,
    "source": source,
    "title": title,
    "tax_lines": List<dynamic>.from(taxLines!.map((x) => x.toMap())),
    "discount_allocations": List<dynamic>.from(discountAllocations!.map((x) => x)),
  };
}
