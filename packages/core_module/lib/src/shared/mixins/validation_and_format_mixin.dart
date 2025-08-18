import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

mixin ValidationAndFormatMixin {
  final String firebaseDatabase = 'firebase';

  String validationDatasource() {
    switch (DateFormat('EEEE').format(DateTime.now())) {
      case 'Friday':
        return 'firebase';
      case 'Saturday':
        return 'firebase';
      case 'Sunday':
        return 'firebase';
      default:
        return 'hive';
    }
  }

  String formatText(String text) {
    return removeDiacritics(text)
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), '_')
        .replaceAll(RegExp(r'[^a-z0-9_]+'), '');
  }
}
