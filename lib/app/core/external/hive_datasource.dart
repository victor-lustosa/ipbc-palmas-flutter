import 'package:hive_flutter/hive_flutter.dart';
import '../../lyric/domain/entities/lyric_entity.dart';
import '../../lyric/domain/entities/service_entity.dart';
import '../../lyric/infra/adapters/hive-dtos/hive_services_collection_adapter.dart';
import '../../lyric/infra/adapters/hive-dtos/hive_lyric_adapter.dart';
import '../../lyric/infra/adapters/hive-dtos/hive_service_adapter.dart';
import '../../lyric/infra/models/firestore-dtos/services_collection_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_service_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_liturgy_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_lyric_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_services_collection_dto.dart';
import '../../lyric/infra/models/hive-dtos/hive_verse_dto.dart';
import '../../shared/components/utils/service_util.dart';
import '../infra/datasources/datasource.dart';

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
  Future<dynamic> get(String path) async {
    params = path.split('/');
    switch (params[0]) {
      case 'services':
        var result = box.values
            .where((entity) => (entity as HiveServiceDTO).type == params[1])
            .toList();
        (result as List<HiveServiceDTO>)
            .sort((a, b) => a.createAt.compareTo(b.createAt));
        return Stream.value(result.map(HiveServiceAdapter.toMap).toList());
      case 'lyrics':
        var result = box.values.toList();
        (result as List<HiveLyricDTO>)
            .sort((a, b) => a.createAt.compareTo(b.createAt));
        return Stream.value(
            HiveLyricAdapter.toMapList(result as List<HiveLyricDTO>));
      case 'services-collection':
        var result = box.values.toList();
        return Stream.value(
            result.map(HiveServicesCollectionAdapter.toMap).toList());
      case 'database-configs':
        var result = box.get(params[0]);
        return Stream.value(
          result != null
              ? (result as HiveDatabaseConfigsDTO)
              : HiveDatabaseConfigsDTO(
                  hiveUpdateId: 'fdg33f345',
                  fireUpdateId: 'fdg33f345',
                  isLyricsUpdated: false,
                  isServicesUpdated: false,
                  isSundayMorningCollectionUpdated: false,
                  isSaturdayCollectionUpdated: false,
                  isSundayEveningCollectionUpdated: false,
                  isSystemUpdated: false,
                ),
        );
      default:
        return Stream.value([]);
    }
  }

  @override
  Future<void> add(String path, data) async {
    params = path.split('/');
    switch (params[0]) {
      case 'lyrics':
        for(LyricEntity entity in data as List<LyricEntity>) {
        box.add(HiveLyricAdapter.toDTO(entity) as R);
        }
        break;
      case 'services':
        for(ServiceEntity entity in data as List<ServiceEntity>) {
          box.add(HiveServiceAdapter.toDTO(entity) as R);
        }
        break;
      case 'services-collection':
       for(ServicesCollectionDTO entity in data as List<ServicesCollectionDTO>){
          box.add(HiveServicesCollectionAdapter.toDTO(entity) as R);
        }
        break;
    }
  }

  @override
  Future<void> update(String path, data) async {
    params = path.split('/');
    switch (params[0]) {
      case 'lyrics':
        for(LyricEntity entity in data as List<LyricEntity>) {
          box.put(entity.id,HiveLyricAdapter.toDTO(entity) as R);
        }
        break;
      case 'services':
        for(ServiceEntity entity in data as List<ServiceEntity>) {
          box.put(entity.id, HiveServiceAdapter.toDTO(entity) as R);
        }
        break;
      case 'services-collection':
        for(ServicesCollectionDTO entity in data as List<ServicesCollectionDTO>){
          box.put(entity.id, HiveServicesCollectionAdapter.toDTO(entity) as R);
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
