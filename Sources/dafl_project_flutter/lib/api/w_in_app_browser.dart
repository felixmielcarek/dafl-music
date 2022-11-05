import 'dart:convert';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import './api.dart';

class MyInAppBrowser extends InAppBrowser {
  var options = InAppBrowserClassOptions(
      crossPlatform:
          InAppBrowserOptions(hideUrlBar: true, hideToolbarTop: true),
      inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)));

  Api api;

  MyInAppBrowser(this.api) {
    _debugBrowser();
    launchBrowser();
  }

  _debugBrowser() async {
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
  }

  launchBrowser() {
    openUrlRequest(urlRequest: URLRequest(url: api.url), options: options);
  }

  @override
  Future onBrowserCreated() async {}

  @override
  Future onLoadStart(url) async {
    if (url!.origin + url!.path == api.redirectUri) {
      api.verifyLogIn(url);
    }
    close();
  }

  @override
  Future onLoadStop(url) async {}

  @override
  void onLoadError(url, code, message) {}

  @override
  void onProgressChanged(progress) {}

  @override
  void onExit() {}
}
