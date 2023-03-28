
import '../../../domain/entities/service_entity.dart';
import '../../models/hive-dtos/service_hive_dto.dart';
import 'liturgy_hive_adapter.dart';
import 'lyric_hive_adapter.dart';

class ServiceHiveAdapter {

  static List<Map<String, dynamic>> toMapList(List<ServiceHiveDTO> data) {
    List<Map<String, dynamic>> map = [];
    for (int i = 0; data.length > i; i++) {
      map.add({
            'id': data[i].id,
            'liturgyList': LiturgyHiveAdapter.toMapList(data[i].liturgyList),
            'lyricsList': LyricHiveAdapter.toMapList(data[i].lyricsList),
            'createAt': data[i].createAt,
            'heading': data[i].heading,
            'title': data[i].title,
            'guideIsVisible': data[i].guideIsVisible,
          }
      );
    }
    return map;
  }
  static List<ServiceHiveDTO> toDTOList(List<ServiceEntity> entities) {
    List<ServiceHiveDTO> services = [];
    for (ServiceEntity service in entities) {
      services.add(
        ServiceHiveDTO(
          id: '',
          liturgyList: LiturgyHiveAdapter.toDTOList(service.liturgyList),
          lyricsList: LyricHiveAdapter.toDTOList(service.lyricsList),
          createAt: service.createAt,
          heading: service.heading,
          title: service.title,
          guideIsVisible: service.guideIsVisible,
        ),
      );
    }
    return services;
  }
 /* static List<ServiceHiveDTO> fromMapList(dynamic data) {
    List<ServiceHiveDTO> services = [];
    for (int i = 0; data.length > i; i++) {
      services.add(
        ServiceHiveDTO(
          id: '',
          liturgyList: LiturgyHiveAdapter.fromMap(data[i]['liturgyList']),
          lyricsList: LyricHiveAdapter.fromListMap(data[i]['lyricsList']),
          createAt: data[i]['createAt'],
          heading: data[i]['heading'],
          title: data[i]['title'],
          guideIsVisible: data[i]['guideIsVisible'],
        ),
      );
    }
    return services;
  }*/
}
