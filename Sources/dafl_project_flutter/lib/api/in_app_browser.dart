import 'dart:io';
import 'package:dafl_project_flutter/api/track.dart';
import 'package:dafl_project_flutter/main.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
    if (url!.origin + url.path == MyApp.api.redirectUri) {
      await MyApp.api.requestUserAuthorization(url);
      close();
    }
  }
}
