
import 'package:core_module/core_module.dart';

import '../../domain/use_cases/auth_use_cases.dart';

class OfflineAuthUseCases implements IOfflineAuthUseCases{

  final IRepository repository;

  OfflineAuthUseCases({required this.repository});

  @override
  Future<String?> getAccessToken() async {
   final result = await repository.get<IsarTokenDTO>();
   return result.accessToken;
  }

  @override
  Future<UserEntity?> getLocalUser() async => UserEntity.createFromIsar(await repository.get<IsarUserDTO>());

  @override
  void saveAccessToken(String token) => repository.add(data: IsarTokenDTO(accessToken: token));

  @override
  void saveLocalUser(dynamic user) => repository.add(data: IsarUserDTO.create(user));
}