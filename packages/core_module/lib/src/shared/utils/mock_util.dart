import 'dart:async';

import 'package:flutter/services.dart';

import '../../../core_module.dart';

class MockUtil {
  MockUtil._();

  static Future<T?> convertMockJson<T>(String path, String option) async {
    final String json = await rootBundle.loadString(path);
    switch (option) {
      case 'lyrics':
        return Future.value(LyricAdapter.fromJson(json) as T?);
      case 'services':
        return Future.value(ServicesAdapter.fromJson(json) as T?);
      case 'saturday-services' ||
          'sunday-morning-services' ||
          'sunday-evening-services':
        //return Future.value(ServiceAdapter.fromJsonList(json) as T?);
    }
    return null;
  }

  static String createId() => DateTime.now().microsecondsSinceEpoch.toString();

}
