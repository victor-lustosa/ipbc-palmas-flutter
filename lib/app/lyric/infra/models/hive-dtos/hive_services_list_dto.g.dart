// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_services_list_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveServicesListDTOAdapter extends TypeAdapter<HiveServicesListDTO> {
  @override
  final int typeId = 5;

  @override
  HiveServicesListDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveServicesListDTO(
      servicesList: (fields[1] as List).cast<ServiceHiveDTO>(),
      createAt: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveServicesListDTO obj) {
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
      other is HiveServicesListDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
