
import 'package:auth_module/src/domain/repositories/auth_repository.dart';

import '../datasources/auth_datasource.dart';

class AuthRepository<R> implements IAuthRepository<R> {
  AuthRepository({required this.datasource});

  final IAuthDatasource<R> datasource;

  @override
  Future signInWithEmail(String path) async {
    var result = await datasource.signInWithEmail(path,'');
   // return result;
    throw UnimplementedError();
  }

}
