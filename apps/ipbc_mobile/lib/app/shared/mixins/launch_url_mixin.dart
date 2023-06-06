import 'package:url_launcher/url_launcher.dart';

mixin LaunchUrlMixin {
  Future<void> launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw Exception('Não foi possível acessar o domínio $url');
    }
  }
}
