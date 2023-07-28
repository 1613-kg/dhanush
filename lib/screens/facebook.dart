import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class facebok extends StatefulWidget {
  const facebok({super.key});

  @override
  State<facebok> createState() => _facebok();
}

class _facebok extends State<facebok> {
  late final WebViewController _controller;

  void WebControl() {
    String url = "https://www.facebook.com/dhanushbrandmustardoil/";
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
        title: Text("Facebook"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
