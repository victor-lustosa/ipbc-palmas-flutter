// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_lyrics_list_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveLyricsListDTOAdapter extends TypeAdapter<HiveLyricsListDTO> {
  @override
  final int typeId = 6;

  @override
  HiveLyricsListDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLyricsListDTO(
      lyricsList: (fields[0] as List).cast<LyricHiveDTO>(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveLyricsListDTO obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.lyricsList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLyricsListDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
