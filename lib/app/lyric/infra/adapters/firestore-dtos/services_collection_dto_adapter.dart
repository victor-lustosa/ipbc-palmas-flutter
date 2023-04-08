import '../../../domain/entities/verse_entity.dart';
import '../../models/firestore-dtos/services_collection_dto.dart';

class ServicesCollectionDTOAdapter {

  static ServicesCollectionDTO fromMap(dynamic json) {
    return ServicesCollectionDTO(
      heading: json['heading'],
      path: json['path'],
      title: json['title'],
      hour: json['hour'],
      image: json['image'],
      id:  json['id'],
    );
  }
  static Map<String, dynamic> toMap(ServicesCollectionDTO data) {
    return {
      'heading': data.heading,
      'path': data.path,
      'id': data.id,
      'hour': data.hour,
      'title': data.title,
      'image': data.image,
    };
  }
}
