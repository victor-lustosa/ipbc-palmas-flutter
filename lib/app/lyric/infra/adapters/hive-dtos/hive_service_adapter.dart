
import '../../../domain/entities/service_entity.dart';
import '../../models/hive-dtos/hive_service_dto.dart';
import '../../models/hive-dtos/hive_services_list_dto.dart';
import 'hive_liturgy_adapter.dart';
import 'hive_lyric_adapter.dart';

class HiveServiceAdapter {
  static Map<String, dynamic> toMapList(dynamic data) {
    return {
      'id': data.id,
      'liturgyList': HiveLiturgyAdapter.toMapList(data.liturgyList),
      'lyricsList': HiveLyricAdapter.toMapList(data.lyricsList),
      'createAt': data.createAt,
      'heading': data.heading,
      'title': data.title,
      'guideIsVisible': data.guideIsVisible,
    };
  }

  static HiveServiceDTO toDTOList(ServiceEntity entity, String type) {
    return  HiveServiceDTO(
        id: '',
        liturgyList: HiveLiturgyAdapter.toDTOList(entity.liturgyList),
        lyricsList: HiveLyricAdapter.toDTOList(entity.lyricsList),
        createAt: entity.createAt,
        heading: entity.heading,
        title: entity.title,
        guideIsVisible: entity.guideIsVisible,
        type: type
    );
  }
}
