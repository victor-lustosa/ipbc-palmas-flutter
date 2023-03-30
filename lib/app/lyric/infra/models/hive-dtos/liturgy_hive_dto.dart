import 'package:hive/hive.dart';
part 'liturgy_hive_dto.g.dart';

@HiveType(typeId: 4)
class LiturgyHiveDTO {
  @HiveField(0)
  bool isAdditional;

  @HiveField(1)
  String sequence;

  @HiveField(2)
  String additional;

  LiturgyHiveDTO({
    required this.isAdditional,
    required this.sequence,
    required this.additional,
  });
}
