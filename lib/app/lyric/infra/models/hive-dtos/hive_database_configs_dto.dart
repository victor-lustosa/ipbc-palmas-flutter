import 'package:hive/hive.dart';
part 'hive_database_configs_dto.g.dart';

@HiveType(typeId: 3)
class HiveDatabaseConfigsDTO {
  @HiveField(0)
  DateTime updateAt;

  HiveDatabaseConfigsDTO({
    required this.updateAt,
  });
}
