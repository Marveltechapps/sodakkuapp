import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MobileHtmlView extends StatefulWidget {
  final String assetPath;
  const MobileHtmlView({super.key , required this.assetPath});

  @override
  State<MobileHtmlView> createState() => MobileHtmlViewState();
}

class MobileHtmlViewState extends State<MobileHtmlView> {
  static WebViewController controller = WebViewController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
              ..loadHtmlString(widget.assetPath);
  }
  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
