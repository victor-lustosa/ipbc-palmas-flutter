
abstract class IAuthRepository implements IGetRepository{}

abstract class IGetRepository {
  Future<dynamic> get(String path);
}
