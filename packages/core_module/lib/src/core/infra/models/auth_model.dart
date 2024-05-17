import '../../domain/entities/auth_entity.dart';

class ServiceModel extends AuthEntity {
  ServiceModel(
      {required super.email,
        required super.password,
      });
  static AuthEntity fromMap(dynamic json) {
    return AuthEntity(
      email: json['email'],
      password: json['password'],
    );
  }

  static Map<String, dynamic> toMap(AuthEntity data) {
    return {
      'email': data.email,
      'password': data.password,
    };
  }
}
