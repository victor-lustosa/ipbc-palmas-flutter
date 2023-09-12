
import 'package:lyric_module/lyric_module.dart';

import '../../../../service_module.dart';

class ServicesUseCases implements IUseCases<Stream<List<ServicesEntity>>> {
  final IRepository<Stream<List<Map>>> repository;
  ServicesUseCases({required this.repository});

  @override
  Future<Stream<List<ServicesEntity>>> get(String url) async {
    var result = await repository.get(url);
    if (result != null) {
      return result.map(ServicesAdapter.fromMapList);
    }
    return Stream.value([]);
  }

  @override
  Future<void> add(path, data) async {
    repository.add(path, data);
  }

  @override
  Future<void> update(String path, data) async {
    repository.update(path, data);
  }
}
