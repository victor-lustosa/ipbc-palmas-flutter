import 'package:core_module/core_module.dart';

class AuthCredentials {
  final String? token;
  final String? provider;
  final String? role;

  AuthCredentials({
    required this.token,
    required this.provider,
    required this.role,
  });

  factory AuthCredentials.fromHive(HiveCredentialsDTO dto) =>
      AuthCredentials(token: dto.token, provider: dto.provider, role: dto.role);

}
