import 'package:ipbc_palmas/app/lyric/domain/entities/service_entity.dart';
import 'package:ipbc_palmas/app/lyric/infra/adapters/hive-dtos/hive_database_configs_adapter.dart';
import 'package:ipbc_palmas/app/lyric/infra/models/hive-dtos/hive_services_list_dto.dart';

import '../../lyric/infra/adapters/hive-dtos/hive_lyric_adapter.dart';
import '../../lyric/infra/adapters/hive-dtos/hive_service_adapter.dart';
import '../../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_lyrics_list_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_service_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_liturgy_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_lyric_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_verse_dto.dart';
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
      HiveDatabaseConfigsDTOAdapter(),
    );
    Hive.registerAdapter(
      HiveLyricDTOAdapter(),
    );
    Hive.registerAdapter(
      HiveServiceDTOAdapter(),
    );
    Hive.registerAdapter(
      HiveVerseDTOAdapter(),
    );

    Hive.registerAdapter(
      HiveLiturgyDTOAdapter(),
    );
    Hive.registerAdapter(
      HiveLyricsListDTOAdapter(),
    );
  }

  @override
  Future<Stream<List<Map>>> get(String path) async {
    params = path.split('/');
    switch (params[0]) {
      case 'services':
        var result = box.values.where((entity) => (entity as HiveServiceDTO).type == params[1]).toList();
       // (result as List<HiveServiceDTO>).sort((a,b) => a.createAt.compareTo(b.createAt));
        return Stream.value(result.map(HiveServiceAdapter.toMapList).toList());
      case 'lyrics':
        return Stream.value(HiveLyricAdapter.toHiveLyricsMapList(box.get(params[0]) as HiveLyricsListDTO));
      default:
        return Stream.value(HiveDatabaseConfigsAdapter.toMapList(box.get(params[0]) as HiveDatabaseConfigsDTO));
    }
  }

  @override
  Future<void> add(String path, data) async {
    params = path.split('/');
  //  R? list = _addAdapter(data, params[1]);
    switch (params[0]) {
      case 'lyrics':
        box.put(params[0], HiveLyricAdapter.toHiveLyricsList(data).lyricsList as R);
        break;
      case 'services':
        box.put(params[0], (data as List<ServiceEntity>).map((e) => HiveServiceAdapter.toDTOList(e, params[1])).toList() as R);
        break;
      case 'database-configs':
        box.put(params[0], data as R);
    }
  //  return box.put(params[0], list as R);
  }

  @override
  Future<void> update(String path, data) async {}

  @override
  Future<void> delete(String path) async {
    box.delete(path);
  }

}
