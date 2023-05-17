// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_services_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveServicesDTOAdapter
    extends TypeAdapter<HiveServicesDTO> {
  @override
  final int typeId = 5;

  @override
  HiveServicesDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveServicesDTO(
      id: fields[0] as String,
      heading: fields[1] as String,
      path: fields[2] as String,
      title: fields[3] as String,
      image: fields[4] as String,
      hour: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveServicesDTO obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.heading)
      ..writeByte(2)
      ..write(obj.path)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.hour);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveServicesDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
