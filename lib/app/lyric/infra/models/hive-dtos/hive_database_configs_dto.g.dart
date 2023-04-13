// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_database_configs_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveDatabaseConfigsDTOAdapter
    extends TypeAdapter<HiveDatabaseConfigsDTO> {
  @override
  final int typeId = 3;

  @override
  HiveDatabaseConfigsDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveDatabaseConfigsDTO(
      isSystemUpdated: fields[7] as bool,
      hiveUpdateId: fields[0] as String,
      fireUpdateId: fields[1] as String,
      isSaturdayCollectionUpdated: fields[2] as bool,
      isSundayEveningCollectionUpdated: fields[4] as bool,
      isSundayMorningCollectionUpdated: fields[3] as bool,
      isServicesUpdated: fields[5] as bool,
      isLyricsUpdated: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveDatabaseConfigsDTO obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.hiveUpdateId)
      ..writeByte(1)
      ..write(obj.fireUpdateId)
      ..writeByte(2)
      ..write(obj.isSaturdayCollectionUpdated)
      ..writeByte(3)
      ..write(obj.isSundayMorningCollectionUpdated)
      ..writeByte(4)
      ..write(obj.isSundayEveningCollectionUpdated)
      ..writeByte(5)
      ..write(obj.isServicesUpdated)
      ..writeByte(6)
      ..write(obj.isLyricsUpdated)
      ..writeByte(7)
      ..write(obj.isSystemUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveDatabaseConfigsDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
