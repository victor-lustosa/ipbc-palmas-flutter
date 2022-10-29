import 'package:cloud_firestore/cloud_firestore.dart';

import '../../infra/datasources/lyric_datasource.dart';

class LyricFirestoreDatasource implements ILyricDatasource {
  final FirebaseFirestore _firestore;

  LyricFirestoreDatasource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  List<Map> _convert(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    return docs
        .map((document) => {
              'id': document.id,
              ...document.data(),
            })
        .toList();
  }

  @override
  Stream<List<Map>> get() {
    final snapshot = _firestore.collection('lyrics').snapshots();
    return snapshot.map((lyric) => lyric.docs).map(_convert);
  }
}
