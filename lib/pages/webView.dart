import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewLoad extends StatelessWidget {
  final String title;
  final String selectedUrl;

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  WebViewLoad({@required this.title, @required this.selectedUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subirah Payment'),
      ),
      body: WebView(
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
        },
      ),
    );
  }
}
