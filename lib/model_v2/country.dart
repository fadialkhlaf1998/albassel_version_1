class CountryResponse {
  final int code;
  final String message;
  final List<Country> data;

  CountryResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory CountryResponse.fromJson(Map<String, dynamic> json) {
    return CountryResponse(
      code: json['code'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => Country.fromJson(item))
          .toList(),
    );
  }
}

class Country {
  final int id;
  final String name;
  final String isoCode;
  final String currency;
  final double amountPerDerham;
  final String createdAt;
  final String updatedAt;
  final List<Shipping> shipping;

  Country({
    required this.id,
    required this.name,
    required this.isoCode,
    required this.currency,
    required this.amountPerDerham,
    required this.createdAt,
    required this.updatedAt,
    required this.shipping,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      isoCode: json['iso_code'],
      currency: json['currency'],
      amountPerDerham: double.parse(json['amount_per_derham'].toString()),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      shipping: (json['shipping'] as List)
          .map((item) => Shipping.fromJson(item))
          .toList(),
    );
  }
}

class Shipping {
  final int id;
  final double amount;
  final int minAmountFree;
  final String emirate;
  final int countryId;

  Shipping({
    required this.id,
    required this.amount,
    required this.minAmountFree,
    required this.emirate,
    required this.countryId,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      id: json['id'],
      amount: (json['amount'] as num).toDouble(),
      minAmountFree: json['min_amount_free'],
      emirate: json['emirate'],
      countryId: json['country_id'],
    );
  }
}
