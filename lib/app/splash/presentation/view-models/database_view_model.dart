import '../../../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../../../core/external/firestore_datasource.dart';
import '../../../shared/components/utils/validation_util.dart';

class DatabaseViewModel {
  Future<HiveDatabaseConfigsDTO> validateDatabase(
      String fireDatabase,
      FirestoreDatasource fire,
      HiveDatabaseConfigsDTO data,
      String initialId) async {
    if ((ValidationUtil.validationDatasource() == fireDatabase) || (data.hiveUpdateId != initialId)) {
      String fireUpdateId = await fire.verifyUpdateDatasource('settings');
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
    if (data.isLyricsUpdated &&
        data.isSundayMorningCollectionUpdated &&
        data.isSaturdayCollectionUpdated &&
        data.isSundayEveningCollectionUpdated &&
        data.isServicesUpdated) {
      data = data.copyWith(
          isSystemUpdated: true,
          hiveUpdateId: data.fireUpdateId
      );
    }
    return data;
  }
}
