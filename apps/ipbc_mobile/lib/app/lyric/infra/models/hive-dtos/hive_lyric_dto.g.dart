// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_lyric_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveLyricDTOAdapter extends TypeAdapter<HiveLyricDTO> {
  @override
  final int typeId = 0;

  @override
  HiveLyricDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLyricDTO(
      albumCover: fields[3] as String,
      title: fields[1] as String,
      createAt: fields[4] as String,
      group: fields[2] as String,
      verses: (fields[5] as List).cast<HiveVerseDTO>(),
      id: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveLyricDTO obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.group)
      ..writeByte(3)
      ..write(obj.albumCover)
      ..writeByte(4)
      ..write(obj.createAt)
      ..writeByte(5)
      ..write(obj.verses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLyricDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
