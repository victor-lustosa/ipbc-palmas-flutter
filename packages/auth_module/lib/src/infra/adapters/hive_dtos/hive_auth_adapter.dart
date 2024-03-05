import 'package:core_module/core_module.dart';

import '../../../domain/entities/auth_storage.dart';

class HiveAuthAdapter {
  static AuthStorage fromMap(dynamic json) {
    return AuthStorage(token: json['token']);
  }

  static HiveAuthDTO toDTO(AuthStorage entity) {
    return HiveAuthDTO(token: entity.token);
  }

  static Map<String, dynamic> toMap(AuthStorage data) {
    return {'token': data.token};
  }
}
