import 'package:albassel_version_1/helper/api_v2.dart';
import 'package:albassel_version_1/model_v2/address.dart';
import 'package:get/get.dart';

class MyAddressController extends GetxController{

  RxBool loading = false.obs;
  List<Address> address = [];


  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData()async{
    loading(true);
    address = await ApiV2.getAddress();
    loading(false);
    return ;
  }

  deleteAddress(int AddressId)async{
    loading(true);
    await ApiV2.deleteAddress(AddressId);
    getData();
  }

}