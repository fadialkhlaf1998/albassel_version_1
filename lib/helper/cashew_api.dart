import 'dart:convert';
import 'dart:developer';

import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/model/my_order.dart';
import 'package:albassel_version_1/model_v2/cart.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/view/web_view.dart';
import 'package:http/http.dart' as http;


class Cashew {

  static String cancelUrl = MyApi.url+"cashew-cancle";

  static Future<String?> getToken()async{
    var headers = {
      'Cashewsecretkey': 'ce4557294d36450dae5546288fbcbf68dbbb5a3c7426a8927230b838a86e17cd',
      'Storeurl': 'https://www.albaselco.com/'
    };
    var request = http.Request('POST', Uri.parse('https://api.cashewpayments.com/v1/identity/store/authorize'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = (await response.stream.bytesToString());
      return json.decode(data)['data']['token'];
    }
    else {
    print(response.reasonPhrase);
    return null;
    }

  }

  static Future<CashewResponse?> checkout({
    required String token,
    required String mobileNumber,
    required String email,
    required String firstName,
    required String lastName,
    required String address1,
    required String address2,
    required String state,
    required String city,
    required String country,
    required List<CartItem> cart,
    required double shipping,
  })async{
    List<Item> itemsList = <Item>[];

    double totalAmount =shipping;
    double taxAmount =0;
    for(int i=0;i<cart.length;i++){
      totalAmount+= (cart[i].totalPrice * cart[i].count);
      itemsList.add(
          Item(
              reference: cart[i].productId.toString(),
              name: cart[i].title,
              description: "",
              url: "",
              image: cart[i].image,
              unitPrice: cart[i].totalPrice,
              quantity: cart[i].count));
    }
    //Vat = 5 * price / 105
    taxAmount = 5 * (totalAmount - shipping) / 105;
    int orderId = DateTime.now().millisecondsSinceEpoch;
    // String confirmationUrl = "http://localhost/sdk/index.php/cashew-direct-integration/?payment_status=success&order_reference_id=$orderId";
    String confirmationUrl = MyApi.url+"cashew-confirm/${Global.customer!.id}";
    var headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://api.cashewpayments.com/v1/checkouts'));
    request.body = json.encode({
      "orderReference": "$orderId",
      "totalAmount": totalAmount,
      "taxAmount": taxAmount,
      "currencyCode": "AED",
      "customer": {
        "mobileNumber": mobileNumber,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "defaultAddress": {
          "firstName": firstName,
          "lastName": lastName,
          "address1": address1,
          "address2": address2,
          "city": city,
          "state": state,
          "country": country,
          "postalCode": ""
        }
      },
      "items": List<dynamic>.from(itemsList.map((x) => x.toMap())),
      "merchant": {
        "confirmationUrl": confirmationUrl,
        "cancelUrl": cancelUrl
      }
    });
    log(request.body.toString());
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      String data= (await response.stream.bytesToString());
      var res = json.decode(data)['data'];

      String paymentUrl =  "https://checkout.cashewpayments.com/${res['orderId']}?token=${Uri.encodeComponent(res['token'])}&storeToken=${Uri.encodeComponent(token)}";

      return CashewResponse(paymentUrl: paymentUrl, confirmationUrl: confirmationUrl, cancelUrl: cancelUrl);
    }
    else {
    print(response.reasonPhrase);
    String data= (await response.stream.bytesToString());
    print(data);
    return null;
    }

  }
}

class CashewItems {
  CashewItems({
    required this.items,
  });

  List<Item> items;

  factory CashewItems.fromJson(String str) => CashewItems.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CashewItems.fromMap(Map<String, dynamic> json) => CashewItems(
    items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "items": List<dynamic>.from(items.map((x) => x.toMap())),
  };
}

class Item {
  Item({
    required this.reference,
    required this.name,
    required this.description,
    required this.url,
    required this.image,
    required this.unitPrice,
    required this.quantity,
  });

  String reference;
  String name;
  String description;
  String url;
  String image;
  double unitPrice;
  int quantity;

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
    reference: json["reference"],
    name: json["name"],
    description: json["description"],
    url: json["url"],
    image: json["image"],
    unitPrice: json["unitPrice"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toMap() => {
    "reference": reference,
    "name": name,
    "description": description,
    "url": url,
    "image": image,
    "unitPrice": unitPrice,
    "quantity": quantity,
  };
}
