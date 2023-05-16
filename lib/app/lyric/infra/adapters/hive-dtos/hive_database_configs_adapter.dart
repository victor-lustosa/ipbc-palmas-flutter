import '../../models/hive-dtos/hive_database_configs_dto.dart';

class HiveDatabaseConfigsAdapter {
  static List<Map<String, dynamic>> toMapList(HiveDatabaseConfigsDTO data) {
    List<Map<String, dynamic>> map = [];
    map.add({
      'fireUpdateId': data.fireUpdateId,
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
      isServicesUpdated: json[0]['isServicesUpdated'],
      isSundayMorningCollectionUpdated: json[0]['isSundayMorningCollectionUpdated'],
      isSaturdayCollectionUpdated: json[0]['isSaturdayCollectionUpdated'],
      isSundayEveningCollectionUpdated: json[0]['isSundayEveningCollectionUpdated'],
      isLyricsUpdated: json[1]['isLyricsUpdated'],
    );
  }
}
