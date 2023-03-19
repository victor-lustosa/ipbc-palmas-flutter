// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liturgy_hive_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LiturgyHiveDTOAdapter extends TypeAdapter<LiturgyHiveDTO> {
  @override
  final int typeId = 4;

  @override
  LiturgyHiveDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LiturgyHiveDTO(
      isAdditional: fields[0] as bool,
      sequence: fields[1] as String,
      additional: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LiturgyHiveDTO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.isAdditional)
      ..writeByte(1)
      ..write(obj.sequence)
      ..writeByte(2)
      ..write(obj.additional);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LiturgyHiveDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
