import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

import '../../../core_module.dart';

mixin ConnectivityMixin{
  Future<bool> isConnected() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        return true;
      } else {
        return false;
      }
    } on PlatformException catch (e, st) {
      AnalyticsUtil.recordError(error: e, st: st, name: 'lyric view model');
      throw Exception();
    }
  }
}