
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ipbc_palmas/app/shared/components/splash/infra/models/hive-dtos/service_hive_dto.dart';

import '../../infra/models/services_list.dart';
import 'liturgy_adapter.dart';
import 'lyric_adapter.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;

class ServiceAdapter {
  static List<ServiceHiveDTO> servicesListDecode(
      List<Map<dynamic, dynamic>> data) {
    ServicesList services = ServicesList(
      createAt: DateFormat('dd/MM/yyyy')
          .format((data[0]['createAt'] as Timestamp).toDate())
          .toString(),
      servicesList: fromMapList(data[0]['servicesList']),
    );
    return services.servicesList;
  }

  static List<ServiceHiveDTO> fromMapList(dynamic data) {
    List<ServiceHiveDTO> services = [];
    for (int i = 0; data.length > i; i++) {
      services.add(
        ServiceHiveDTO.create(
          liturgyList: LiturgyAdapter.fromMap(data[i]['liturgyList']),
          lyricsList: LyricAdapter.fromListMap(data[i]['lyricsList']),
          createAt: DateFormat('dd/MM/yyyy')
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

  static ServiceHiveDTO fromMap(dynamic json) {
    return ServiceHiveDTO.create(
      liturgyList: json.containsKey('liturgyList')
          ? LiturgyAdapter.fromMap(json['liturgyList'])
          : [],
      lyricsList: LyricAdapter.fromListMap(json['lyricsList']),
      createAt: DateFormat('dd/MM/yyyy')
          .format((json['createAt'] as Timestamp).toDate())
          .toString(),
      heading: json['heading'],
      title: json['title'],
      guideIsVisible: json['guideIsVisible'],
    );
  }

  static Map<String, dynamic> toMap(ServiceHiveDTO data) {
    return {
      'lyricsList': LyricAdapter.toMapList(data.lyricsList),
      'liturgyList': LiturgyAdapter.toMapList(data.liturgyList),
      'createAt': data.createAt,
      'heading': data.heading,
      'title': data.title,
      'guideIsVisible': data.guideIsVisible,
    };
  }
}
