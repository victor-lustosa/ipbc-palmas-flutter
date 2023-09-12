import 'package:core_module/core_module.dart';

part 'hive_auth_dto.g.dart';

@HiveType(typeId: 6)
class HiveAuthDTO {
  @HiveField(0)
  String email;

  @HiveField(1)
  String password;

  HiveAuthDTO({
    required this.email,
    required this.password,
  });

  factory HiveAuthDTO.empty() => HiveAuthDTO(
        email: '',
        password: '',
      );
}
