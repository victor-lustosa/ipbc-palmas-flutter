// import '../../../../core_module.dart';
//
// class IsarRepository<T> implements IRepository {
//
//   static late Isar isar;
//
//   IsarRepository();
//
//   static Future init() async {
//     final dir = await getApplicationDocumentsDirectory();
//      isar = await Isar.open(
//       [],
//       directory: dir.path,
//     );
//   }
//
//
//   @override
//   Future<dynamic> get(String path) async {
//     await isar.writeTxn(() async {
//     });
//   }
//
//   @override
//   Future<void> add(String path, data) async {}
//
//   @override
//   Future<void> update(String path, data) async {
//   }
//
//   @override
//   Future<void> delete(String path) async {
//   }
// }
