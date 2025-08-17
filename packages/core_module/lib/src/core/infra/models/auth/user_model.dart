import 'package:core_module/core_module.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.appMetadata,
    required super.userMetadata,
    required super.aud,
    required super.createdAt,
    required super.lastSignInAt,
    required super.identities,
    required super.factors,
    required super.isAnonymous, required super.picture,
  });

  factory UserModel.empty() => UserModel(
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

  UserModel copyWith({
     String? id,
     Map<String, dynamic>? appMetadata,
     Map<String, dynamic>? userMetadata,
     String? aud,
     String? picture,
     String? createdAt,
     String? lastSignInAt,
     List<dynamic>? identities,
     List<dynamic>? factors,
     bool? isAnonymous
  }) {
    return UserModel(
      id: id ?? this.id,
      appMetadata: appMetadata ?? this.appMetadata,
      userMetadata: userMetadata ?? this.userMetadata,
      aud: aud ?? this.aud,
      createdAt: createdAt ?? this.createdAt,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
      identities: identities ?? this.identities,
      factors: factors ?? this.factors,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      picture: picture ?? this.picture,
    );
  }
}
