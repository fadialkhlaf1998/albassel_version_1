import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class CashewDetails extends StatefulWidget {
  @override
  CashewDetailsState createState() {
    return CashewDetailsState();
  }
}

class CashewDetailsState extends State<CashewDetails> {
  WebViewController? _controller ;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = WebViewController();
    _controller!..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadFlutterAsset('assets/cashew.html');
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cashew')),
      body:SafeArea(child: Center(
        child: loading
            ? CircularProgressIndicator()
            : WebViewWidget(controller: _controller!),
      ))
      // WebView(
      //   initialUrl: 'about:blank',
      //   backgroundColor: Colors.white,
      //   javascriptMode: JavascriptMode.unrestricted,
      //   onWebViewCreated: (WebViewController webViewController) {
      //     _controller = webViewController;
      //     _loadHtmlFromAssets();
      //   },
      // ),
    );
  }

  // _loadHtmlFromAssets() async {
  //   String fileText = await rootBundle.loadString('assets/cashew.html');
  //   _controller!.load(Uri.dataFromString(
  //       fileText,
  //       mimeType: 'text/html',
  //       encoding: Encoding.getByName('utf-8')
  //   ).toString());
  //   setState(() {
  //     loading = false;
  //   });
  // }
}