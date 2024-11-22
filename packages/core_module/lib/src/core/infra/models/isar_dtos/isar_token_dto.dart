import 'package:core_module/core_module.dart';
part 'isar_token_dto.g.dart';
@collection
class IsarTokenDTO {

  Id id = Isar.autoIncrement;
  String? accessToken;

  IsarTokenDTO({
    required this.accessToken,
  });

}
