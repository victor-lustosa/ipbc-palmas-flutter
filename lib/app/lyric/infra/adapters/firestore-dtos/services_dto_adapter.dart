import '../../models/firestore-dtos/services_dto.dart';

class ServicesDTOAdapter {
  static ServicesDTO fromMap(dynamic json) {
    return ServicesDTO(
      heading: json['heading'],
      path: json['path'],
      title: json['title'],
      hour: json['hour'],
      image: json['image'],
      id: json['id'],
    );
  }

  static Map<String, dynamic> toMap(ServicesDTO data) {
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
