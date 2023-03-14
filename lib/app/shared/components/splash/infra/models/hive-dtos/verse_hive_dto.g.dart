// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_hive_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VerseHiveDTOAdapter extends TypeAdapter<VerseHiveDTO> {
  @override
  final int typeId = 2;

  @override
  VerseHiveDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VerseHiveDTO(
      id: fields[0] as String,
      isChorus: fields[1] as bool,
      versesList: (fields[2] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, VerseHiveDTO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isChorus)
      ..writeByte(2)
      ..write(obj.versesList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VerseHiveDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
