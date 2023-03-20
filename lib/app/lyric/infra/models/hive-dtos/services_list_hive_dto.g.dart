// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_list_hive_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServicesListHiveDTOAdapter extends TypeAdapter<ServicesListHiveDTO> {
  @override
  final int typeId = 5;

  @override
  ServicesListHiveDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServicesListHiveDTO(
      servicesList: (fields[1] as List).cast<ServiceHiveDTO>(),
      createAt: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ServicesListHiveDTO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.createAt)
      ..writeByte(1)
      ..write(obj.servicesList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServicesListHiveDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
