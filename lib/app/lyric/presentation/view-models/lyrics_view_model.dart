import 'dart:async';

import 'package:flutter/services.dart';
import 'dart:developer' as developer;
import '../../../shared/components/utils/validation_util.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../splash/presentation/blocs/database_bloc.dart';
import '../../infra/models/hive-dtos/hive_database_configs_dto.dart';

class LyricsViewModel {
  final String database = 'firebase';

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<bool> isConnected() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        return true;
      } else{
        return false;
      }
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      throw Exception();
    }
  }

  createInstances(DateTime dataUpdateAt) async {
    /*if (ValidationUtil.validationDatasource() == database || DateFormat('y').format(dataUpdateAt) != '2000') {
      DateTime fireUpdateAt = await ValidationUtil.verifyUpdateFirebase(context, dataUpdateAt);
      if(dataUpdateAt.isBefore(fireUpdateAt)){
        databaseBloc.add(AddDataEvent(path: url, data: DatabaseConfigsHiveDTO(updateAt: fireUpdateAt)));
      }
    }*/
  }
}
