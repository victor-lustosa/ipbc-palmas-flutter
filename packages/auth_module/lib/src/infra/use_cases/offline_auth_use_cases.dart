import 'package:core_module/core_module.dart';

class OfflineAuthUseCases implements IOfflineAuthUseCases {
  final IRepository repository;

  OfflineAuthUseCases({required this.repository});

  @override
  Future<String?> getToken() async {
    final result = await repository.get<IsarTokenDTO>();
    return result.token;
  }

  @override
  Future<UserEntity> getLocalUser() async {
    final user = await repository.get<IsarUserDTO>();
    if(user != null){
      return UserEntity.createFromIsar(user);
    } else {
      return UserModel.empty();
    }
  }

  @override
  void saveToken(String token) =>
      repository.add<IsarTokenDTO>(data: IsarTokenDTO(token: token));

  @override
  void saveLocalUser(UserEntity user) =>
      repository.add<IsarUserDTO>(data: IsarUserDTO.create(user));
}
