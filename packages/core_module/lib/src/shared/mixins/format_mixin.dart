import 'package:core_module/core_module.dart';

mixin FormatMixin {

  String formatText(String text) {
    return removeDiacritics(text)
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), '_')
        .replaceAll(RegExp(r'[^a-z0-9_]+'), '');
  }
}
