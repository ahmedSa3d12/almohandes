import 'dart:collection';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';



class PrivacyTermsPage extends StatefulWidget {
  final String  url;

  const PrivacyTermsPage({Key? key, required this.url})
      : super(key: key);

  @override
  State<PrivacyTermsPage> createState() =>
      _PrivacyTermsPageState(url: url);
}

class _PrivacyTermsPageState extends State<PrivacyTermsPage> {
  String url;

  _PrivacyTermsPageState({required this.url});

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    late WebViewController _webController;



    return WebView(
      initialUrl:url,
      onPageStarted: (url) {

      },
      onWebViewCreated: (WebViewController webViewController) {
        webViewController.loadUrl(

         url,

        );
        _webController=webViewController;

        // _controller.complete(webViewController );
      },
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: (String url) {




      },
    );
  }
}
