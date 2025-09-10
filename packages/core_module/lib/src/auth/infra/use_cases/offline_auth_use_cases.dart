import '../../../../core_module.dart';

class OfflineAuthUseCases implements IOfflineAuthUseCases {
  final IRepository repository;

  OfflineAuthUseCases({required this.repository});

  @override
  Future<String?> getCredentials() async {
    IsarCredentialsDTO? entity = await repository.get<IsarCredentialsDTO>();
    if (entity != null) {
      return entity.token;
    } else {
      return null;
    }
  }

  @override
  Future<UserEntity?> getLocalUser() async {
    final user = await repository.get<IsarUserDTO>();
    if (user != null) {
      return UserEntity.createFromIsar(user);
    } else {
      return null;
    }
  }

  @override
  dynamic saveCredentials(AuthCredentials auth) => repository.add<IsarCredentialsDTO>(
    data: IsarCredentialsDTO(
      token: auth.token,
      provider: auth.provider,
      role: auth.role,
    ),
  );

  @override
  void saveLocalUser(UserEntity user) =>
      repository.add<IsarUserDTO>(data: IsarUserDTO.create(user));

  @override
  dynamic logoutWithGoogle({Map<String, dynamic>? params}) async {
    await repository.delete<IsarUserDTO>(params: params);
    return await repository.delete<IsarCredentialsDTO>();
  }
}
