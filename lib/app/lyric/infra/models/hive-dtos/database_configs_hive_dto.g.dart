// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_configs_hive_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DatabaseConfigsHiveDTOAdapter
    extends TypeAdapter<DatabaseConfigsHiveDTO> {
  @override
  final int typeId = 3;

  @override
  DatabaseConfigsHiveDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DatabaseConfigsHiveDTO(
      updateAt: fields[0] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DatabaseConfigsHiveDTO obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.updateAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatabaseConfigsHiveDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
