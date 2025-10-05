import 'package:hive/hive.dart';

part 'hive_credentials_dto.g.dart';

@HiveType(typeId: 1)
class HiveCredentialsDTO {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? token;

  @HiveField(2)
  final String? role;

  @HiveField(3)
  final String? provider;

  HiveCredentialsDTO({
    this.id,
    required this.token,
    required this.role,
    required this.provider,
  });

  factory HiveCredentialsDTO.empty() => HiveCredentialsDTO(
    id: '',
    token: '',
    role: '',
    provider: '',
  );
}