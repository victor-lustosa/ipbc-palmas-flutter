import '../../models/hive-dtos/hive_database_configs_dto.dart';

class HiveDatabaseConfigsAdapter {
  static List<Map<String, dynamic>> toMapList(HiveDatabaseConfigsDTO data) {
    List<Map<String, dynamic>> map = [];
    map.add({
      'isSystemUpdated': data.isSystemUpdated,
      'fireUpdateId': data.fireUpdateId,
      'hiveUpdateId': data.hiveUpdateId,
      'isServicesUpdated': data.isServicesUpdated,
      'isSaturdayCollectionUpdated': data.isSaturdayCollectionUpdated,
      'isSundayMorningCollectionUpdated': data.isSundayMorningCollectionUpdated,
      'isSundayEveningCollectionUpdated': data.isSundayEveningCollectionUpdated,
      'isLyricsUpdated': data.isLyricsUpdated,
    });
    return map;
  }

  static HiveDatabaseConfigsDTO fromMap(List<Map> json) {
    return HiveDatabaseConfigsDTO(
      fireUpdateId: json[0]['fireUpdateId'],
      hiveUpdateId: json[0]['hiveUpdateId'],
      isServicesUpdated: json[0]['isServicesUpdated'],
      isSundayMorningCollectionUpdated: json[0]['isSundayMorningCollectionUpdated'],
      isSaturdayCollectionUpdated: json[0]['isSaturdayCollectionUpdated'],
      isSundayEveningCollectionUpdated: json[0]['isSundayEveningCollectionUpdated'],
      isLyricsUpdated: json[1]['isLyricsUpdated'],
      isSystemUpdated: json[0]['isSystemUpdated'],
    );
  }
}
