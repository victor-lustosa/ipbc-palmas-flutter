
import '../../lyric/infra/models/firestore-dtos/settings_dto.dart';
import '../infra/datasources/datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatasource implements IDatasource{
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
  Future<Stream<List<Map>>> get(String url) async {
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

  Future<Stream<List>> verifyUpdateDatasource(String url) async  {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;
    snapshot = _firestore.collection(url).snapshots();
    List<Map> result = [];
    return snapshot.map((entity) => entity.docs.map(
        (doc) =>  SettingsDTO(updateAt: doc.get('updateAt'))

    ).toList());
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
    if (params.length > 2) {
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
  Future<void> delete(String url) {
    throw UnimplementedError();
  }
}
