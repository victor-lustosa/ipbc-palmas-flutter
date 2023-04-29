import '../../../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../../../core/external/firestore_datasource.dart';
import '../../../shared/components/utils/validation_util.dart';

class DatabaseViewModel {

  final String fireDatabase = 'firebase';
  final String initialId = 'fdg33f345';

  Future<HiveDatabaseConfigsDTO> validateDatabase(FirestoreDatasource fireInstance, HiveDatabaseConfigsDTO data) async {
    if ((ValidationUtil.validationDatasource() == fireDatabase) || (data.hiveUpdateId != initialId)) {
      String fireUpdateId = await fireInstance.verifyUpdateDatasource('settings');
      if (data.fireUpdateId != fireUpdateId) {
        data = data.copyWith(
          fireUpdateId: fireUpdateId,
          isServicesUpdated: false,
          isLyricsUpdated: false,
          isSaturdayCollectionUpdated: false,
          isSundayEveningCollectionUpdated: false,
          isSundayMorningCollectionUpdated: false,
        );
      }
    }
    return data;
  }
}
