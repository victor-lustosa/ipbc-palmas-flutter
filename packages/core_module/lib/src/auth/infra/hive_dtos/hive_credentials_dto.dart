import 'package:hive/hive.dart';

import '../../../../core_module.dart';

part 'hive_credentials_dto.g.dart';

@HiveType(typeId: 1)
class HiveCredentialsDTO {

  @HiveField(0)
  final String? token;

  @HiveField(1)
  final String? role;

  @HiveField(2)
  final String? provider;

  HiveCredentialsDTO({
    required this.token,
    required this.role,
    required this.provider,
  });

  factory HiveCredentialsDTO.create(AuthCredentials result) {
    return HiveCredentialsDTO(
      token: result.token,
      provider: result.provider,
      role: result.role,
    );
  }

  factory HiveCredentialsDTO.empty() => HiveCredentialsDTO(
    token: '',
    role: '',
    provider: '',
  );
}