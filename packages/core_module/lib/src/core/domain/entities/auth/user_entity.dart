import 'package:core_module/core_module.dart';

class UserEntity {
  final String id;
  final Map<String, dynamic> appMetadata;
  final Map<String, dynamic>? userMetadata;
  final String aud;
  final String picture;
  final String? confirmationSentAt;
  final String? recoverySentAt;
  final String? emailChangeSentAt;
  final String? newEmail;
  final String? invitedAt;
  final String? actionLink;
  final String? email;
  final String? phone;
  final String createdAt;
  final String? emailConfirmedAt;
  final String? phoneConfirmedAt;
  final String? lastSignInAt;
  final String? role;
  final String? updatedAt;
  final List<dynamic>? identities;
  final List<dynamic>? factors;
  final bool isAnonymous;

  UserEntity({
    required this.picture,
    required this.id,
    required this.appMetadata,
    required this.userMetadata,
    required this.aud,
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
    required this.lastSignInAt,
    this.role,
    this.updatedAt,
    required this.identities,
    required this.factors,
    required this.isAnonymous,
  });

  factory UserEntity.create(User user) => UserEntity(
    id: user.id,
    picture: user.userMetadata?['picture'] ?? '',
    appMetadata: user.appMetadata,
    userMetadata: user.userMetadata,
    aud: user.aud,
    email: user.email,
    phone: user.phone,
    createdAt: user.createdAt,
    lastSignInAt: user.lastSignInAt,
    role: user.role,
    updatedAt: user.updatedAt,
    identities: user.identities,
    factors: user.factors,
    isAnonymous: user.isAnonymous,
  );

  factory UserEntity.createFromIsar(IsarUserDTO dto) => UserEntity(
    id: dto.id.toString(),
    picture: dto.picture,
    appMetadata: {},
    userMetadata: {},
    aud: dto.aud,
    email: dto.email,
    phone: dto.phone,
    createdAt: dto.createdAt,
    lastSignInAt: dto.lastSignInAt,
    role: dto.role,
    updatedAt: dto.updatedAt,
    identities: [],
    factors: [],
    isAnonymous: dto.isAnonymous,
  );
}
