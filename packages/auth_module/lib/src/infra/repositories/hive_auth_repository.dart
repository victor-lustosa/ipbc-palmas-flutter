
import 'package:auth_module/src/domain/repositories/auth_repository.dart';
import 'package:core_module/core_module.dart';

class HiveAuthRepository implements IAuthRepository {

  Box<HiveAuthDTO> box;

  HiveAuthRepository({required this.box});

  @override
  Future<dynamic> get(String path) async {
    var result = box.get(path);
    return result != null ? HiveAuthAdapter.fromMap(result) : HiveAuthDTO.empty();
  }

}
