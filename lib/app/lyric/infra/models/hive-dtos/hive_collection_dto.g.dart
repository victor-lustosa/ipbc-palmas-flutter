// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_collection_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveServiceDTOAdapter extends TypeAdapter<HiveCollectionDTO> {
  @override
  final int typeId = 1;

  @override
  HiveCollectionDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCollectionDTO(
      id: fields[0] as String,
      title: fields[3] as String,
      image: fields[10] as String,
      hour: fields[11] as String,
      theme: fields[8] as String,
      preacher: fields[9] as String,
      type: fields[7] as String,
      guideIsVisible: fields[2] as bool,
      heading: fields[4] as String,
      liturgyList: (fields[6] as List).cast<HiveLiturgyDTO>(),
      lyricsList: (fields[5] as List).cast<HiveLyricDTO>(),
      createAt: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCollectionDTO obj) {
    writer
      ..writeByte(12)
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
      ..write(obj.liturgyList)
      ..writeByte(7)
      ..write(obj.type)
      ..writeByte(8)
      ..write(obj.theme)
      ..writeByte(9)
      ..write(obj.preacher)
      ..writeByte(10)
      ..write(obj.image)
      ..writeByte(11)
      ..write(obj.hour);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveServiceDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
