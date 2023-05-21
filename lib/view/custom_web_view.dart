import 'dart:developer';
import 'dart:io';
import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TabbyWebView extends StatefulWidget {
  String url;
  TabbyWebView(this.url);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<TabbyWebView> {

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
        title: Text("tabby"),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: WebView(
            initialUrl: this.widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            gestureNavigationEnabled: true,
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

