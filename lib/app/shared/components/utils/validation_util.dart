import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;

import '../../../splash/presentation/blocs/database_bloc.dart';
import '../../../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';

class ValidationUtil {
  ValidationUtil({required BuildContext context}){
    data = context.read<HiveDatabaseConfigsDTO>();
  }
  final String firebaseDatabase = 'firebase';
  late  HiveDatabaseConfigsDTO data;
  static String validationDatasource() {
    switch (DateFormat('EEEE').format(DateTime.now())) {
      case 'Friday':
        return 'firebase';
      case 'Thursday':
        return 'hive';
      case 'Saturday':
        return 'firebase';
      case 'Sunday':
        return 'firebase';
      default:
        return 'hive';
    }
  }

   bool validateService(BuildContext context) {
    if (!data.isServicesUpdated) {
      data = data.copyWith(isServicesUpdated: true);
      context.read<DatabaseBloc>().add(UpdateDataEvent(data: data));
      return true;
    } else {
      return false;
    }
  }
  bool validateCollection(BuildContext context, String path) {
    if (!_checkCollectionType(path, context)) {
      data = data.copyWith(isServicesUpdated: true);
      context.read<DatabaseBloc>().add(UpdateDataEvent(data: data));
      return true;
    } else {
      return false;
    }
  }
  bool validateLyrics(BuildContext context) {
    if(!data.isLyricsUpdated){
      data = data.copyWith(isServicesUpdated: true);
      context.read<DatabaseBloc>().add(UpdateDataEvent(data: data));
      return true;
    } else {
      return false;
    }
  }

  bool _checkCollectionType(String type, BuildContext context) {
    List<String> params = type.split('/');
    switch (params[0]) {
      case 'saturday-services':
        return data.isSaturdayCollectionUpdated;
      case 'morning-sunday-services':
        return data.isSundayMorningCollectionUpdated;
      case 'evening-sunday-services':
        return data.isSundayEveningCollectionUpdated;
      default:
        return false;
    }
  }

  serviceType(BuildContext context, String path) {
    data = context.read<HiveDatabaseConfigsDTO>();
    List<String> params = path.split('/');
    switch (params[0]) {
      case 'saturday-services':
        data = data.copyWith(isSaturdayCollectionUpdated: true);
        break;
      case 'morning-sunday-services':
        data = data.copyWith(isSundayMorningCollectionUpdated: true);
        break;
      case 'evening-sunday-services':
        data = data.copyWith(isSundayEveningCollectionUpdated: true);
        break;
    }
    context.read<DatabaseBloc>().add(UpdateDataEvent(data: data));
  }
}
