import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class InvoiceWebview extends StatefulWidget {
  final String url;
  const InvoiceWebview({super.key, required this.url});

  @override
  State<InvoiceWebview> createState() => _InvoiceWebviewState();
}

class _InvoiceWebviewState extends State<InvoiceWebview> {
  final PlatformWebViewController _controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams());

  @override
  void initState() {
    super.initState();
    _controller.loadRequest(
      LoadRequestParams(
        uri: Uri.parse(widget.url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlatformWebViewWidget(
        PlatformWebViewWidgetCreationParams(controller: _controller),
      ).build(context),
    );
  }
}
