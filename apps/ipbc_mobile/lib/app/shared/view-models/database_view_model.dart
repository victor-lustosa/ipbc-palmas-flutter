/*import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../splash/blocs/database_bloc.dart';

class DatabaseViewModel {

  late HiveDatabaseConfigsDTO _data;
  final String fireDatabase = 'firebase';
  final String initialId = '000000000';

  HiveDatabaseConfigsDTO get data => _data;

  Future<HiveDatabaseConfigsDTO> validate(HiveDatabaseConfigsDTO dataParam) async {
    _data = dataParam;
    //if ((ValidationUtil.validationDatasource() == fireDatabase) || (_data.fireId == initialId)) {
    if (_data.fireId != initialId) {
      String fireId = await Modular.get<SupabaseDatasource>().verifyUpdateDatasource();
      if ((_data.fireId != fireId) && fireId.isNotEmpty) {
        _data = HiveDatabaseConfigsDTO.empty().copyWith(fireId: fireId);
      }
    }
    return _data;
  }

  bool isNotUpdated(String path) {
    switch (path.split('/')[0]) {
      case 'saturday-services':
        return !_data.isSaturdayCollectionUpdated;
      case 'sunday-morning-services':
        return !_data.isSundayMorningCollectionUpdated;
      case 'sunday-evening-services':
        return !_data.isSundayEveningCollectionUpdated;
      default:
        return true;
    }
  }

  checkUpdateData(BuildContext context, String path) {
    switch (path.split('/')[0]) {
      case 'saturday-services':
        if (!_data.isSaturdayCollectionUpdated) {
          _data = _data.copyWith(isSaturdayCollectionUpdated: true);
        }
        break;
      case 'sunday-morning-services':
        if (!_data.isSundayMorningCollectionUpdated) {
          _data = _data.copyWith(isSundayMorningCollectionUpdated: true);
        }
        break;
      case 'sunday-evening-services':
        if (!_data.isSundayEveningCollectionUpdated) {
          _data = _data.copyWith(isSundayEveningCollectionUpdated: true);
        }
        break;
      case 'services':
        if (!_data.isServicesUpdated) {
          _data = _data.copyWith(isServicesUpdated: true);
        }
        break;
      case 'lyrics':
        if (!_data.isLyricsUpdated) {
          _data = _data.copyWith(isLyricsUpdated: true);
        }
        break;
    }
    Modular.get<DatabaseBloc>().add(UpdateDataEvent(data: _data));
  }
}*/
