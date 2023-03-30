
import 'package:ipbc_palmas/app/lyric/domain/entities/services_list_entity.dart';

import '../../../domain/entities/service_entity.dart';
import '../../models/hive-dtos/service_hive_dto.dart';
import '../../models/hive-dtos/hive_services_list_dto.dart';
import 'liturgy_hive_adapter.dart';
import 'lyric_hive_adapter.dart';

class ServiceHiveAdapter {

  static List<Map<String, dynamic>> toMapList(HiveServicesListDTO data) {
    List<Map<String, dynamic>> map = [];
    for (int i = 0; data.servicesList.length > i; i++) {
      map.add({
            'id': data.servicesList[i].id,
            'liturgyList': LiturgyHiveAdapter.toMapList(data.servicesList[i].liturgyList),
            'lyricsList': LyricHiveAdapter.toMapList(data.servicesList[i].lyricsList),
            'createAt': data.servicesList[i].createAt,
            'heading': data.servicesList[i].heading,
            'title': data.servicesList[i].title,
            'guideIsVisible': data.servicesList[i].guideIsVisible,
          }
      );
    }
    return [{'servicesList':map, 'createAt': data.createAt}];
  }

  static Future<HiveServicesListDTO> toDTOList(ServicesListEntity entities) async {
    List<ServiceHiveDTO> services = [];
    for (ServiceEntity service in entities.servicesList) {
      services.add(
        ServiceHiveDTO(
          id: '',
          liturgyList: await LiturgyHiveAdapter.toDTOList(service.liturgyList),
          lyricsList: await LyricHiveAdapter.toDTOList(service.lyricsList),
          createAt: service.createAt,
          heading: service.heading,
          title: service.title,
          guideIsVisible: service.guideIsVisible,
        ),
      );
    }
    return HiveServicesListDTO(servicesList: services, createAt: entities.createAt);
  }

}
