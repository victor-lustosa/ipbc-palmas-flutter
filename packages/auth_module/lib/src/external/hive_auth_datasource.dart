
import 'package:core_module/core_module.dart';


import '../infra/datasources/auth_datasource.dart';


class HiveAuthDatasource implements IDatasource,IAuthDatasource {

  Box<HiveAuthDTO> box;

  HiveAuthDatasource({required this.box});

  @override
  Future<dynamic> get(String path) async {
    var result = box.get(path);
    return result != null ? HiveAuthAdapter.fromMap(result) : HiveAuthDTO.empty();
  }

  @override
  Future<void> add(String path, data) async {}

  @override
  Future<void> update(String path, data) async {
    box.put(path, HiveAuthAdapter.toDTO(data));
  }

  @override
  Future<void> delete(String path) async {
    box.delete(path);
  }

  @override
  Future<String> signInWithEmail(String email, String password) {
    throw UnimplementedError();
  }

}
