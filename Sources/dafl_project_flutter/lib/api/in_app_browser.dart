import 'dart:io';
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
    if (url!.origin + url.path == MyApp.api.redirectUri) {
      try {
        await MyApp.api.requestUserAuthorization(url);
        await MyApp.api.getPlaylist();
      } on ApiException {
        // TODO : add notification to show that an error occured
      } finally {
        close();
      }
    }
  }
}
