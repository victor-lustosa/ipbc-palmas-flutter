import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:ipbc_palmas/app/core/external/firestore_datasource.dart';

void main() {
  test('getting lyrics firestore datasource', () async {
    final firestore = FakeFirebaseFirestore();

    final datasource = FirestoreDatasource(firestore: firestore);

    final result = datasource.get('lyrics/1');

    expect(result, emits(isA<List<Map>>()));
  });
}
