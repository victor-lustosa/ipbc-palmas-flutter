import 'package:core_module/core_module.dart';

part 'hive_auth_dto.g.dart';

@HiveType(typeId: 6)
class HiveAuthDTO {
  @HiveField(0)
  String token;

  HiveAuthDTO({required this.token});

  factory HiveAuthDTO.empty() => HiveAuthDTO(token: '');
}
