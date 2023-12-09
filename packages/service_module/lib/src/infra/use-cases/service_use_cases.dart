
import 'package:lyric_module/lyric_module.dart';

class ServiceUseCases implements IUseCases<Stream<List<ServiceEntity>>>{
  final IRepository<List<dynamic>> repository;
  ServiceUseCases({required this.repository});

  @override
  Future<Stream<List<ServiceEntity>>?> get(String url) async {
    var result = await repository.get(url);
    return Stream.value(SupaServiceAdapter.fromMapList(result));
  }

  @override
  Future<void> add(path, data) async {
    repository.add(path, data);
  }

  @override
  Future<void> update(path, data) async {
    repository.update(path, data);
  }
}
