import 'dart:convert';

import 'package:core_module/core_module.dart';

class EventAdapter {
  static String toJson(List<EventEntity> source) =>
      json.encode(toMapList(source));
  static List<EventEntity> fromJson(String source) =>
      fromMapList(json.decode(source));
  static EventEntity fromMap(dynamic json) {
    return EventEntity(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      image: json['image'],
      dateHour: json['date_hour'],
      description: json['description'],
      location: json['location'],
      link: json['link'],
      linkDescription: json['link_description'],
      createAt: json['create_at'],
    );
  }

  static List<Map<String, dynamic>> toMapList(List<EventEntity> data) {
    return data
        .map(
          (e) => {
            'id': e.id,
            'title': e.title,
            'subtitle': e.subtitle,
            'image': e.image,
            'date_hour': e.dateHour,
            'description': e.description,
            'location': e.location,
            'link': e.link,
            'link_description': e.linkDescription,
          },
        )
        .toList();
  }

  static Map<String, dynamic> toMap(EventEntity data) {
    return {
      'id': data.id,
      'title': data.title,
      'subtitle': data.subtitle,
      'image': data.image,
      'date_hour': data.dateHour,
      'description': data.description,
      'location': data.location,
      'link': data.link,
      'link_description': data.linkDescription,
    };
  }

  static List<EventEntity> fromMapList(dynamic data) {
    List<EventEntity> list = [];
    for (dynamic entity in data) {
      list.add(
        EventEntity(
          title: entity['title'],
          subtitle: entity['subtitle'],
          image: entity['image'],
          dateHour: DateTime.parse(entity['date_hour']),
          description: entity['description'],
          location: entity['location'],
          link: entity['link'],
          linkDescription: entity['link_description'],
          createAt: DateTime.parse(entity['create_at']),
          id:
              entity['id'].runtimeType == String
                  ? entity['id']
                  : entity['id'].toString(),
        ),
      );
    }
    return list;
  }
}
