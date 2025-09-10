import 'dart:convert';

import 'package:core_module/core_module.dart';

class ServicesAdapter {
  ServicesAdapter._();
  static String toJson(List<ServicesEntity> source) =>
      json.encode(toMapList(source));

  static List<ServicesEntity> fromJson(String source) =>
      fromMapList(json.decode(source));

  static List<Map<String, dynamic>> toMapList(List<ServicesEntity> data) {
    return data
        .map(
          (e) => {
            'heading': e.heading,
            'path': e.path,
            'day_of_week': e.dayOfWeek,
            'id': e.id,
            'service_date': e.serviceDate,
            'title': e.title,
            'image': e.image,
          },
        )
        .toList();
  }

  static List<ServicesEntity> fromMapList(dynamic data) {
    List<ServicesEntity> list = [];
    for (dynamic entity in data) {
      list.add(
        ServicesEntity(
          heading: entity['heading'],
          title: entity['title'],
          dayOfWeek: entity.containsKey('day_of_week')
              ? entity['day_of_week']
              : null,
          path: entity['path'],
          image: entity['image'],
          serviceDate: DateTime.parse(entity['service_date']),
          id: entity['id'].runtimeType == String
              ? entity['id']
              : entity['id'].toString(),
        ),
      );
    }
    return list;
  }
}
