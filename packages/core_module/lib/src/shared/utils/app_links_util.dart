import 'package:app_links/app_links.dart';

class AppLinksUtil {

  final AppLinks _appLinks = AppLinks();

  /// Stream para callbacks de deep links enquanto o app está aberto
  Stream<String> get linkStream async* {
    yield* _appLinks.uriLinkStream.map((uri) => uri.toString());
  }

  /// Deep link quando o app é iniciado a partir de um link
  Future<String?> getInitialLink() async {
    final uri = await _appLinks.getInitialLink();
    return uri?.toString();
  }
}
