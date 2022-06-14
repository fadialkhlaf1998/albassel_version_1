import 'dart:io';
import 'package:albassel_version_1/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
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
        title: Text(App_Localization.of(context).translate("l_c_title")),
      ),
      resizeToAvoidBottomInset: true,
      body: const SafeArea(
        child: Center(
          child: WebView(
            initialUrl: "https://tawk.to/chat/6117bbf0d6e7610a49b02b9e/1fd2bc95j",
            // initialUrl: "https://community.shopify.com/c/shopify-apis-and-sdks/bd-p/shopify-apis-and-technology",
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}

