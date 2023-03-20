// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_hive_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceHiveDTOAdapter extends TypeAdapter<ServiceHiveDTO> {
  @override
  final int typeId = 1;

  @override
  ServiceHiveDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServiceHiveDTO(
      id: fields[0] as String,
      title: fields[3] as String,
      guideIsVisible: fields[2] as bool,
      heading: fields[4] as String,
      liturgyList: (fields[6] as List).cast<LiturgyHiveDTO>(),
      lyricsList: (fields[5] as List).cast<LyricHiveDTO>(),
      createAt: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ServiceHiveDTO obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createAt)
      ..writeByte(2)
      ..write(obj.guideIsVisible)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.heading)
      ..writeByte(5)
      ..write(obj.lyricsList)
      ..writeByte(6)
      ..write(obj.liturgyList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceHiveDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
