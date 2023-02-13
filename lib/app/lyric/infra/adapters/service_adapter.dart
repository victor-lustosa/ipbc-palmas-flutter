
import '../../domain/entities/service_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'liturgy_adapter.dart';
import 'lyric_adapter.dart';
import 'package:intl/intl.dart' show DateFormat;

class ServiceAdapter{

  static ServiceEntity fromMap(dynamic json) {
    return ServiceEntity(
        liturgyList: LiturgyAdapter.fromMap(json[0]['liturgyList']),
        lyricsList: LyricAdapter.fromListMap(json[0]['lyricsList']),
        createAt: DateFormat('dd/MM/yyyy')
        .format((json[0]['createAt'] as Timestamp).toDate()).toString(),
        heading:json[0]['heading'],
        title: json[0]['title']);
  }

  static Map<String, dynamic> toMap(ServiceEntity data) {
    return {
      'createAt': data.createAt,
      'lyricsList': LyricAdapter.toListMap(data.lyricsList),
      'liturgyList': LiturgyAdapter.toMap(data.liturgyList),
    };
  }
}

