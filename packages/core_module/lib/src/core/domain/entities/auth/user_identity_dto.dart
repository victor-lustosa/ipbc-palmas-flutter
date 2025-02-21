// class UserIdentityDto{
//   final String id;
//   final String userId;
//   final Map<String, dynamic>? identityData;
//   final String identityId;
//   final String provider;
//   final String? createdAt;
//   final String? lastSignInAt;
//   final String? updatedAt;
//
//   const UserIdentityDto({
//     required this.id,
//     required this.userId,
//     required this.identityData,
//     required this.identityId,
//     required this.provider,
//     required this.createdAt,
//     required this.lastSignInAt,
//     this.updatedAt,
//   });
//
//   factory UserIdentityDto.fromMap(User) {
//     return UserIdentityDto(
//       id: map['id'] as String,
//       userId: map['user_id'] as String,
//       identityData: (map['identity_data'] as Map?)?.cast<String, dynamic>(),
//       identityId: (map['identity_id'] ?? '') as String,
//       provider: map['provider'] as String,
//       createdAt: map['created_at'] as String?,
//       lastSignInAt: map['last_sign_in_at'] as String?,
//       updatedAt: map['updated_at'] as String?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'identity_data': identityData,
//       'identity_id': identityId,
//       'provider': provider,
//       'created_at': createdAt,
//       'last_sign_in_at': lastSignInAt,
//       'updated_at': updatedAt,
//     };
//   }
// }
