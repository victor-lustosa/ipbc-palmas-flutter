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
  final String? provider;
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
    this.provider,
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

  factory UserEntity.empty() => UserEntity(
    appMetadata: {},
    userMetadata: {},
    aud: '',
    picture: '',
    createdAt: '',
    lastSignInAt: '',
    identities: [],
    factors: [],
    isAnonymous: false,
    id: MockUtil.createId(),
  );

  UserEntity copyWith({
    String? id,
    Map<String, dynamic>? appMetadata,
    Map<String, dynamic>? userMetadata,
    String? aud,
    String? picture,
    String? confirmationSentAt,
    String? recoverySentAt,
    String? emailChangeSentAt,
    String? newEmail,
    String? invitedAt,
    String? actionLink,
    String? email,
    String? phone,
    String? provider,
    String? createdAt,
    String? emailConfirmedAt,
    String? phoneConfirmedAt,
    String? lastSignInAt,
    String? role,
    String? updatedAt,
    List<dynamic>? identities,
    List<dynamic>? factors,
    bool? isAnonymous,
  }) {
    return UserEntity(
      id: id ?? this.id,
      appMetadata: appMetadata ?? this.appMetadata,
      provider: provider ?? this.provider,
      userMetadata: userMetadata ?? this.userMetadata,
      aud: aud ?? this.aud,
      picture: picture ?? this.picture,
      confirmationSentAt: confirmationSentAt ?? this.confirmationSentAt,
      recoverySentAt: recoverySentAt ?? this.recoverySentAt,
      emailChangeSentAt: emailChangeSentAt ?? this.emailChangeSentAt,
      newEmail: newEmail ?? this.newEmail,
      invitedAt: invitedAt ?? this.invitedAt,
      actionLink: actionLink ?? this.actionLink,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      emailConfirmedAt: emailConfirmedAt ?? this.emailConfirmedAt,
      phoneConfirmedAt: phoneConfirmedAt ?? this.phoneConfirmedAt,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
      role: role ?? this.role,
      updatedAt: updatedAt ?? this.updatedAt,
      identities: identities ?? this.identities,
      factors: factors ?? this.factors,
      isAnonymous: isAnonymous ?? this.isAnonymous,
    );
  }

  factory UserEntity.create(User? user) => UserEntity(
    provider: user?.appMetadata['provider'],
    id: user?.id ?? "",
    picture: user?.userMetadata?['picture'] ?? '',
    appMetadata: user?.appMetadata ?? {},
    userMetadata: user?.userMetadata,
    aud: user?.aud ?? "",
    email: user?.email,
    phone: user?.phone,
    createdAt: user?.createdAt ?? "",
    lastSignInAt: user?.lastSignInAt,
    role: user?.role,
    updatedAt: user?.updatedAt,
    identities: user?.identities,
    factors: user?.factors,
    isAnonymous: user?.isAnonymous ?? true,
  );

  factory UserEntity.fromHive(HiveUserDTO dto) => UserEntity(
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
    provider: dto.provider,
    updatedAt: dto.updatedAt,
    identities: [],
    factors: [],
    isAnonymous: dto.isAnonymous,
    confirmationSentAt: dto.confirmationSentAt,
    recoverySentAt: dto.recoverySentAt,
    emailChangeSentAt: dto.emailChangeSentAt,
    newEmail: dto.newEmail,
    invitedAt: dto.invitedAt,
    actionLink: dto.actionLink,
    emailConfirmedAt: dto.emailConfirmedAt,
    phoneConfirmedAt: dto.phoneConfirmedAt,
  );

}
