import 'dart:async';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../shared/components/utils/analytics_util.dart';
import '../../../splash/presentation/blocs/database_bloc.dart';
import '../../../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';

class LyricsViewModel {
  LyricsViewModel({required this.analyticsUtil});

  final AnalyticsUtil analyticsUtil;
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
      analyticsUtil.recordError(error:e, st:st,name: 'lyric view model');
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

  updateData(BuildContext context, String path) {
    switch (path.split('/')[0]) {
      case 'saturday-services':
        data = data.copyWith(isSaturdayCollectionUpdated: true);
        break;
      case 'sunday-morning-services':
        data = data.copyWith(isSundayMorningCollectionUpdated: true);
        break;
      case 'sunday-evening-services':
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
