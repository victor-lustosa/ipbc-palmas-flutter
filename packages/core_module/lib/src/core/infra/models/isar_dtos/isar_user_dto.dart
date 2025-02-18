import 'package:core_module/core_module.dart';
part 'isar_user_dto.g.dart';

@collection
class IsarUserDTO {
  Id? id;
  String aud;
  String picture;
  String fullName;
  String? confirmationSentAt;
  String? recoverySentAt;
  String? emailChangeSentAt;
  String? newEmail;
  String? invitedAt;
  String? actionLink;
  String? email;
  String? phone;
  String createdAt;
  String? emailConfirmedAt;
  String? phoneConfirmedAt;
  String? lastSignInAt;
  String? role;
  String? updatedAt;
  // List<dynamic> identities;
  // List<dynamic> factors;
  bool isAnonymous;

  IsarUserDTO({
    required this.id,
    required this.aud,
    required this.fullName,
    required this.picture,
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
    this.role,
    this.updatedAt,
    // required this.identities,
    // required this.factors,
    required this.isAnonymous,
  });

  factory IsarUserDTO.create(UserEntity user) => IsarUserDTO(
    picture: user.userMetadata?['picture'] ?? '',
    fullName: user.userMetadata?['full_name'] ?? '',
    id: Isar.autoIncrement,
    aud: user.aud,
    email: user.email,
    phone: user.phone,
    createdAt: user.createdAt,
    lastSignInAt: user.lastSignInAt,
    role: user.role,
    updatedAt: user.updatedAt,
    // identities: user.identities,
    // factors: user.factors,
    isAnonymous: user.isAnonymous,
  );
}
