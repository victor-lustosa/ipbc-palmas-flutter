// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_verse_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveVerseDTOAdapter extends TypeAdapter<HiveVerseDTO> {
  @override
  final int typeId = 2;

  @override
  HiveVerseDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveVerseDTO(
      id: fields[0] as String,
      isChorus: fields[1] as bool,
      versesList: (fields[2] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveVerseDTO obj) {
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
      other is HiveVerseDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
