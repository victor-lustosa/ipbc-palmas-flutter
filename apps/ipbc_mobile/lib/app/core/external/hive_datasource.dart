import 'package:core_module/core_module.dart';
import 'package:hive/hive.dart';
import '../../lyric/domain/entities/lyric_entity.dart';
import '../../lyric/domain/entities/service_entity.dart';
import '../../lyric/infra/models/hive-dtos/hive_lyric_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_verse_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_liturgy_dto.dart';
import '../../lyric/domain/entities/services_entity.dart';
import '../../lyric/infra/models/hive-dtos/hive_services_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_collection_dto.dart';
import '../../lyric/infra/adapters/hive-dtos/hive_lyric_adapter.dart';
import '../../lyric/infra/adapters/hive-dtos/hive_services_adapter.dart';
import '../../lyric/infra/adapters/hive-dtos/hive_collection_adapter.dart';
import '../../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';

class HiveDatasource<R> implements IDatasource {
  String boxLabel;
  late Box<R> box;
  List<String> params = [];

  HiveDatasource({required this.boxLabel}) {
    box = Hive.box<R>(boxLabel);
  }

  static Future initHive() async {
    Hive.registerAdapter(HiveDatabaseConfigsDTOAdapter());
    Hive.registerAdapter(HiveLyricDTOAdapter());
    Hive.registerAdapter(HiveServiceDTOAdapter());
    Hive.registerAdapter(HiveServicesDTOAdapter());
    Hive.registerAdapter(HiveVerseDTOAdapter());
    Hive.registerAdapter(HiveLiturgyDTOAdapter());
  }

  @override
  Future<dynamic> get(String path) async {
    params = path.split('/');
    switch (params[0]) {
      case 'services-collection':
        var result = box.values.where((entity) => (entity as HiveCollectionDTO).type == params[1]).toList();
        (result as List<HiveCollectionDTO>).sort((a, b) => b.createAt.compareTo(a.createAt));
        return Stream.value(result.map(HiveCollectionAdapter.toMap).toList());

      case 'lyrics':
        var result = box.values.toList();
        (result as List<HiveLyricDTO>).sort((a, b) => b.createAt.compareTo(a.createAt));
        return Stream.value(HiveLyricAdapter.toMapList(result as List<HiveLyricDTO>));

      case 'services':
        var result = box.values.toList();
        return Stream.value(result.map(HiveServicesAdapter.toMap).toList());

      case 'database-configs':
        var result = box.get(params[0]);
        return Stream.value(
          result != null
              ? (result as HiveDatabaseConfigsDTO)
              : HiveDatabaseConfigsDTO.empty().copyWith(fireId: '000000000'),
        );
      default:
        return Stream.value([]);
    }
  }

  @override
  Future<void> add(String path, data) async {}

  @override
  Future<void> update(String path, data) async {
    params = path.split('/');
    switch (params[0]) {
      case 'services-collection':
        for (ServiceEntity entity in data as List<ServiceEntity>) {
          box.put(entity.id, HiveCollectionAdapter.toDTO(entity) as R);
        }
        break;
      case 'lyrics':
        for (LyricEntity entity in data as List<LyricEntity>) {
          box.put(entity.id, HiveLyricAdapter.toDTO(entity) as R);
        }
        break;
      case 'services':
        for (ServicesEntity entity in data as List<ServicesEntity>) {
          box.put(entity.id, HiveServicesAdapter.toDTO(entity) as R);
        }
        break;
      case 'database-configs':
        box.put(params[0], data as R);
        break;
    }
  }

  @override
  Future<void> delete(String path) async {
    params = path.split('/');
    box.delete(params[0]);
  }
}
