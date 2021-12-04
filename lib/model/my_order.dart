import 'package:albassel_version_1/model/product.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class MyOrder {
  Rx<Product> product;
  Rx<int> quantity;
  Rx<String> price;
  Rx<String> shipping;

  MyOrder(this.product, this.quantity, this.price,this.shipping);
}