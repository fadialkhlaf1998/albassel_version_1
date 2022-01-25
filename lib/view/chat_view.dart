import 'dart:io';

import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
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
        actions: [
          // IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios,color: Colors.white,),),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: WebView(
            initialUrl: "https://tawk.to/chat/61e95109b84f7301d32c07de/1fprm945c",
            // initialUrl: "https://community.shopify.com/c/shopify-apis-and-sdks/bd-p/shopify-apis-and-technology",
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}

