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
        createAt: DateTime.now());
  }

  static Map<String, dynamic> toMap(ServiceDTO data) {
    return {
      'createAt': data.createAt,
      'lyricsList': LyricDTOAdapter.toMapList(data.lyricsList),
      'liturgyList': LiturgyAdapter.toMap(data.liturgyList),
    };
  }
}

