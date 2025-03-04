import 'package:flutter/material.dart';
import 'package:core_module/core_module.dart';

class FacebookLoginView extends StatefulWidget {
  const FacebookLoginView({super.key});

  @override
  State<FacebookLoginView> createState() => _FacebookLoginViewState();
}

class _FacebookLoginViewState extends State<FacebookLoginView> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                if (progress > 0) {}
              },
              onPageStarted: (_) {},
              onPageFinished: (String url) {
                if (url.startsWith('https://www.youtube.com/')) {}
              },
              onHttpError: (_) {},
              onWebResourceError: (_) {},
              onNavigationRequest: (NavigationRequest request) {
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(
            Uri.parse(
              'https://xrvmfhpmelyvupfylnfk.supabase.co/auth/v1/authorize?provider=facebook',
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
