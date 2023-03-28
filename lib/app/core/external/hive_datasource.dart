import 'package:ipbc_palmas/app/lyric/domain/entities/service_entity.dart';

import '../../lyric/infra/adapters/hive-dtos/database_configs_hive_adapter.dart';
import '../../lyric/infra/adapters/hive-dtos/lyric_hive_adapter.dart';
import '../../lyric/infra/adapters/hive-dtos/service_hive_adapter.dart';
import '../../lyric/infra/adapters/lyric_adapter.dart';
import '../../lyric/infra/adapters/service_adapter.dart';
import '../../lyric/infra/models/hive-dtos/database_configs_hive_dto.dart';
import '../../lyric/infra/models/hive-dtos/lyric_hive_dto.dart';
import '../../lyric/infra/models/hive-dtos/service_hive_dto.dart';
import '../../lyric/infra/models/hive-dtos/services_list_hive_dto.dart';
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
      ServicesListHiveDTOAdapter(),
    );
  }

  @override
  Stream<List<Map>> get(String path) {
    params = path.split('/');
    var entities = box.get(params[0]);
    if(entities != null){
      return Stream.value(_getAdapter(entities));
    }
    return Stream.value(List.empty());
  }

  @override
  Future<void> add(String path, data) async {
    params = path.split('/');
    box.put(path, addAdapter(params[0], data));
  }

  @override
  Future<void> update(String path, data) async {}

  @override
  Future<void> delete(String path) async {
    box.delete(path);
  }

  dynamic addAdapter(path, entities) {
    switch (path) {
      case 'lyrics':
        return LyricHiveAdapter.toDTOList(entities);
      case 'database-configs':
        return entities;
      case 'services':
        return ServiceHiveAdapter.toDTOList(entities);
      default:
        return List.empty();
    }
  }

  List<Map<String, dynamic>> _getAdapter(entities) {
    switch (R) {
      case List<LyricHiveDTO>:
        return LyricHiveAdapter.toMapList(entities as List<LyricHiveDTO>);
      case DatabaseConfigsHiveDTO:
        return DatabaseConfigsHiveAdapter.toMapList(entities as DatabaseConfigsHiveDTO);
      case List<ServiceHiveDTO>:
        return ServiceHiveAdapter.toMapList(entities as List<ServiceHiveDTO>);
      default:
        return entities;
    }
  }
}
