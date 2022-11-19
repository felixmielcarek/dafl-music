import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../exceptions/api_exception.dart';
import '../main.dart';

class MyInAppBrowser extends InAppBrowser {
  var options = InAppBrowserClassOptions(
      crossPlatform:
          InAppBrowserOptions(hideUrlBar: true, hideToolbarTop: true),
      inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)));

  MyInAppBrowser() {
    _debugBrowser();
    openUrlRequest(
        urlRequest: URLRequest(url: MyApp.api.urlAuthorize), options: options);
  }

  _debugBrowser() async {
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
  }

  @override
  Future onLoadStart(url) async {
    bool isError = false;
    if (url!.origin + url.path == MyApp.api.redirectUri) {
      try {
        await MyApp.api.requestUserAuthorization(url);
      } on ApiException {
        notify(5, MyApp.controller.navigatorKey);
        isError = true;
      } finally {
        close();
        if (!isError) notify(2, MyApp.controller.navigatorKey, isError: false);
      }
    }
  }
}
