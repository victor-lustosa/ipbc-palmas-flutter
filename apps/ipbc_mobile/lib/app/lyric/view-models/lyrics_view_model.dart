import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_module/core_module.dart' hide ModularWatchExtension;
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

import '../../../main.dart';
import '../../splash/blocs/database_bloc.dart';

class LyricsViewModel {
  LyricsViewModel({required this.analyticsUtil});

  final AnalyticsUtil analyticsUtil;
  static int chorusController = 0;
  static bool previousChorus = false;
  late HiveDatabaseConfigsDTO data;
  final TextEditingController formFieldController = TextEditingController();

  initData(BuildContext context) {
    data = GInstances.getIt<HiveDatabaseConfigsDTO>();
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
      analyticsUtil.recordError(error: e, st: st, name: 'lyric view model');
      throw Exception();
    }
  }

  bool isNotUpdated(String path) {
    switch (path.split('/')[0]) {
      case 'saturday-services':
        return !data.isSaturdayCollectionUpdated;
      case 'sunday-morning-services':
        return !data.isSundayMorningCollectionUpdated;
      case 'sunday-evening-services':
        return !data.isSundayEveningCollectionUpdated;
      default:
        return true;
    }
  }

  checkUpdateData(BuildContext context, String path) {
    switch (path.split('/')[0]) {
      case 'saturday-services':
        if (!data.isSaturdayCollectionUpdated) {
          data = data.copyWith(isSaturdayCollectionUpdated: true);
        }
        break;
      case 'sunday-morning-services':
        if (!data.isSundayMorningCollectionUpdated) {
          data = data.copyWith(isSundayMorningCollectionUpdated: true);
        }
        break;
      case 'sunday-evening-services':
        if (!data.isSundayEveningCollectionUpdated) {
          data = data.copyWith(isSundayEveningCollectionUpdated: true);
        }
        break;
      case 'services':
        if (!data.isServicesUpdated) {
          data = data.copyWith(isServicesUpdated: true);
        }
        break;
      case 'lyrics':
        if (!data.isLyricsUpdated) {
          data = data.copyWith(isLyricsUpdated: true);
        }
        break;
    }
    Modular.get<DatabaseBloc>().add(UpdateDataEvent(data: data));
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
  fetchingSearch(){
    //print('chegueii');
  }
}
