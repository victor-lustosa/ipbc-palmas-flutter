import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class LyricsViewModel {
  static int chorusController = 0;
  static bool previousChorus = false;

  LyricsViewModel();
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<bool> isConnected() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        return true;
      } else {
        return false;
      }
    } on PlatformException catch (e, st) {
      await FirebaseCrashlytics.instance
          .recordError(e, st, reason: 'a non-fatal error');
      throw Exception();
    }
  }

  static BorderRadius paintChorus(isChorus) {
    if (isChorus) {
      if (previousChorus == false) {
        if(chorusController == 0){
          previousChorus = true;
          chorusController + 1;
          return const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          );
        } else{
          return const BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          );
        }
      }else if (previousChorus == true) {
        return const BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        );
      } else if (previousChorus == true) {
        return const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        );
      }
      previousChorus = true;
      chorusController + 1;
      return const BorderRadius.all(Radius.circular(0));
    } else {
      chorusController = 0;
      previousChorus = false;
      return const BorderRadius.all(Radius.circular(0));
    }
    /* if (index == length) {
      previousChorus = false;
      return const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      );
    }

    if(isChorus && previousChorus){
      return const BorderRadius.all(
          Radius.circular(0)

      );
    }
    if(previousChorus == false){
      return const BorderRadius.all(
          Radius.circular(0)
      );
    }  */
  }
}
