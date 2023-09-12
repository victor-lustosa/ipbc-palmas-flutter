
import 'package:lyric_module/lyric_module.dart';

import 'hive_liturgy_adapter.dart';

import '../../models/hive-dtos/hive_collection_dto.dart';
import '../../../domain/entities/service_entity.dart';

class HiveCollectionAdapter {
  static Map<String, dynamic> toMap(dynamic data) {
    return {
      'id': data.id,
      'liturgyList': HiveLiturgyAdapter.toMapList(data.liturgyList),
      'lyricsList': HiveLyricAdapter.toMapList(data.entitiesList),
      'createAt': data.createAt,
      'heading': data.heading,
      'title': data.title,
      'type': data.type,
      'theme': data.theme,
      'image': data.image,
      'hour': data.hour,
      'preacher': data.preacher,
      'guideIsVisible': data.guideIsVisible,
    };
  }

  static HiveCollectionDTO toDTO(ServiceEntity entity) {
    return HiveCollectionDTO(
      id: entity.id,
      liturgyList: HiveLiturgyAdapter.toDTOList(entity.liturgyList),
      lyricsList: HiveLyricAdapter.toDTOList(entity.lyricsList),
      createAt: entity.createAt.toString(),
      heading: entity.heading,
      title: entity.title,
      theme: entity.theme,
      preacher: entity.preacher,
      guideIsVisible: entity.guideIsVisible,
      type: entity.type,
      image: entity.image,
      hour: entity.hour,
    );
  }
}
