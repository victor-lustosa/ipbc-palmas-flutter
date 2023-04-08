import '../../domain/entities/service_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/firestore-dtos/services_collection_dto.dart';
import 'liturgy_adapter.dart';
import 'lyric_adapter.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;

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
