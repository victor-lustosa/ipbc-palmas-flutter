import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../../../core/external/firestore_datasource.dart';
import '../../../shared/components/utils/validation_util.dart';

class DatabaseViewModel {

  final String fireDatabase = 'firebase';
  final String initialId = '000000000';

  Future<HiveDatabaseConfigsDTO> validateDatabase(BuildContext context, HiveDatabaseConfigsDTO data) async {
    if ((ValidationUtil.validationDatasource() == fireDatabase) || (data.fireUpdateId == initialId)) {
      String fireUpdateId = await context.read<FirestoreDatasource>().verifyUpdateDatasource();
      if ((data.fireUpdateId != fireUpdateId) && fireUpdateId.isNotEmpty) {
        data = HiveDatabaseConfigsDTO.empty().copyWith(fireUpdateId: fireUpdateId);
      }
    }
    return data;
  }
}
