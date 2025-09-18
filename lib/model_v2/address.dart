class AddressResponse {
  final int code;
  final String message;
  final List<Address> data;

  AddressResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      code: json['code'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class Address {
  final int id;
  final int userId;
  final int countryId;
  final int nick_name_status;
  final int shippingId;
  final String nickName;
  final String first_name;
  final String last_name;
  final String address;
  final String apartment;
  final String city;
  final String phone;
  final String country;
  final String isoCode;
  final String emirate;
  final double min_amount_free;
  final double amount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Address({
    required this.id,
    required this.userId,
    required this.countryId,
    required this.nick_name_status,
    required this.shippingId,
    required this.nickName,
    required this.first_name,
    required this.last_name,
    required this.address,
    required this.apartment,
    required this.city,
    required this.phone,
    required this.country,
    required this.isoCode,
    required this.emirate,
    required this.amount,
    required this.min_amount_free,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      nick_name_status: json['nick_name_status'] as int,
      countryId: json['country_id'] as int,
      shippingId: json['shipping_id'] as int,
      country: json['country'] as String,
      isoCode: json['iso_code'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      emirate: json['emirate'] as String,
      min_amount_free: double.parse(json['min_amount_free'].toString()),
      amount: double.parse(json['amount'].toString()),
      nickName: json['nick_name'] as String,
      address: json['address'] as String,
      apartment: json['apartment'] as String,
      city: json['city'] as String,
      phone: json['phone'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'country_id': countryId,
      'shipping_id': shippingId,
      'nick_name': nickName,
      'address': address,
      'apartment': apartment,
      'city': city,
      'phone': phone,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
