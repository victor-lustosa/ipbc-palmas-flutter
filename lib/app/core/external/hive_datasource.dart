import '../../shared/components/splash/infra/adapters/lyric_hive_adapter.dart';
import '../../shared/components/splash/infra/models/hive-dtos/verse_hive_dto.dart';
import '../../shared/components/splash/infra/models/hive-dtos/lyric_hive_dto.dart';
import '../../shared/components/splash/infra/models/hive-dtos/database_configs_hive_dto.dart';
import '../../shared/components/splash/infra/models/hive-dtos/service_hive_dto.dart';
import '../infra/datasources/datasource.dart';

import 'package:hive_flutter/hive_flutter.dart';

class HiveDatasource<R> implements IDatasource {
  String boxLabel;
  late Box<R> box;

  HiveDatasource({required this.boxLabel}) {
    box = Hive.box<R>(boxLabel);
  }

  static Future initHive() async {
    Hive.registerAdapter(
      DatabaseConfigsHiveDTOAdapter(),
    );
    Hive.registerAdapter(
      LyricHiveDTOAdapter(),
    );
    Hive.registerAdapter(
      ServiceHiveDTOAdapter(),
    );
    Hive.registerAdapter(
      VerseHiveDTOAdapter(),
    );
  }

  @override
  Stream<List<Map>> get(String path) {

    List<R> result = [];
    result.add(box.get(path) as R);
    return Stream.value(LyricHiveAdapter.toMapList(result as List<LyricHiveDTO>));
  }

  @override
  Future<void> add(String path, data) async {
    box.put(path, data);
  }

  @override
  Future<void> update(String path, data) async {}

  @override
  Future<void> delete(String path) async {
    box.delete(path);
  }
}
