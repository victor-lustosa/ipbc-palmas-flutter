import 'package:flutter/material.dart';

import '../../../core_module.dart';

mixin LocationExtractorMixin {

  Map<String, double>? extractLatLng(String url) {
    final regex = RegExp(r'@(-?\d+\.\d+),(-?\d+\.\d+)');
    final match = regex.firstMatch(url);

    if (match != null) {
      return {
        "lat": double.parse(match.group(1)!),
        "lng": double.parse(match.group(2)!),
      };
    }

    final regex2 = RegExp(r'\[null,null,(-?\d+\.\d+),(-?\d+\.\d+)\]');
    final match2 = regex2.firstMatch(url);

    if (match2 != null) {
      return {
        "lat": double.parse(match2.group(1)!),
        "lng": double.parse(match2.group(2)!),
      };
    }

    return null;
  }
}
