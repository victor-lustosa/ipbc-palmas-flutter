import 'package:hive/hive.dart';
part 'hive_database_configs_dto.g.dart';

@HiveType(typeId: 3)
class HiveDatabaseConfigsDTO {
  @HiveField(0)
  String hiveUpdateId;

  @HiveField(1)
  String fireUpdateId;

  @HiveField(2)
  bool isSaturdayCollectionUpdated;

  @HiveField(3)
  bool isSundayMorningCollectionUpdated;

  @HiveField(4)
  bool isSundayEveningCollectionUpdated;

  @HiveField(5)
  bool isServicesUpdated;

  @HiveField(6)
  bool isLyricsUpdated;

  @HiveField(7)
  bool isSystemUpdated;

  HiveDatabaseConfigsDTO copyWith(
       {String? hiveUpdateId,
        String? fireUpdateId,
        bool? isSaturdayCollectionUpdated,
        bool? isSundayMorningCollectionUpdated,
        bool? isSundayEveningCollectionUpdated,
        bool? isServicesUpdated,
        bool? isLyricsUpdated,
         bool? isSystemUpdated,
       }) {
    return HiveDatabaseConfigsDTO(
      isSystemUpdated: isSystemUpdated ?? this.isSystemUpdated,
      hiveUpdateId: hiveUpdateId ?? this.hiveUpdateId,
      fireUpdateId: fireUpdateId ?? this.fireUpdateId,
      isSundayMorningCollectionUpdated: isSundayMorningCollectionUpdated ?? this.isSundayMorningCollectionUpdated,
      isSaturdayCollectionUpdated: isSaturdayCollectionUpdated ?? this.isSaturdayCollectionUpdated,
      isSundayEveningCollectionUpdated: isSundayEveningCollectionUpdated ?? this.isSundayEveningCollectionUpdated,
      isServicesUpdated: isServicesUpdated ?? this.isServicesUpdated,
      isLyricsUpdated: isLyricsUpdated ?? this.isLyricsUpdated,
    );
  }

  HiveDatabaseConfigsDTO({
    required this.isSystemUpdated,
    required this.hiveUpdateId,
    required this.fireUpdateId,
    required this.isSaturdayCollectionUpdated,
    required this.isSundayEveningCollectionUpdated,
    required this.isSundayMorningCollectionUpdated,
    required this.isServicesUpdated,
    required this.isLyricsUpdated,
  });
}
