import '../datasources/datasource.dart';
import '../../domain/repositories/repository.dart';

class Repository<R> implements IRepository<R> {
  Repository({required this.datasource});

  final IDatasource datasource;

  @override
  Future<R> get(String path) async {
    var result = await datasource.get(path);
    return result;
  }

  @override
  Future<void> add(String path, data) {
    return datasource.add(path, data);
  }

  @override
  Future<void> delete(String path) {
    return datasource.delete(path);
  }

  @override
  Future<void> update(String path, data) {
    return datasource.update(path, data);
  }
}
