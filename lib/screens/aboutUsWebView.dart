import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class aboutUsWebView extends StatefulWidget {
  const aboutUsWebView({super.key});

  @override
  State<aboutUsWebView> createState() => _aboutUsWebViewState();
}

class _aboutUsWebViewState extends State<aboutUsWebView> {
  late final WebViewController _controller;

  void WebControl() {
    String url = "https://gargoilgroup.com/";
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (navigation) {
            if (navigation.url != url) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WebControl();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    WebControl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "About us",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
