import 'package:core_module/core_module.dart';

part 'hive_user_dto.g.dart';

@HiveType(typeId: 2)
class HiveUserDTO {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String aud;

  @HiveField(2)
  final String picture;

  @HiveField(3)
  final String fullName;

  @HiveField(4)
  final String? confirmationSentAt;

  @HiveField(5)
  final String? recoverySentAt;

  @HiveField(6)
  final String? emailChangeSentAt;

  @HiveField(7)
  final String? newEmail;

  @HiveField(8)
  final String? invitedAt;

  @HiveField(9)
  final String? actionLink;

  @HiveField(10)
  final String? email;

  @HiveField(11)
  final String? phone;

  @HiveField(12)
  final String createdAt;

  @HiveField(13)
  final String? emailConfirmedAt;

  @HiveField(14)
  final String? phoneConfirmedAt;

  @HiveField(15)
  final String? lastSignInAt;

  @HiveField(16)
  final String? role;

  @HiveField(17)
  final String? provider;

  @HiveField(18)
  final String? updatedAt;

  @HiveField(19)
  final bool isAnonymous;

  HiveUserDTO({
    required this.id,
    required this.aud,
    required this.picture,
    required this.fullName,
    this.confirmationSentAt,
    this.recoverySentAt,
    this.emailChangeSentAt,
    this.newEmail,
    this.invitedAt,
    this.actionLink,
    this.email,
    this.phone,
    required this.createdAt,
    this.emailConfirmedAt,
    this.phoneConfirmedAt,
    this.lastSignInAt,
    this.role,
    this.provider,
    this.updatedAt,
    required this.isAnonymous,
  });

  factory HiveUserDTO.create(UserEntity user) => HiveUserDTO(
    id: user.id,
    picture: user.userMetadata?['picture'] ?? '',
    fullName: user.userMetadata?['full_name'] ?? '',
    aud: user.aud,
    email: user.email,
    phone: user.phone,
    createdAt: user.createdAt,
    lastSignInAt: user.lastSignInAt,
    role: user.role,
    updatedAt: user.updatedAt,
    isAnonymous: user.isAnonymous,
    provider: user.identities?.isNotEmpty == true
        ? user.identities!.first.provider
        : '',
  );

  factory HiveUserDTO.empty() => HiveUserDTO(
    id: '',
    aud: '',
    picture: '',
    fullName: '',
    createdAt: '',
    isAnonymous: true,
  );
}