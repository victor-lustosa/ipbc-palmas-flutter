import 'package:flutter/services.dart';

class ClipboardViewModel {
  ClipboardViewModel._();

  static Future<void> copy(String value) async {
    await Clipboard.setData(ClipboardData(
      text: value
    ));
  }

  static Future<String> paste() async {
    final ClipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    return ClipboardData?.text ?? '';
  }

  static Future<bool> hasData() async {
    return Clipboard.hasStrings();
  }
}