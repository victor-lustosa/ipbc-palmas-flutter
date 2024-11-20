import 'dart:convert';
import 'package:core_module/core_module.dart';

import '../../models/event_model.dart';

// ignore: depend_on_referenced_packages

class SupaEventAdapter {
  static EventModel fromJson(String source) => fromMap(json.decode(source));
  static List<EventEntity> fromJsonList(String source) => fromMapList(json.decode(source));

  static EventModel fromMap(dynamic json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      image: json['image'],
      dateHour: json['date'],
      description: json['description'],
      location: json['location'],
      link: json['link'],
      linkDescription: json['linkDescription'],
      createAt: DateTime.now(),
    );
  }

  static Map<String, dynamic> toMap(EventEntity data) {
    return {
      'id': data.id,
      'title': data.title,
      'subtitle': data.subtitle,
      'image': data.image,
      'date_hour': data.dateHour.toIso8601String(),
      'description': data.description,
      'location': data.location,
      'link': data.link,
      'link_description': data.linkDescription,
      'create_at': data.createAt.toIso8601String(),
    };
  }
  static List<EventEntity> fromMapList(dynamic data) {
    List<EventEntity> events = [];
    for (dynamic entity in data) {
      events.add(
        EventEntity(
          id: entity['id'],
          title: entity['title'],
          subtitle: entity['subtitle'],
          image: entity['image'],
          dateHour: DateTime.now(),
          description: entity['description'],
          location: entity['location'],
          link: entity['link'],
          linkDescription: entity['linkDescription'],
          createAt: DateTime.now(),
        ),
      );
    }
    return events;
  }
}
