import 'dart:convert';

import 'package:core_module/core_module.dart';

class EventAdapter {
  EventAdapter._();
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
      description: json['description'],
      location: json['location'],
      createAt: json['create_at'],
      startDateTime: json['start_date_time'],
      endDateTime: json['end_date_time'],
      localName: json['local_name'],
      signUpLink: json['sign_up_link'],
      contactLink: json['contact_link'],
      latitude: json['latitude'],
      longitude: json['longitude'],
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
            'start_date_time': e.startDateTime,
            'end_date_time': e.endDateTime,
            'description': e.description,
            'location': e.location,
            'local_name': e.localName,
            'sign_up_link': e.signUpLink,
            'contact_link': e.contactLink,
            'create_at': e.createAt,
            'latitude': e.latitude,
            'longitude': e.longitude,
          },
        )
        .toList();
  }

  static Map<String, dynamic> toMap(EventEntity data) {
    return {
      if (data.id != null) 'id': data.id,
      'title': data.title,
      'subtitle': data.subtitle,
      'image': data.image,
      'start_date_time': data.startDateTime.toIso8601String(),
      'end_date_time': data.endDateTime.toIso8601String(),
      'description': data.description,
      'location': data.location,
      'local_name': data.localName,
      'sign_up_link': data.signUpLink,
      'contact_link': data.contactLink,
      'create_at': data.createAt.toIso8601String(),
      'latitude': data.latitude,
      'longitude': data.longitude,
    };
  }

  static List<EventEntity> fromMapList(dynamic data) {
    List<EventEntity> list = [];
    for (dynamic entity in data) {
      list.add(
        EventEntity(
          title: entity['title'],
          image: entity['image'],
          description: entity['description'],
          location: entity['location'],
          createAt: DateTime.parse(entity['create_at']),
          id:
              entity['id'].runtimeType == String
                  ? entity['id']
                  : entity['id'].toString(),
          startDateTime: DateTime.parse(entity['start_date_time']),
          endDateTime: DateTime.parse(entity['end_date_time']),
          localName: entity['local_name'],
          signUpLink: entity['sign_up_link'],
          contactLink: entity['contact_link'],
          subtitle: entity['subtitle'],
          latitude: entity['latitude'],
          longitude: entity['longitude'],
        ),
      );
    }
    return list;
  }
}
