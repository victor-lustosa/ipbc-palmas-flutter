import 'package:core_module/core_module.dart';

import '../../domain/use_cases/auth_use_cases.dart';

class OfflineAuthUseCases implements IOfflineAuthUseCases {
  final IRepository repository;

  OfflineAuthUseCases({required this.repository});

  @override
  Future<String?> getToken() async {
    final result = await repository.get<IsarTokenDTO>();
    return result.token;
  }

  @override
  Future<UserEntity?> getLocalUser() async =>
      UserEntity.createFromIsar(await repository.get<IsarUserDTO>());

  @override
  void saveToken(String token) =>
      repository.add<IsarTokenDTO>(data: IsarTokenDTO(token: token));

  @override
  void saveLocalUser(UserEntity user) =>
      repository.add<IsarUserDTO>(data: IsarUserDTO.create(user));
}
