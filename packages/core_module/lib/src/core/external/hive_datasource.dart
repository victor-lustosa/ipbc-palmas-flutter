import '../../../core_module.dart';

class HiveDatasource<R> implements IDatasource {
  String boxLabel;
  late Box<R> box;

  HiveDatasource({required this.boxLabel}) {
    box = Hive.box<R>(boxLabel);
  }

  static Future init() async {
    await Hive.initFlutter();
    _allAdapters();
    await Future.wait<void>([
      Hive.openBox<HiveAuthDTO>('auth'),
    ]);
  }

  static _allAdapters() {
    Hive.registerAdapter(HiveAuthDTOAdapter());
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
}
