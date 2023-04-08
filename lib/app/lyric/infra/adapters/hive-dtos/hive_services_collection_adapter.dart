import '../../models/firestore-dtos/services_collection_dto.dart';
import '../../models/hive-dtos/hive_services_collection_dto.dart';

class HiveServicesCollectionAdapter {
  static Map<String, dynamic> toMap(dynamic data) {
    return {
      'heading': data.heading,
      'title': data.title,
      'path': data.path,
      'image': data.image,
      'hour': data.hour,
    };
  }

  static HiveServicesCollectionDTO toDTO(ServicesCollectionDTO entity) {
    return HiveServicesCollectionDTO(
      id: entity.id,
      heading: entity.heading,
      title: entity.title,
      path: entity.path,
      image: entity.image,
      hour: entity.hour,
    );
  }
}
