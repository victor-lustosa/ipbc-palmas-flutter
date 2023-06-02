import '../../domain/entities/services_entity.dart';

class ServicesAdapter {

  static ServicesEntity fromMap(dynamic json) {
    return ServicesEntity(
      heading: json['heading'],
      path: json['path'],
      title: json['title'],
      hour: json['hour'],
      image: json['image'],
      id: json['id'],
    );
  }

  static Map<String, dynamic> toMap(ServicesEntity data) {
    return {
      'heading': data.heading,
      'path': data.path,
      'id': data.id,
      'hour': data.hour,
      'title': data.title,
      'image': data.image,
    };
  }

  static List<ServicesEntity> fromMapList(dynamic data) {
    List<ServicesEntity> list = [];
    for (dynamic entity in data) {
      list.add(ServicesEntity(
        heading: entity['heading'],
        title: entity['title'],
        path: entity['path'],
        image: entity['image'],
        hour: entity['hour'],
        id: entity['id'],
      ));
    }
    return list;
  }
}
