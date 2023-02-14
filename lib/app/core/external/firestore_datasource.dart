import '../infra/datasources/datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IFirestoreDatasource
    implements
        IGetDatasource,
        IAddDatasource,
        IUpdateDatasource,
        IDeleteDatasource {}

class FirestoreDatasource implements IFirestoreDatasource {
  FirestoreDatasource({required FirebaseFirestore firestore})
      : _firestore = firestore;
  final FirebaseFirestore _firestore;
  List<String> params = [];
  List<Map> _convert(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    return docs.map((document) => {
              'id': document.id,
              ...document.data(),
            }).toList();
  }

  @override
  Stream<List<Map>> get(String url) {
    params = url.split('/');
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;
    if (params.length > 2) {
      snapshot = _firestore
          .collection(params[0])
          .doc(params[1])
          .collection(params[2])
          .limit(int.parse(params[3]))
          .snapshots();
    } else {
      snapshot = _firestore
          .collection(params[0])
          .limit(int.parse(params[1]))
          .snapshots();
    }
    return snapshot.map((entity) => entity.docs).map(_convert);
  }

  @override
  Stream<List<Map>> getByCreateAt(String url) {
    params = url.split('/');
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;
    if (params.length > 2) {
      snapshot = _firestore
          .collection(params[0])
          .doc(params[1])
          .collection(params[2])
          .orderBy("createAt", descending: true)
          .limit(int.parse(params[3]))
          .snapshots();
    } else {
      snapshot = _firestore
          .collection(params[0])
          .orderBy("createAt", descending: true)
          .limit(int.parse(params[1]))
          .snapshots();
    }
    return snapshot.map((entity) => entity.docs).map(_convert);
  }

  @override
  Future<void> add(String url, data) async {
    params = url.split('/');
    if (params.length > 1) {
      _firestore
          .collection(params[0])
          .doc(params[1])
          .collection(params[2])
          .add(data);
    } else {
      _firestore.collection(params[0]).add(data);
    }
  }

  @override
  Future<void> update(String url, data) async {
    params = url.split('/');
    if (params.length > 1) {
      _firestore
          .collection(params[0])
          .doc(params[1])
          .collection(params[2])
          .doc(params[3])
          .update(data);
    } else {
      _firestore.collection(params[0]).doc(params[1]).update(data);
    }
  }

  @override
  Future<void> delete(String url, id) {
    throw UnimplementedError();
  }
}
