import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../main.dart';

class MyInAppBrowser extends InAppBrowser {
  var options = InAppBrowserClassOptions(
      crossPlatform:
          InAppBrowserOptions(hideUrlBar: true, hideToolbarTop: true),
      inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)));

  MyInAppBrowser() {
    _debugBrowser();
    openUrlRequest(
        urlRequest: URLRequest(url: MyApp.controller.getApiUrlAuthorize()),
        options: options);
  }

  _debugBrowser() async {
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
  }

  @override
  Future onLoadStart(url) async {
    bool isError = false;
    if (url!.origin + url.path == MyApp.controller.getApiRedirectUrl()) {
      try {
        await MyApp.controller.apiAuthorization(url);
      } catch (e) {
        notify(5, MyApp.controller.navigatorKey);
        isError = true;
      } finally {
        close();
        if (!isError) notify(2, MyApp.controller.navigatorKey, isError: false);
      }
    }
  }
}
