import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
part 'database_configs_hive_dto.g.dart';
@HiveType(typeId: 3)
class DatabaseConfigsHiveDTO extends HiveObject {

  @HiveField(0)
  DateTime updateAt;

  factory DatabaseConfigsHiveDTO.create(
      {required DateTime updateAt }) =>
      DatabaseConfigsHiveDTO(updateAt: updateAt);

  DatabaseConfigsHiveDTO({
    required this.updateAt,
  });
}
