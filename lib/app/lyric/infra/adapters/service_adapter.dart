import '../../domain/entities/service_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'liturgy_adapter.dart';
import 'lyric_adapter.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;

class ServiceAdapter {

  static List<ServiceEntity> fromMapList(dynamic data) {
    List<ServiceEntity> services = [];
    for (int i = 0; data.length > i; i++) {
      services.add(
        ServiceEntity(
          liturgyList: LiturgyAdapter.fromMap(data[i]['liturgyList']),
          lyricsList: LyricAdapter.fromListMap(data[i]['lyricsList']),
          createAt: data[i]['createAt'].runtimeType == String
              ? data[i]['createAt']
              : DateFormat('dd/MM/yyyy')
                  .format((data[i]['createAt'] as Timestamp).toDate())
                  .toString(),
          heading: data[i]['heading'],
          title: data[i]['title'],
          guideIsVisible: data[i]['guideIsVisible'],
          theme: data[i]['theme'],
          preacher: data[i]['preacher'],
        ),
      );
    }
    return services;
  }

  static List<Map<String, dynamic>> toMapList(List<ServiceEntity> data) {
    return data
        .map((entity) => {
              'lyricsList': LyricAdapter.toMapList(entity.lyricsList),
              'liturgyList': LiturgyAdapter.toMapList(entity.liturgyList),
              'createAt': entity.createAt,
              'heading': entity.heading,
              'title': entity.title,
              'guideIsVisible': entity.guideIsVisible,
              'theme': entity.theme,
              'preacher': entity.preacher,
            })
        .toList();
  }
}
