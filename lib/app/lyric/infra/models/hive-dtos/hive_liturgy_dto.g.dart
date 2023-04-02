// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_liturgy_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveLiturgyDTOAdapter extends TypeAdapter<HiveLiturgyDTO> {
  @override
  final int typeId = 4;

  @override
  HiveLiturgyDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLiturgyDTO(
      isAdditional: fields[0] as bool,
      sequence: fields[1] as String,
      additional: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveLiturgyDTO obj) {
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
      other is HiveLiturgyDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
