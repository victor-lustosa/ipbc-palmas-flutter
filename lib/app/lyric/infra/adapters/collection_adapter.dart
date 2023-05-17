
import 'liturgy_adapter.dart';
import 'lyric_adapter.dart';
import '../../domain/entities/collection_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;

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
              ? entity['createAt']
              : DateFormat('dd/MM/yyyy')
                  .format((entity['createAt'] as Timestamp).toDate())
                  .toString(),
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
