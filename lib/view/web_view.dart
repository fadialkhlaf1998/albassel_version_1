import 'dart:developer';
import 'dart:io';
import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  CashewResponse cashewResponse;
  MyWebView(this.cashewResponse);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<MyWebView> {

  CheckoutController checkoutController = Get.find();

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cashew"),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: WebView(
            initialUrl: widget.cashewResponse.paymentUrl,
            // initialUrl: "https://app.albaselco.com/",
            javascriptMode: JavascriptMode.unrestricted,
            gestureNavigationEnabled: true,
            onPageFinished: (value) {
              if(value == widget.cashewResponse.confirmationUrl){
                checkoutController.add_order_cashew(context);
              }else if(value == widget.cashewResponse.cancelUrl){
                App.error_msg(
                    context, App_Localization.of(context).translate("wrong"));
                Get.back();
              }
              // else{
              //   App.error_msg(
              //       context, App_Localization.of(context).translate("wrong"));
              //   Get.back();
              // }
            },
          ),
        ),
      ),
    );
  }
}


class CashewResponse {
  String paymentUrl;
  String confirmationUrl;
  String cancelUrl;

  CashewResponse({required this.paymentUrl,required this.confirmationUrl,required this.cancelUrl});
}

