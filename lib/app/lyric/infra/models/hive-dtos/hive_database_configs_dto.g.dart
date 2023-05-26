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
      fireId: fields[0] as String,
      isSaturdayCollectionUpdated: fields[1] as bool,
      isSundayEveningCollectionUpdated: fields[3] as bool,
      isSundayMorningCollectionUpdated: fields[2] as bool,
      isServicesUpdated: fields[4] as bool,
      isLyricsUpdated: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveDatabaseConfigsDTO obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.fireId)
      ..writeByte(1)
      ..write(obj.isSaturdayCollectionUpdated)
      ..writeByte(2)
      ..write(obj.isSundayMorningCollectionUpdated)
      ..writeByte(3)
      ..write(obj.isSundayEveningCollectionUpdated)
      ..writeByte(4)
      ..write(obj.isServicesUpdated)
      ..writeByte(5)
      ..write(obj.isLyricsUpdated);
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
