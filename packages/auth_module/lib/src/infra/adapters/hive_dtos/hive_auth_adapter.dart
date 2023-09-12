import 'package:auth_module/src/domain/entities/auth_entity.dart';
import 'package:core_module/core_module.dart';

class HiveAuthAdapter {

  static AuthEntity fromMap(dynamic json) {
    return AuthEntity(
      email: json['email'],
      password: json['password'],
    );
  }

  static HiveAuthDTO toDTO(AuthEntity entity) {
    return HiveAuthDTO(
      email: entity.email,
      password: entity.password,
    );
  }

  static Map<String, dynamic> toMap(AuthEntity data) {
    return {
      'email': data.email,
      'password': data.password,
    };
  }
}
