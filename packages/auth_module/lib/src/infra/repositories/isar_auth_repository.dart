
import 'package:core_module/core_module.dart';

import '../../domain/repositories/auth_repositories.dart';

class IsarAuthRepository implements IOfflineAuthRepository{
  IsarAuthRepository();


  @override
  void saveLocalUser(dynamic user) {
    // TODO: implement saveLocalUser
  }

  @override
  void saveAccessToken(String token) {
    // TODO: implement saveAccessToken
  }

  @override
  String? getAccessToken() {
    // TODO: implement getAccessToken
    throw UnimplementedError();
  }

  @override
  UserEntity? getLocalUser() {
    // TODO: implement getLocalUser
    throw UnimplementedError();
  }
}
