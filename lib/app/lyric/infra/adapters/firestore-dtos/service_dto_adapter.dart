import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import './lyric_dto_adapter.dart';
import '../../models/firestore-dtos/service_dto.dart';
import '../liturgy_adapter.dart';

class ServiceDTOAdapter {
  static ServiceDTO fromJson(String source) => fromMap(json.decode(source));

  static ServiceDTO fromMap(dynamic json) {
    return ServiceDTO(
      id: json['id'],
      image: json['image'],
      createAt: DateTime.now(),
      type:json['type'],
      theme: json['theme'],
      preacher: json['preacher'],
      heading: json['heading'],
      title: json['title'],
      guideIsVisible: json['guideIsVisible'],
      liturgyList: json.containsKey('liturgyList')
        ? LiturgyAdapter.fromMap(json['liturgyList'])
        : [],
      lyricsList: LyricDTOAdapter.fromMap(json['lyricsList']),
      hour: json['hour'],
    );
  }

  static Map<String, dynamic> toMapList(List<ServiceDTO> data) {
    return {
      'servicesList': data.map((entity) => toMap(entity)).toList(),
      'createAt':Timestamp.now().toDate()
    };
  }

  static Map<String, dynamic> toMap(ServiceDTO data) {
    return {
      'id': data.id,
      'hour': data.hour,
      'image': data.image,
      'createAt': data.createAt,
      'heading': data.heading,
      'title': data.title,
      'type':data.type,
      'theme': data.theme,
      'preacher': data.preacher,
      'lyricsList': LyricDTOAdapter.toMapList(data.lyricsList),
      'liturgyList': LiturgyAdapter.toMapList(data.liturgyList),
      'guideIsVisible': data.guideIsVisible
    };
  }
}
