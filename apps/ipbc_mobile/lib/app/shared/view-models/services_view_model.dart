import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class ServicesViewModel {
  ServicesViewModel({
    required this.analyticsUtil
  });

  final AnalyticsUtil analyticsUtil;
  static int chorusController = 0;
  static bool previousChorus = false;
  final TextEditingController controller = TextEditingController();

  Future<bool> isConnected() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        return true;
      } else {
        return false;
      }
    } on PlatformException catch (e, st) {
      analyticsUtil.recordError(error: e, st: st, name: 'lyric view model');
      throw Exception();
    }
  }

  fetchingSearch() {
    //print('chegueii');
  }
}
