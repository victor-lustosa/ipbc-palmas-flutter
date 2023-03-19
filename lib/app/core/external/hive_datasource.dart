import 'package:ipbc_palmas/app/shared/components/splash/infra/models/hive-dtos/verse_hive_dto.dart';
import '../../shared/components/splash/infra/models/hive-dtos/lyric_hive_dto.dart';
import '../../shared/components/splash/infra/models/hive-dtos/database_configs_hive_dto.dart';
import '../../shared/components/splash/infra/models/hive-dtos/service_hive_dto.dart';
import '../infra/datasources/datasource.dart';

import 'package:hive_flutter/hive_flutter.dart';

class HiveDatasource<R> implements IDatasource<R> {
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
  R? get(String path) {
    return box.get(path);
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
