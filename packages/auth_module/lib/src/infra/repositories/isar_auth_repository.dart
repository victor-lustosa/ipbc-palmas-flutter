
import 'package:auth_module/src/domain/repositories/auth_repositories.dart';
import 'package:core_module/core_module.dart';

class IsarAuthRepository implements IOfflineAuthRepository {

  Box<HiveAuthDTO> box;

  IsarAuthRepository({required this.box});

  @override
  Future<dynamic> get(String path) async {
    var result = box.get(path);
    return result != null ? HiveAuthAdapter.fromMap(result) : HiveAuthDTO.empty();
  }

}
