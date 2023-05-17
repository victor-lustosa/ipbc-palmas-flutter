import '../models/firestore-dtos/services_dto.dart';

class ServicesAdapter {
  static List<ServicesDTO> fromMapList(dynamic data) {
    List<ServicesDTO> list = [];
    for (dynamic entity in data) {
      list.add(ServicesDTO(
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
