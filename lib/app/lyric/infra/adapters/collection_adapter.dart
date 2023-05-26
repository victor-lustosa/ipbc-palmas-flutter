import 'package:cloud_firestore/cloud_firestore.dart';

import 'lyric_adapter.dart';
import 'liturgy_adapter.dart';

import '../../domain/entities/collection_entity.dart';
// ignore: depend_on_referenced_packages

class CollectionAdapter {
  static List<CollectionEntity> fromMapList(dynamic data) {
    List<CollectionEntity> services = [];
    for (dynamic entity in data) {
      services.add(
        CollectionEntity(
          type: entity['type'],
          hour: entity['hour'],
          liturgyList: LiturgyAdapter.fromMap(entity['liturgyList']),
          lyricsList: LyricAdapter.fromListMap(entity['lyricsList']),
          createAt: entity['createAt'].runtimeType == String
              ? DateTime.parse(entity['createAt'])
              : (entity['createAt'] as Timestamp).toDate(),
          heading: entity['heading'],
          title: entity['title'],
          guideIsVisible: entity['guideIsVisible'],
          theme: entity['theme'],
          image: entity['image'],
          id: entity['id'],
          preacher: entity['preacher'],
        ),
      );
    }
    return services;
  }
}
