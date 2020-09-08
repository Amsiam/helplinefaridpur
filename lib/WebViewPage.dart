import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPageView extends StatelessWidget {
  final String title;
  final String url;
  WebPageView({this.title, this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
      ),
      body: Builder(
        builder: (context) {
          return WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) {
              if (request.url.contains("mailto:")) {
                launch(request.url);
                return NavigationDecision.prevent;
              } else if (request.url.contains("tel:")) {
                launch(request.url);
                return NavigationDecision.prevent;
              } else if (request.url.contains("facebook.com")) {
                launch(request.url);
                return NavigationDecision.prevent;
              } else {
                return NavigationDecision.navigate;
              }
            },
          );
        },
      ),
    );
  }
}
