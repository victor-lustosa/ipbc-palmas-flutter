import 'package:hive/hive.dart';
part 'database_configs_hive_dto.g.dart';

@HiveType(typeId: 3)
class DatabaseConfigsHiveDTO {
  @HiveField(0)
  DateTime updateAt;

  DatabaseConfigsHiveDTO({
    required this.updateAt,
  });
}
