import 'package:flutter/services.dart';

mixin ClipboardMixin {
  Future<void> copy(String value) async {
    await Clipboard.setData(ClipboardData(text: value));
  }

  Future<String> paste() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    return clipboardData?.text ?? '';
  }

  Future<bool> hasData() async {
    return Clipboard.hasStrings();
  }
}
