import 'dart:convert';
import 'package:core_module/core_module.dart';

// ignore: depend_on_referenced_packages

class SupaServiceAdapter {
  static ServiceModel fromJson(String source) => fromMap(json.decode(source));
  static List<ServiceEntity> fromJsonList(String source) =>
      fromMapList(json.decode(source));

  static ServiceModel fromMap(dynamic json) {
    return ServiceModel(
      id: json['id'],
      image: json['image'],
      createAt: DateTime.now(),
      type: json['type'],
      theme: json['theme'],
      preacher: json['preacher'],
      heading: json['heading'],
      title: json['title'],
      guideIsVisible: json['guideIsVisible'],
      liturgiesList:
          json.containsKey('liturgiesList')
              ? LiturgyAdapter.fromMap(json['liturgiesList'])
              : [],
      lyricsList: SupaLyricAdapter.fromMapList(json['lyricsList']),
      hour: json['hour'],
    );
  }

  static Map<String, dynamic> toMap(ServiceEntity data) {
    return {
      'id': data.id,
      'hour': data.hour,
      'image': data.image,
      'createAt': data.createAt.toString(),
      'heading': data.heading,
      'title': data.title,
      'type': data.type,
      'theme': data.theme,
      'preacher': data.preacher,
      'guideIsVisible': data.guideIsVisible,
    };
  }

  static List<ServiceEntity> fromMapList(dynamic data) {
    List<ServiceEntity> services = [];
    for (dynamic entity in data) {
      services.add(
        ServiceEntity(
          type: entity['type'],
          hour: entity['hour'],
          liturgiesList: LiturgyAdapter.fromMap(entity['liturgiesList']),
          lyricsList: SupaLyricAdapter.fromMapList(entity['lyricsList']),
          createAt: DateFormat("dd/MM/yyyy").parse(entity['createAt']),
          heading: entity['heading'],
          title: entity['title'],
          guideIsVisible: entity['guideIsVisible'],
          theme: entity['theme'],
          image: entity['image'],
          id: entity['id'],
          preacher: entity['preacher'],
        ),
      );
    }
    return services;
  }
}
