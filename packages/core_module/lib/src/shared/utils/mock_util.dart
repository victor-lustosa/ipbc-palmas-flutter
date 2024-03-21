import 'dart:async';

import 'package:flutter/services.dart';

import '../../../core_module.dart';

class MockUtil {

  MockUtil._privateConstructor();

 static Future<T?> convertMockJson<T>(String path, String option) async {
    final String json = await rootBundle.loadString(path);
    switch (option) {
      case 'lyrics':
        return Future.value(SupaLyricAdapter.fromJson(json) as T?);
      case 'services':
        return Future.value(ServicesAdapter.fromJson(json) as T?);
    }
    return null;
  }
}
