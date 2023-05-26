import 'package:hive/hive.dart';

part 'hive_liturgy_dto.g.dart';

@HiveType(typeId: 4)
class HiveLiturgyDTO {
  @HiveField(0)
  bool isAdditional;

  @HiveField(1)
  String sequence;

  @HiveField(2)
  String additional;

  HiveLiturgyDTO({
    required this.isAdditional,
    required this.sequence,
    required this.additional,
  });
}
