// import '../../../../core_module.dart';
//
// class HiveRepository<R> implements IRepository {
//   String boxLabel;
//   late Box<R> box;
//
//   HiveRepository({required this.boxLabel}) {
//     box = Hive.box<R>(boxLabel);
//   }
//
//   static Future init() async {
//     await Hive.initFlutter();
//     _allAdapters();
//     await Future.wait<void>([
//       //    Hive.openBox<HiveAuthDTO>('auth'),
//     ]);
//   }
//
//   static _allAdapters() {
//     //  Hive.registerAdapter(HiveAuthDTOAdapter());
//   }
//
//   @override
//   Future<dynamic> get({String? path, String? id}) async {
//     var result = box.get(path);
// //        return result != null ? HiveAuthAdapter.fromMap(result as HiveAuthDTO) : HiveAuthDTO.empty();
//   }
//
//   @override
//   Future<void> update({required data, String? path, String? id}) async {
//     //   box.put(path, HiveAuthAdapter.toDTO(data) as R);
//   }
//
//   @override
//   Future<void> delete({String? path, String? id}) async {
//     box.delete(path);
//   }
//
//   @override
//   Future<void> add({required data, String? path, String? id}) {
//     throw UnimplementedError();
//   }
//
// }
