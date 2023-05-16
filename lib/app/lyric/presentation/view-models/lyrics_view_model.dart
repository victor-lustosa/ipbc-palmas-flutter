import 'dart:async';
import 'package:provider/provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../../../splash/presentation/blocs/database_bloc.dart';
class LyricsViewModel {
  LyricsViewModel();

  static int chorusController = 0;
  static bool previousChorus = false;
  late HiveDatabaseConfigsDTO data;

  initData(BuildContext context){
    data = context.read<HiveDatabaseConfigsDTO>();
  }

  Future<bool> isConnected() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        return true;
      } else {
        return false;
      }
    } on PlatformException catch (e, st) {
      await FirebaseCrashlytics.instance.recordError(e, st, reason: 'a non-fatal error');
      throw Exception();
    }
  }

  bool isNotUpdated(String path) {
    switch (path.split('/')[0]) {
      case 'saturday-services':
        return !data.isSaturdayCollectionUpdated;
      case 'morning-sunday-services':
        return !data.isSundayMorningCollectionUpdated;
      case 'evening-sunday-services':
        return !data.isSundayEveningCollectionUpdated;
      default:
        return true;
    }
  }

  updateData(BuildContext context, String path) {
    switch (path.split('/')[0]) {
      case 'saturday-services':
        data = data.copyWith(isSaturdayCollectionUpdated: true);
        break;
      case 'morning-sunday-services':
        data = data.copyWith(isSundayMorningCollectionUpdated: true);
        break;
      case 'evening-sunday-services':
        data = data.copyWith(isSundayEveningCollectionUpdated: true);
        break;
      case 'services':
        data = data.copyWith(isServicesUpdated: true);
        break;
      case 'lyrics':
        data = data.copyWith(isLyricsUpdated: true);
        break;
    }
    context.read<DatabaseBloc>().add(UpdateDataEvent(data: data));
  }


  static BorderRadius paintChorus(isChorus) {
    if (isChorus) {
      if (previousChorus == false) {
        if (chorusController == 0) {
          previousChorus = true;
          chorusController + 1;
          return const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          );
        } else {
          return const BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          );
        }
      } else if (previousChorus == true) {
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
  }
}
