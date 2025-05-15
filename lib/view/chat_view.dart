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

  WebViewController? controller;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(
          Uri.parse('https://tawk.to/chat/6117bbf0d6e7610a49b02b9e/1fd2bc95j'));
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(App_Localization.of(context).translate("l_c_title")),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child:  loading
              ? CircularProgressIndicator()
              : WebViewWidget(controller: controller!),
          // child: WebView(
          //   initialUrl: "https://tawk.to/chat/6117bbf0d6e7610a49b02b9e/1fd2bc95j",
          //   javascriptMode: JavascriptMode.unrestricted,
          // ),
        ),
      ),
    );
  }
}

