//import 'dart:math' show Random;

import 'package:core_module/core_module.dart';
import 'package:flutter/services.dart';

class SupaEventsUtil {
  SupaEventsUtil._();
  static Future<List<EventEntity>> loadEventsList(String path) async {
    final String json = await rootBundle.loadString(path);
    return EventAdapter.fromMapList(json);
  }
}
