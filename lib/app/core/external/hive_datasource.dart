
import '../../lyric/infra/adapters/hive-dtos/lyric_hive_adapter.dart';
import '../../lyric/infra/adapters/hive-dtos/service_hive_adapter.dart';
import '../../lyric/infra/models/hive-dtos/database_configs_hive_dto.dart';
import '../../lyric/infra/models/hive-dtos/liturgy_hive_dto.dart';
import '../../lyric/infra/models/hive-dtos/lyric_hive_dto.dart';
import '../../lyric/infra/models/hive-dtos/service_hive_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_services_list_dto.dart';
import '../../lyric/infra/models/hive-dtos/verse_hive_dto.dart';
import '../infra/datasources/datasource.dart';

import 'package:hive_flutter/hive_flutter.dart';

class HiveDatasource<R> implements IDatasource {
  String boxLabel;
  late Box<R> box;
  List<String> params = [];

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
    Hive.registerAdapter(
      HiveServicesListDTOAdapter(),
    );
    Hive.registerAdapter(
      LiturgyHiveDTOAdapter(),
    );
  }

  @override
  Future<Stream<List<Map>>> get(String path) async {
    params = path.split('/');
    return Stream.value(getAdapter(box.get(params[0]) as R));
  }

  @override
  Future<void> add(String path, data) async {
    params = path.split('/');
    String hivePath = params[0];
    box.put(hivePath, addAdapter(hivePath, data) as R);
  }

  @override
  Future<void> update(String path, data) async {}

  @override
  Future<void> delete(String path) async {
    box.delete(path);
  }

  R? addAdapter(path, entities) {
    switch (path) {
      case 'lyrics':
        return LyricHiveAdapter.toDTOList(entities) as R;
      case 'database-configs':
        return entities;
      case 'services':
        return ServiceHiveAdapter.toDTOList(entities) as R;
    }
    return null;
  }

  dynamic getAdapter(R? entities)  {
    switch (R) {
      case List<LyricHiveDTO>:
        return LyricHiveAdapter.toMapList(entities as List<LyricHiveDTO>);
      case DatabaseConfigsHiveDTO:
        return entities;
      case HiveServicesListDTO:
        return ServiceHiveAdapter.toMapList(entities as HiveServicesListDTO);
    }
  }
}
