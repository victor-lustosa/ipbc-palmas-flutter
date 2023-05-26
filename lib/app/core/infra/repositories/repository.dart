import '../datasources/datasource.dart';
import '../../../core/domain/repositories/repository.dart';

class Repository<R> implements IRepository<R> {
  Repository({required this.datasource});

  final IDatasource datasource;

  @override
  Future<R> get(path) async {
    var result = await datasource.get(path);
    return result;
  }

  @override
  Future<void> add(path, data) {
    return datasource.add(path, data);
  }

  @override
  Future<void> delete(path) {
    return datasource.delete(path);
  }

  @override
  Future<void> update(path, data) {
    return datasource.update(path, data);
  }
}
