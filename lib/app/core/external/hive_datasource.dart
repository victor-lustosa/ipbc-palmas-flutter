import '../../lyric/infra/adapters/hive-dtos/hive_services_collection_adapter.dart';

import '../../lyric/infra/adapters/hive-dtos/hive_database_configs_adapter.dart';
import '../../lyric/infra/adapters/hive-dtos/hive_lyric_adapter.dart';
import '../../lyric/infra/adapters/hive-dtos/hive_service_adapter.dart';
import '../../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_service_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_liturgy_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_lyric_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_services_collection_dto.dart';
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
      HiveServicesCollectionDTOAdapter(),
    );
    Hive.registerAdapter(
      HiveVerseDTOAdapter(),
    );

    Hive.registerAdapter(
      HiveLiturgyDTOAdapter(),
    );
  }

  @override
  Future<Stream<List<Map>>> get(String path) async {
    params = path.split('/');
    switch (params[0]) {
      case 'services':
        var result = box.values.where((entity) => (entity as HiveServiceDTO).type == params[1]).toList();
        (result as List<HiveServiceDTO>).sort((a,b) => a.createAt.compareTo(b.createAt));
        return Stream.value(result.map(HiveServiceAdapter.toMap).toList());
      case 'lyrics':
        var result =  box.values.toList();
        (result as List<HiveLyricDTO>).sort((a,b) => a.createAt.compareTo(b.createAt));
        return Stream.value(HiveLyricAdapter.toMapList(result as List<HiveLyricDTO>));
      case 'services-collection':
        var result =  box.values.toList();
        return Stream.value(result.map(HiveServicesCollectionAdapter.toMap).toList());
      case 'database-configs':
        return Stream.value(HiveDatabaseConfigsAdapter.toMapList(box.get(params[0]) as HiveDatabaseConfigsDTO));
      default:
        return Stream.value([]);
    }
  }

  @override
  Future<void> add(String path, data) async {
    params = path.split('/');
    switch (params[0]) {
      case 'lyrics':
        box.add(HiveLyricAdapter.toDTO(data) as R);
        break;
      case 'services':
        box.add(HiveServiceAdapter.toDTO(data) as R);
        break;
      case 'services-collection':
        box.add(HiveServicesCollectionAdapter.toDTO(data) as R);
        break;
      case 'database-configs':
        box.put(params[0], data as R);
    }
  }

  @override
  Future<void> update(String path, data) async {
    params = path.split('/');
    switch (params[0]) {
      case 'lyrics':
        box.put(params[0], HiveLyricAdapter.toDTO(data) as R);
        break;
      case 'services':
        box.put(params[0], HiveServiceAdapter.toDTO(data) as R);
        break;
      case 'services-collection':
        box.put(params[0], HiveServicesCollectionAdapter.toDTO(data) as R);
        break;
      case 'database-configs':
        box.put(params[0], data as R);
    }
  }

  @override
  Future<void> delete(String path) async {
    box.delete(path);
  }
}
