import '../../../core/domain/repositories/repository.dart';

import '../datasources/datasource.dart';

class Repository<R> implements IRepository<R> {
  Repository({required this.datasource});

  final IDatasource datasource;

  @override
  R get(path) {
    return datasource.get(path) as R;
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
