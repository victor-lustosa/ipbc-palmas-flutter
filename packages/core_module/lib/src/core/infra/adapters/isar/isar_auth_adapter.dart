import '../../../../../core_module.dart';

class IsarAuthAdapter {

  static Map<String, dynamic> toMapUserDTO(IsarUserDTO dto) => {
        'id': dto.id,
        'aud': dto.aud,
        'confirmationSentAt': dto.confirmationSentAt,
        'recoverySentAt': dto.recoverySentAt,
        'emailChangeSentAt': dto.emailChangeSentAt,
        'newEmail': dto.newEmail,
        'invitedAt': dto.invitedAt,
        'actionLink': dto.actionLink,
        'email': dto.email,
        'phone': dto.phone,
        'createdAt': dto.createdAt,
        'emailConfirmedAt': dto.emailConfirmedAt,
        'phoneConfirmedAt': dto.phoneConfirmedAt,
        'lastSignInAt': dto.lastSignInAt,
        'role': dto.role,
        'updatedAt': dto.updatedAt,
        'isAnonymous': dto.isAnonymous,
      };

  static Map<String, dynamic> toMapToken(IsarTokenDTO data) => {'token': data.accessToken};
}
