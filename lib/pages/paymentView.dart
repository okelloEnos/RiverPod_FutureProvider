import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWeb extends StatefulWidget {
  @override
  _PaymentWebState createState() => _PaymentWebState();
}

class _PaymentWebState extends State<PaymentWeb> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subirah Payment UI'),
      ),
      body:
      Stack(
        children: [
          WebView(
            initialUrl: "https://subirah.vercel.app/#/app/subscribe/:cus_JRRlLdHjM2ZbiC/:basic",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController){
              _controller.complete(webViewController);
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading ? Center(child: CircularProgressIndicator()) : Container()
        ],
      )
    );
  }
}
