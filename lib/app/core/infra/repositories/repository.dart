import 'package:ipbc_palmas/app/core/domain/repositories/repository.dart';

import '../datasources/datasource.dart';
abstract class IRepository<T> implements IGetRepository<T>{

}
class Repository <T> implements IRepository<T>{

  Repository({required this.getDatasource});

  final IGetDatasource getDatasource;

  @override
  Stream<List<Map<dynamic, dynamic>>> get(String url) {
    final stream = getDatasource.get(url);
    return stream;
  }
}