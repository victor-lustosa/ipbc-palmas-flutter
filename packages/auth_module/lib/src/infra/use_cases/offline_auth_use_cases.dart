import 'package:core_module/core_module.dart';

class OfflineAuthUseCases implements IOfflineAuthUseCases {
  final IRepository repository;

  OfflineAuthUseCases({required this.repository});

  @override
  Future<String?> getToken() async {
    IsarTokenDTO? entity = await repository.get<IsarTokenDTO>();
    if(entity != null){
      return entity.token;
    } else {
      return null;
    }
  }

  @override
  Future<UserEntity?> getLocalUser() async {
    final user = await repository.get<IsarUserDTO>();
    if(user != null){
      return UserEntity.createFromIsar(user);
    } else {
      return null;
    }
  }

  @override
  void saveToken(String token) =>
      repository.add<IsarTokenDTO>(data: IsarTokenDTO(token: token));

  @override
  void saveLocalUser(UserEntity user) =>
      repository.add<IsarUserDTO>(data: IsarUserDTO.create(user));
}
