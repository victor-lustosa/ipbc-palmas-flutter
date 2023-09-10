import 'dart:convert';

import 'package:core_module/core_module.dart';

import 'lyric_adapter.dart';
import 'liturgy_adapter.dart';
import '../models/service_model.dart';
import '../../domain/entities/service_entity.dart';
// ignore: depend_on_referenced_packages

class ServiceAdapter {
  static ServiceModel fromJson(String source) => fromMap(json.decode(source));

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
      liturgyList: json.containsKey('liturgyList')
          ? LiturgyAdapter.fromMap(json['liturgyList'])
          : [],
      lyricsList: LyricAdapter.fromMapList(json['lyricsList']),
      hour: json['hour'],
    );
  }

  static Map<String, dynamic> toMap(ServiceEntity data) {
    return {
      'id': data.id,
      'hour': data.hour,
      'image': data.image,
      'createAt': data.createAt,
      'heading': data.heading,
      'title': data.title,
      'type': data.type,
      'theme': data.theme,
      'preacher': data.preacher,
      'lyricsList': LyricAdapter.toMapList(data.lyricsList),
      'liturgyList': LiturgyAdapter.toMapList(data.liturgyList),
      'guideIsVisible': data.guideIsVisible
    };
  }
  static List<ServiceEntity> fromMapList(dynamic data) {
    List<ServiceEntity> services = [];
    for (dynamic entity in data) {
      services.add(
        ServiceEntity(
          type: entity['type'],
          hour: entity['hour'],
          liturgyList: LiturgyAdapter.fromMap(entity['liturgyList']),
          lyricsList: LyricAdapter.fromMapList(entity['lyricsList']),
          createAt: entity['createAt'].runtimeType == String
              ? DateTime.parse(entity['createAt'])
              : (entity['createAt'] as Timestamp).toDate(),
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
