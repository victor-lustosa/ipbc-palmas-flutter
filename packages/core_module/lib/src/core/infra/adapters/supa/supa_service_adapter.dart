import 'dart:convert';
import 'package:core_module/core_module.dart';
import 'package:core_module/src/core/infra/adapters/supa/supa_liturgy_adapter.dart';

// ignore: depend_on_referenced_packages

class SupaServiceAdapter {
  static ServiceModel fromJson(String source) => fromMap(json.decode(source));
  static List<ServiceEntity> fromJsonList(String source) =>
      fromMapList(json.decode(source));

  static ServiceModel fromMap(dynamic json) {
    return ServiceModel(
      id: json['id'],
      image: json['image'],
      createAt: '',
      type: json['type'],
      theme: json['theme'],
      preacher: json['preacher'],
      heading: json['heading'],
      title: json['title'],
      guideIsVisible: json['guideIsVisible'],
      liturgiesList:
          json.containsKey('liturgiesList')
              ? SupaLiturgyAdapter.fromMapList(json['liturgiesList'])
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
      services.add( ServiceEntity(
        id:
        entity['id'].runtimeType == String
            ? entity['id']
            : entity['id'].toString(),
        type: '',
        image: entity['image'],
        hour: entity['hour'],
        createAt: DateFormat('dd/MM/yyyy').format(DateTime.parse(entity['createAt'])),
        theme: entity['theme'],
        preacher: entity['preacher'],
        guideIsVisible: entity['guideIsVisible'],
        title: entity['title'],
        heading: entity['heading'],
        liturgiesList:
        entity.containsKey('service_liturgies')
            ? SupaLiturgyAdapter.fromMapList(entity['service_liturgies'])
            : [],
        lyricsList: SupaLyricAdapter.fromMapList(entity['service_lyrics']),
      ));
    }
    return services;
  }
}
