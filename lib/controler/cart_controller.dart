import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/helper/store.dart';
import 'package:albassel_version_1/model/my_order.dart';
import 'package:albassel_version_1/my_model/discount_code.dart';
import 'package:albassel_version_1/my_model/my_api.dart';
import 'package:albassel_version_1/my_model/my_product.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
//user type 0:user 1:salon 2:Wholesaler
class CartController extends GetxController{

  Rx<String> total="0.00".obs,sub_total="0.00".obs,shipping=Global.shipping.amount.toString().obs,tax="0.00".obs,coupon="0.00".obs,couponAutoDiscount="0.00".obs,discount="0.00".obs;
  DiscountCode? discountCode ;
  var canDiscountCode = false.obs;
  double amountOfCanDiscount=0;
  var my_order = <MyOrder>[].obs;
  var auto_discount = <MyOrder>[].obs;
  var rate = <MyOrder>[].obs;

  var loading = false.obs;
  int canDiscountCount = 0;
  TextEditingController discountCodeController = TextEditingController();

  apply(BuildContext context){
    try{
      if(discountCodeController.text.isEmpty){

      }else{
        MyApi.check_internet().then((net) {
          if(net){
            loading.value=true;
            MyApi.discountCode(discountCodeController.text).then((value) {
              if(value!=null){
                loading.value=false;
                discountCode=value;
                discount = discountCode!.persent.toString().obs;
                App.sucss_msg(context, App_Localization.of(context).translate("discount_code_succ"));
                get_total();
              }else{
                discountCodeController.clear();
                loading.value=false;
                App.error_msg(context, App_Localization.of(context).translate("discount_code_err"));
              }
            });
          }else{
            Get.to(()=>NoInternet())!.then((value) {
              apply(context);
            });
          }
        });

      }

    }catch (e){
      print(e.toString());
      loading.value=false;
      App.error_msg(context, App_Localization.of(context).translate("wrong"));
    }
  }
  bool add_to_cart(MyProduct product , int count,BuildContext context){
    print(product.availability>0);
    print(product.availability);
    if(product.availability>0){
      for(int i=0;i<my_order.length;i++){
        if(my_order[i].product.value.id==product.id){
          if(my_order[i].quantity.value+count<=product.availability){
            App.sucss_msg(context, App_Localization.of(context).translate("cart_msg"));
            my_order[i].quantity.value = my_order[i].quantity.value + count;
            double x = (my_order[i].quantity.value * double.parse(product.price.toString())) as double;
            my_order[i].price.value = x.toString();
            get_total();
            return true;
          }else{
            return false;
          }
        }
      }
      App.sucss_msg(context, App_Localization.of(context).translate("cart_msg"));
      double x = (count * double.parse(product.price.toString())) as double;
      MyOrder myOrder = MyOrder(product:product.obs,quantity:count.obs,price:x.toString().obs);
      my_order.add(myOrder);
      get_total();
      return true;
    }else{
      App.error_msg(context, App_Localization.of(context).translate("out_of_stock"));
      return false;
    }
  }

  add_to_rate(MyProduct product , int count){
      for(int i=0;i<rate.length;i++){
        if(rate[i].product.value.id==product.id){
          rate[i].quantity.value = rate[i].quantity.value + count;
          // double x = (my_order[i].quantity.value * double.parse(product.price.toString())) as double;
          rate[i].price.value = "0.0";
          get_total();
          return ;
        }
      }
      // double x = (count * double.parse(product.price.toString())) as double;
      MyOrder myOrder = MyOrder(product:product.obs,quantity:count.obs,price:"0.0".obs);
      rate.add(myOrder);
  }

  clear_cart(){
    my_order.clear();
    discount.value = "0.0";
    canDiscountCount = 0;
    discountCode = null;
    Store.save_discount_code("non");
    discountCodeController.clear();
    get_total();
  }

  increase(MyOrder myOrder,index){
    if(myOrder.product.value.availability>my_order[index].quantity.value){
      my_order[index].quantity.value++;
      double x =  (my_order[index].quantity.value * double.parse(my_order[index].product.value.price.toString())) as double;
      my_order[index].price.value=x.toString();
      get_total();
    }
  }

