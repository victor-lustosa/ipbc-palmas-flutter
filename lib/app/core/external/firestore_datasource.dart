import '../infra/datasources/datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatasource
    implements
        IGetDatasource,
        IAddDatasource,
        IUpdateDatasource,
        IDeleteDatasource {
  FirestoreDatasource({required FirebaseFirestore firestore})
      : _firestore = firestore;
  final FirebaseFirestore _firestore;
  late List<String> params;
  List<Map> _convert(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    return docs
        .map((document) => {
              'id': document.id,
              ...document.data(),
            })
        .toList();
  }

  @override
  Stream<List<Map>> get(String url) {
    params = url.split('/');
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;
    if (params.length > 1) {
      snapshot = _firestore
          .collection(params[0])
          .doc(params[1])
          .collection(params[2])
          .orderBy("createAt", descending: true)
          .limit(20)
          .snapshots();
    } else {
      snapshot = _firestore
          .collection(params[0])
          .orderBy("createAt", descending: true)
          .limit(20)
          .snapshots();
    }
    return snapshot.map((entity) => entity.docs).map(_convert);
  }

  @override
  Future<void> add(String url, data) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> update(String url, id) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String url, id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
