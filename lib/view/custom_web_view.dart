import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TabbyWebView extends StatefulWidget {
  String url;
  TabbyWebView(this.url);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<TabbyWebView> {
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
          Uri.parse(this.widget.url));
    setState(() {
      loading = false;
    });
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
          child:  loading
              ? CircularProgressIndicator()
              : WebViewWidget(controller: controller!),
          // child: WebView(
          //   initialUrl: this.widget.url,
          //   javascriptMode: JavascriptMode.unrestricted,
          //   gestureNavigationEnabled: true,
          // ),
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

