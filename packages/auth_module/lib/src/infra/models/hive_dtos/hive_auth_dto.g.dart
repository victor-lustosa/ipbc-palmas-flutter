// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_auth_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveAuthDTOAdapter extends TypeAdapter<HiveAuthDTO> {
  @override
  final int typeId = 6;

  @override
  HiveAuthDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveAuthDTO(
      token: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveAuthDTO obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveAuthDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
