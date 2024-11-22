import 'package:core_module/core_module.dart';

class UserEntity {

  final String id;
  final Map<String, dynamic> appMetadata;
  final Map<String, dynamic> userMetadata;
  final String aud;
  final String? confirmationSentAt;
  final String? recoverySentAt;
  final String? emailChangeSentAt;
  final String? newEmail;
  final String? invitedAt;
  final String? actionLink;
  final String email;
  final String phone;
  final String createdAt;
  final String? emailConfirmedAt;
  final String? phoneConfirmedAt;
  final String lastSignInAt;
  final String role;
  final String updatedAt;
  final List<dynamic> identities;
  final List<dynamic> factors;
  final bool isAnonymous;

  UserEntity({
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
    required this.email,
    required this.phone,
    required this.createdAt,
    this.emailConfirmedAt,
    this.phoneConfirmedAt,
    required this.lastSignInAt,
    required this.role,
    required this.updatedAt,
    required this.identities,
    required this.factors,
    required this.isAnonymous,
  });

  factory UserEntity.empty() => UserEntity(
      id: '',
      appMetadata: {},
      userMetadata: {},
      aud: '',
      email: '',
      phone: '',
      createdAt: '',
      lastSignInAt: '',
      role: '',
      updatedAt: '',
      identities: [],
      factors: [],
      isAnonymous: false
  );

  factory UserEntity.create(User? user) => UserEntity(
      id: user?.id ?? '',
      appMetadata: user?.appMetadata ?? {},
      userMetadata: user?.userMetadata ?? {},
      aud: user?.aud ?? '',
      email: user?.email ?? '',
      phone: user?.phone ?? '',
      createdAt: user?.createdAt ?? '',
      lastSignInAt: user?.lastSignInAt ?? '',
      role: user?.role ?? '',
      updatedAt: user?.updatedAt ?? '',
      identities: user?.identities ?? [],
      factors: user?.factors ?? [],
      isAnonymous: user?.isAnonymous ?? false
  );

  factory UserEntity.createFromIsar(IsarUserDTO? dto) => UserEntity(
      id: dto?.id.toString() ?? '',
      appMetadata:  {},
      userMetadata: {},
      aud: dto?.aud ?? '',
      email: dto?.email ?? '',
      phone: dto?.phone ?? '',
      createdAt: dto?.createdAt ?? '',
      lastSignInAt: dto?.lastSignInAt ?? '',
      role: dto?.role ?? '',
      updatedAt: dto?.updatedAt ?? '',
      identities:[],
      factors: [],
      isAnonymous: dto?.isAnonymous ?? false
  );
}
