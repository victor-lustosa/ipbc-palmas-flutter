import '../../../core_module.dart';

class HiveDatasource<R> implements IDatasource {
  String boxLabel;
  late Box<R> box;
  List<String> params = [];

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
    params = path.split('/');
    switch (params[0]) {
      case 'auth':
        var result = box.values.where((entity) => (entity as HiveAuthDTO).password == params[2]  && entity.email == params[1]).toList();
        return result.isNotEmpty ? (result[0] as HiveAuthDTO) : HiveAuthDTO.empty();
    }
  }

  @override
  Future<void> add(String path, data) async {}

  @override
  Future<void> update(String path, data) async {
    params = path.split('/');
    switch (params[0]) {
      case 'auth':
        box.put(params[1], HiveAuthAdapter.toDTO(data) as R);
        break;
    }
  }

  @override
  Future<void> delete(String path) async {
    params = path.split('/');
    box.delete(params[0]);
  }
}
