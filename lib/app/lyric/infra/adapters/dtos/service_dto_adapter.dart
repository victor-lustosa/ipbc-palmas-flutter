import 'dart:convert';

import './lyric_dto_adapter.dart';

import '../../models/dtos/service_dto.dart';
import '../liturgy_adapter.dart';


class ServiceDTOAdapter{

  static ServiceDTO fromJson(String source) => fromMap(json.decode(source));

  static ServiceDTO fromMap(dynamic json) {
    return ServiceDTO(
        liturgyList: LiturgyAdapter.fromMap(json['liturgyList']),
        lyricsList: LyricDTOAdapter.fromMap(json['lyricsList']),
        createAt: DateTime.now(),
        heading: json['heading'],
        title: json['title']);
  }

  static Map<String, dynamic> toMap(ServiceDTO data) {
    return {
      'createAt': data.createAt,
      'heading': data.heading,
      'title': data.title,
      'lyricsList': LyricDTOAdapter.toMapList(data.lyricsList),
      'liturgyList': LiturgyAdapter.toMap(data.liturgyList),
    };
  }
}

