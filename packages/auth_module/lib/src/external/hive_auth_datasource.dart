
import 'package:core_module/core_module.dart';
import '../infra/datasources/auth_datasource.dart';

class HiveAuthDatasource<R> implements IAuthDatasource<R>,IDatasource {
  String boxLabel;
  late Box<R> box;

  HiveAuthDatasource({required this.boxLabel}) {
    box = Hive.box<R>(boxLabel);
  }

  static Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HiveAuthDTOAdapter());
    await Future.wait<void>([
      Hive.openBox<HiveAuthDTO>('auth'),
    ]);
  }

  @override
  Future<dynamic> get(String path) async {
    var result = box.get(path);
    return result != null ? HiveAuthAdapter.fromMap(result as HiveAuthDTO) : HiveAuthDTO.empty();
  }

  @override
  Future<void> add(String path, data) async {}

  @override
  Future<void> update(String path, data) async {
    box.put(path, HiveAuthAdapter.toDTO(data) as R);
  }

  @override
  Future<void> delete(String path) async {
    box.delete(path);
  }

  @override
  Future<String> signInWithEmail(String email, String password) {
    throw UnimplementedError();
  }
}
