//import 'dart:math' show Random;

import 'package:core_module/core_module.dart';
import 'package:flutter/services.dart';
//import 'package:uno/uno.dart';

import '../../core/infra/adapters/supa/supa_event_adapter.dart';
//import '../../core/infra/models/event_model.dart';

class SupaEventsUtil {
  static Future<List<EventEntity>> loadEventsList(String path) async {
    final String json = await rootBundle.loadString(path);
    return SupaEventAdapter.fromJsonList(json);
  }
}
