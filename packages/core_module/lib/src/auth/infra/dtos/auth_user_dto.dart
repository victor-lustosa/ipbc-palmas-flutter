import 'package:core_module/core_module.dart';

class AuthUserDTO {
  final UserEntity user;
  final AuthCredentials auth;

  AuthUserDTO({required this.user, required this.auth});
}
