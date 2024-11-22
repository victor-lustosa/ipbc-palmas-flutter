
import 'package:core_module/core_module.dart';

import '../../domain/repositories/auth_repositories.dart';

class IsarAuthRepository implements IOfflineAuthRepository{
  IsarAuthRepository({required this.isar});
  final Isar isar;

  @override
  Future<void> saveLocalUser(UserEntity user) async {
   await isar.writeTxn(() async {
      isar.collection<IsarUserDTO>().put(IsarUserDTO.create(user));
    });
  }

  @override
  Future<void> saveAccessToken(String token) async {
    await isar.writeTxn(() async {
      isar.collection<IsarTokenDTO>().put(IsarTokenDTO(accessToken: token));
    });
  }

  @override
  Future<String?> getAccessToken() async {
   final token = await isar.collection<IsarTokenDTO>().where().findFirst();
   if(token?.accessToken == null) return '';
   return Future.value(token?.accessToken);
  }

  @override
  Future<UserEntity?> getLocalUser() async {
    final user = await isar.collection<IsarUserDTO>().where().findFirst();
    if(user == null) return UserEntity.empty();
    return Future.value(UserEntity.createFromIsar(user));
  }
}
