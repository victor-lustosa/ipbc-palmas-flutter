import 'package:ipbc_palmas/app/shared/components/splash/infra/models/hive-dtos/services_list_hive_dto.dart';

import '../../shared/components/splash/infra/adapters/database_configs_hive_adapter.dart';
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
    Hive.registerAdapter(
      ServicesListHiveDTOAdapter(),
    );
  }

  @override
  Stream<List<Map>> get(String path) {
    return Stream.value(_convertToMap(box.get(path) as R));
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

  List<Map<String, dynamic>> _convertToMap(entities){
    switch(R){
      case List<LyricHiveDTO>:
        return LyricHiveAdapter.toMapList(entities as List<LyricHiveDTO>);
      case DatabaseConfigsHiveDTO:
        return DatabaseConfigsHiveAdapter.toMapList(entities as DatabaseConfigsHiveDTO);
    }
    return List.empty();
  }
}
