
import 'dart:convert';

import 'package:core_module/core_module.dart';

class ServicesAdapter {
  static String toJson(List<ServicesEntity> source) =>
      json.encode(toMapList(source));
  static List<ServicesEntity> fromJson(String source) => fromMapList(json.decode(source));
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
  static List<Map<String, dynamic>> toMapList(List<ServicesEntity> data) {
    return data
        .map((e) => {
      'heading': e.heading,
      'path': e.path,
      'id': e.id,
      'hour': e.hour,
      'title': e.title,
      'image': e.image,
    })
        .toList();
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
        id: entity['id'].runtimeType == String ? entity['id'] : entity['id'].toString(),
      ));
    }
    return list;
  }
}
