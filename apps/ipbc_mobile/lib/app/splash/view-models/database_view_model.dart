import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class DatabaseViewModel {

  final String fireDatabase = 'firebase';
  final String initialId = '000000000';

  Future<HiveDatabaseConfigsDTO> validate(BuildContext context, HiveDatabaseConfigsDTO data) async {
    if ((ValidationUtil.validationDatasource() == fireDatabase) || (data.fireId == initialId)) {
      String fireId = await Modular.get<FirestoreDatasource>().verifyUpdateDatasource();
      if ((data.fireId != fireId) && fireId.isNotEmpty) {
        data = HiveDatabaseConfigsDTO.empty().copyWith(fireId: fireId);
      }
    }
    return data;
  }
}
