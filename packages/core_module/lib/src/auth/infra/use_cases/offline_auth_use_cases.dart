import '../../../../core_module.dart';
import '../../../core/domain/entities/auth/auth_credentials.dart';

class OfflineAuthUseCases implements IOfflineAuthUseCases {
  final IRepository repository;

  OfflineAuthUseCases({required this.repository});

  @override
  Future<String?> getToken() async {
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
  void saveCredentials(AuthCredentials auth) => repository.add<IsarCredentialsDTO>(
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
  dynamic logoutWithGoogle({Map<String, dynamic>? params}) {
    return repository.delete(params: params);
  }
}
