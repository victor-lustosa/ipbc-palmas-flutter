import 'package:hive/hive.dart';
part 'hive_database_configs_dto.g.dart';

@HiveType(typeId: 3)
class HiveDatabaseConfigsDTO {
  @HiveField(0)
  String fireId;

  @HiveField(1)
  bool isSaturdayCollectionUpdated;

  @HiveField(2)
  bool isSundayMorningCollectionUpdated;

  @HiveField(3)
  bool isSundayEveningCollectionUpdated;

  @HiveField(4)
  bool isServicesUpdated;

  @HiveField(5)
  bool isLyricsUpdated;


  HiveDatabaseConfigsDTO copyWith({
        String? fireId,
        bool? isSaturdayCollectionUpdated,
        bool? isSundayMorningCollectionUpdated,
        bool? isSundayEveningCollectionUpdated,
        bool? isServicesUpdated,
        bool? isLyricsUpdated,
       }) {
    return HiveDatabaseConfigsDTO(
      fireId: fireId ?? this.fireId,
      isSundayMorningCollectionUpdated: isSundayMorningCollectionUpdated ?? this.isSundayMorningCollectionUpdated,
      isSaturdayCollectionUpdated: isSaturdayCollectionUpdated ?? this.isSaturdayCollectionUpdated,
      isSundayEveningCollectionUpdated: isSundayEveningCollectionUpdated ?? this.isSundayEveningCollectionUpdated,
      isServicesUpdated: isServicesUpdated ?? this.isServicesUpdated,
      isLyricsUpdated: isLyricsUpdated ?? this.isLyricsUpdated,
    );
  }

  factory HiveDatabaseConfigsDTO.empty() => HiveDatabaseConfigsDTO(
    fireId: '000000000',
    isServicesUpdated: false,
    isLyricsUpdated: false,
    isSaturdayCollectionUpdated: false,
    isSundayEveningCollectionUpdated: false,
    isSundayMorningCollectionUpdated: false,
  );

  HiveDatabaseConfigsDTO({
    required this.fireId,
    required this.isSaturdayCollectionUpdated,
    required this.isSundayEveningCollectionUpdated,
    required this.isSundayMorningCollectionUpdated,
    required this.isServicesUpdated,
    required this.isLyricsUpdated,
  });
}
