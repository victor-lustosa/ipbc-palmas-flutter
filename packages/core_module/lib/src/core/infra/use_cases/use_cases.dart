import 'package:core_module/core_module.dart';

class UseCases<T, R> implements IUseCases<R> {
  final IRepository repository;

  UseCases({required this.repository});

  @override
  Future<R?> get({ String? path, String? id, Function? fromMapList}) async {
    var result = await repository.get(path: path, id: id);
    if (fromMapList == null) return null;
    return fromMapList(result) as R;
  }

  @override
  Future<void> add({required data, String? path, String? id}) async => repository.add(data: data,path: path,id: id);

  @override
  Future<void> update({required data, String? path, String? id}) async => repository.update(data: data, path: path, id: id);

  @override
  Future<void> delete({String? path, String? id}) async => repository.delete(path: path, id: id);
}