  decrease(MyOrder myOrder,index){
    if(my_order[index].quantity.value>1){
      my_order[index].quantity.value--;
      double x =  (my_order[index].quantity.value *double.parse(my_order[index].product.value.price.toString())) as double;
      my_order[index].price.value=x.toString();
      get_total();
    }else{
      remove_from_cart(myOrder);
    }

  }
  remove_from_cart(MyOrder myOrder){
    my_order.removeAt(my_order.indexOf(myOrder));
    get_total();
  }
  autoDiscount(){
    List<MyOrder> list = <MyOrder>[];
    double x = 0.0;
    amountOfCanDiscount = 0;
    coupon.value = "0.0";
    for(int i=0;i<Global.auto_discounts.length;i++){
      if(Global.auto_discounts[i].is_product==1){
        for(int k=0;k<my_order.length;k++){
          if(Global.auto_discounts[i].productId==my_order[k].product.value.id){
            for(int j=0;j<Global.auto_discounts[i].products.length;j++){
              if(Global.auto_discounts[i].productId==my_order[k].product.value.id&&
                  Global.auto_discounts[i].minimumQuantity<=my_order[k].quantity.value&&
                  Global.auto_discounts[i].products[j].availability>0&&
                  Global.auto_discounts[i].products[j].availability>=Global.auto_discounts[i].products[j].count){
                int counter = (my_order[k].quantity.value/Global.auto_discounts[i].minimumQuantity).toInt();
                for(int y=0;y<counter;y++){
                  print('price '+ Global.auto_discounts[i].products[j].price.toString());
                  MyProduct mp = MyProduct(id: Global.auto_discounts[i].products[j].productId, subCategoryId: Global.auto_discounts[i].products[j].subCategoryId, brandId: -1, title: Global.auto_discounts[i].products[j].title,
                      subTitle: Global.auto_discounts[i].products[j].subTitle, description: Global.auto_discounts[i].products[j].description, price: Global.auto_discounts[i].products[j].price,
                      rate: Global.auto_discounts[i].products[j].rate, image: Global.auto_discounts[i].products[j].image, ratingCount: Global.auto_discounts[i].products[j].ratingCount,
                      availability: Global.auto_discounts[i].products[j].availability, offer_price: Global.auto_discounts[i].products[j].offerPrice, category_id: -1,sku: Global.auto_discounts[i].products[j].sku);
                  list.add(MyOrder(product: mp.obs, quantity: Global.auto_discounts[i].products[j].count.obs, price:( (Global.auto_discounts[i].products[j].price*Global.auto_discounts[i].products[j].count).toString()).obs));
                  x +=  Global.auto_discounts[i].products[j].price*Global.auto_discounts[i].products[j].count;
                }

              }
            }
          }
        }
      }else{
        List<MyOrder> temp = <MyOrder>[];
        int count = 0;
        for(int k=0;k<my_order.length;k++){
          if(my_order[k].product.value.category_id==Global.auto_discounts[i].category_id||
              my_order[k].product.value.subCategoryId==Global.auto_discounts[i].sub_category_id||
              my_order[k].product.value.brandId==Global.auto_discounts[i].brand_id){
            count += my_order[k].quantity.value;
            temp.add(MyOrder(product: my_order[k].product, quantity:my_order[k].quantity, price:my_order[k].price));
            x +=  double.parse(my_order[k].price.value);
          }
        }
        if(count>=Global.auto_discounts[i].minimumQuantity){
          list.addAll(temp);
        }
      }
    }
    auto_discount.value = list;
    // print(list.length);
    // print('auto coupon');
    couponAutoDiscount = x.toString().obs;
    // print(coupon.value);
  }
  get_total(){
    autoDiscount();
    double x=0,y=Global.shipping.amount;
    canDiscountCount=0;
    for (var elm in my_order) {
      if(canDicount(elm)){
        canDiscountCount+=elm.quantity.value;
        amountOfCanDiscount+=double.parse(elm.price.value);
      }
      x += double.parse(elm.price.value);
    }
    sub_total.value=x.toString();
    if(x>Global.shipping.minAmountFree){
      y=0;
      shipping.value="0.00";
    }else{
      y=Global.shipping.amount;
      shipping.value=Global.shipping.amount.toString();
    }

    double z = calcDicount();
    if(discountCode != null){
      if(amountOfCanDiscount>=discountCode!.minimumQuantity){
        canDiscountCode.value = true;
      }else{
        canDiscountCode.value = false;
      }
    }
    coupon.value = (double.parse(coupon.value)+z).toString();
    tax.value = ((x - z)*5/105).toString();
    total.value = (x + y - z).toString();

    Store.save_order(my_order.value);
  }

  double calcDicount(){
    double sum = 0.0;
    if(discountCode!=null) {
      if(discountCode!.minimumQuantity<=double.parse(sub_total.value)){
          if(discountCode!.persent>0.0&&amountOfCanDiscount>=discountCode!.minimumQuantity){
          for(int i=0;i<my_order.length;i++){
              print(my_order[i].discount.value);
            sum+= double.parse(my_order[i].discount.value);
            }

            return sum;
          }

        if(discountCode!.amount>0.0&&(discountCode!.amount)<double.parse(sub_total.value)&&amountOfCanDiscount>=discountCode!.minimumQuantity){
            sum = discountCode!.amount.toDouble();
            return sum;
          }
        }
    }

    return 0;
  }

  bool canDicount(MyOrder item){
    if(discountCode==null) {
      return false;
    }
    MyProduct myProduct = item.product.value;
    if(discountCode!.forAll==1){
      calcDiscountForItem(item);
      return true;
    }
    for(int i=0;i<discountCode!.products.length;i++){
      if(discountCode!.products[i].productId==myProduct.id){
        calcDiscountForItem(item);
        return true;
      }
    }
    for(int i=0;i<discountCode!.brands.length;i++){
      if(discountCode!.brands[i].brandId==myProduct.brandId){
        calcDiscountForItem(item);
        return true;
      }
    }
    for(int i=0;i<discountCode!.category.length;i++){
      if(discountCode!.category[i].categoryId==myProduct.category_id){
        calcDiscountForItem(item);
        return true;
      }
    }
    for(int i=0;i<discountCode!.subCategory.length;i++){
      if(discountCode!.subCategory[i].subCategoryId==myProduct.subCategoryId){
        calcDiscountForItem(item);
        return true;
      }
    }

    return false;
  }
  calcDiscountForItem(MyOrder item){
    if(discountCode!=null) {
      if(discountCode!.persent>0){
        item.discount.value =
            (double.parse(item.price.value) * discountCode!.persent / 100)
                .toString();
      }

    }
  }
}