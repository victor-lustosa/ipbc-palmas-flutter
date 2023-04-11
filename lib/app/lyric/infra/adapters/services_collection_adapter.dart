import '../models/firestore-dtos/services_collection_dto.dart';

class ServicesCollectionAdapter {
  static List<ServicesCollectionDTO> fromMapList(dynamic data) {
    List<ServicesCollectionDTO> list = [];
    for(dynamic entity in data){
      list.add(
          ServicesCollectionDTO(
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
