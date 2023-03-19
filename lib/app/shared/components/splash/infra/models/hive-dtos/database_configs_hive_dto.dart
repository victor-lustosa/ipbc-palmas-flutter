
import 'package:hive/hive.dart';

import '../generic_hive_dto.dart';
part 'database_configs_hive_dto.g.dart';
@HiveType(typeId: 3)
class DatabaseConfigsHiveDTO extends GenericHiveDTO {

  @HiveField(0)
  DateTime updateAt;

  factory DatabaseConfigsHiveDTO.create(
      {required DateTime updateAt }) =>
      DatabaseConfigsHiveDTO(updateAt: updateAt);

  DatabaseConfigsHiveDTO({
    required this.updateAt,
  });
}
