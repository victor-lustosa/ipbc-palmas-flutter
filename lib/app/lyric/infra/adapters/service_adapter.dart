import '../../domain/entities/service_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/services_list_entity.dart';
import 'liturgy_adapter.dart';
import 'lyric_adapter.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;

class ServiceAdapter {
  static ServicesListEntity servicesListFromMapList(List<Map> data) {
    ServicesListEntity services = ServicesListEntity(
      createAt: data[0]['createAt'].runtimeType == String
          ? data[0]['createAt']
          : DateFormat('dd/MM/yyyy')
              .format((data[0]['createAt'] as Timestamp).toDate())
              .toString(),
      servicesList: fromMapList(data[0]['servicesList']),
    );
    return services;
  }

  static List<Map<String, dynamic>> servicesListToMapList(
      ServicesListEntity data) {
    List<Map<String, dynamic>> map = [];
    for (int i = 0; data.servicesList.length > i; i++) {
      map.add({
        'liturgyList': LiturgyAdapter.toMapList(data.servicesList[i].liturgyList),
        'lyricsList': LyricAdapter.toMapList(data.servicesList[i].lyricsList),
        'createAt': data.servicesList[i].createAt,
        'heading': data.servicesList[i].heading,
        'title': data.servicesList[i].title,
        'guideIsVisible': data.servicesList[i].guideIsVisible,
      });
    }
    return [
      {'servicesList': map, 'createAt': data.createAt}
    ];
  }

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
            })
        .toList();
  }
}
