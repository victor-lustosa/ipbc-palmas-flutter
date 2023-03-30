
import '../../lyric/infra/adapters/hive-dtos/lyric_hive_adapter.dart';
import '../../lyric/infra/adapters/hive-dtos/service_hive_adapter.dart';
import '../../lyric/infra/models/hive-dtos/database_configs_hive_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_lyrics_list_dto.dart';
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
    Hive.registerAdapter(
      HiveLyricsListDTOAdapter(),
    );
  }

  @override
  Future<Stream<List<Map>>> get(String path) async {
    params = path.split('/');
    return Stream.value(_getAdapter(box.get(params[0]) as R));
  }

  @override
  Future<void> add(String path, data) async {
    params = path.split('/');
    box.put(params[0], _addAdapter(data) as R);
  }

  @override
  Future<void> update(String path, data) async {}

  @override
  Future<void> delete(String path) async {
    box.delete(path);
  }

  R? _addAdapter(entities) {
    switch (R) {
      case HiveLyricsListDTO:
        return LyricHiveAdapter.toHiveLyricsListDTO(entities) as R;
      case HiveServicesListDTO:
        return ServiceHiveAdapter.toDTOList(entities) as R;
      case DatabaseConfigsHiveDTO:
        return entities;
    }
    return null;
  }

  dynamic _getAdapter(R? entities)  {
    switch (R) {
      case HiveLyricsListDTO:
        return LyricHiveAdapter.toMapHiveLyricsListDTO(entities as HiveLyricsListDTO);
      case HiveServicesListDTO:
        return ServiceHiveAdapter.toMapList(entities as HiveServicesListDTO);
      case DatabaseConfigsHiveDTO:
        return entities;
    }
  }
}
