import '../../models/firestore-dtos/services_dto.dart';
import '../../models/hive-dtos/hive_services_dto.dart';

class HiveServicesAdapter {
  static Map<String, dynamic> toMap(dynamic data) {
    return {
      'id': data.id,
      'heading': data.heading,
      'title': data.title,
      'path': data.path,
      'image': data.image,
      'hour': data.hour,
    };
  }

  static HiveServicesDTO toDTO(ServicesDTO entity) {
    return HiveServicesDTO(
      id: entity.id,
      heading: entity.heading,
      title: entity.title,
      path: entity.path,
      image: entity.image,
      hour: entity.hour,
    );
  }
}
