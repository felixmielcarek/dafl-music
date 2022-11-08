import 'dart:io';
import 'package:dafl_project_flutter/main.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'track.dart';

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
      String id = await MyApp.api.getCurrentlyPlayingTrack();
      Track track = await MyApp.api.getTrackInfo(id);
      print('${track.artist} ${track.name} ${track.albumImage}');
      close();
    }
  }
}
