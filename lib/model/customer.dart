import 'dart:convert';
import 'order.dart';

class Customer {
  Customer({
    this.id,
    this.email,
    this.acceptsMarketing,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.ordersCount,
    this.state,
    this.totalSpent,
    this.lastOrderId,
    this.note,
    this.verifiedEmail,
    this.multipassIdentifier,
    this.taxExempt,
    this.phone,
    this.tags,
    this.lastOrderName,
    this.currency,
    this.acceptsMarketingUpdatedAt,
    this.marketingOptInLevel,
    this.taxExemptions,
    this.adminGraphqlApiId,
    this.defaultAddress,
  });

  int? id;
  String? email;
  bool? acceptsMarketing;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  int? ordersCount;
  String? state;
  String? totalSpent;
  int? lastOrderId;
  dynamic? note;
  bool? verifiedEmail;
  dynamic? multipassIdentifier;
  bool? taxExempt;
  String? phone;
  String? tags;
  String? lastOrderName;
  String? currency;
  String? acceptsMarketingUpdatedAt;
  String? marketingOptInLevel;
  List<dynamic>? taxExemptions;
  String? adminGraphqlApiId;
  DefaultAddress? defaultAddress;

  factory Customer.fromJson(String str) => Customer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
    id: json["id"],
    email: json["email"] == null ? null : json["email"],
    acceptsMarketing: json["accepts_marketing"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    ordersCount: json["orders_count"],
    state: json["state"],
    totalSpent: json["total_spent"],
    lastOrderId: json["last_order_id"],
    note: json["note"],
    verifiedEmail: json["verified_email"],
    multipassIdentifier: json["multipass_identifier"],
    taxExempt: json["tax_exempt"],
    phone: json["phone"] == null ? null : json["phone"],
    tags: json["tags"],
    lastOrderName: json["last_order_name"],
    currency: json["currency"],
    acceptsMarketingUpdatedAt: json["accepts_marketing_updated_at"],
    marketingOptInLevel: json["marketing_opt_in_level"] == null ? null : json["marketing_opt_in_level"],
    taxExemptions: List<dynamic>.from(json["tax_exemptions"].map((x) => x)),
    adminGraphqlApiId: json["admin_graphql_api_id"],
    defaultAddress: json["default_address"]==null?null:DefaultAddress.fromMap(json["default_address"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "email": email == null ? null : email,
    "accepts_marketing": acceptsMarketing,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "first_name": firstName,
    "last_name": lastName,
    "orders_count": ordersCount,
    "state": state,
    "total_spent": totalSpent,
    "last_order_id": lastOrderId,
    "note": note,
    "verified_email": verifiedEmail,
    "multipass_identifier": multipassIdentifier,
    "tax_exempt": taxExempt,
    "phone": phone == null ? null : phone,
    "tags": tags,
    "last_order_name": lastOrderName,
    "currency": currency,
    "accepts_marketing_updated_at": acceptsMarketingUpdatedAt,
    "marketing_opt_in_level": marketingOptInLevel == null ? null : marketingOptInLevel,
    "tax_exemptions": List<dynamic>.from(taxExemptions!.map((x) => x)),
    "admin_graphql_api_id": adminGraphqlApiId,
    "default_address": defaultAddress!.toMap(),
  };
}