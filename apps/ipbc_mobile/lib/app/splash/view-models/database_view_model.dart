import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../shared/components/utils/validation_util.dart';

class DatabaseViewModel {

  final String fireDatabase = 'firebase';
  final String initialId = '000000000';

  Future<HiveDatabaseConfigsDTO> validateDatabase(BuildContext context, HiveDatabaseConfigsDTO data) async {
    if ((ValidationUtil.validationDatasource() == fireDatabase) || (data.fireId == initialId)) {
      String fireId = await context.read<FirestoreDatasource>().verifyUpdateDatasource();
      if ((data.fireId != fireId) && fireId.isNotEmpty) {
        data = HiveDatabaseConfigsDTO.empty().copyWith(fireId: fireId);
      }
    }
    return data;
  }
}
