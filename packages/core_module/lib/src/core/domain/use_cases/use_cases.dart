abstract class IUseCases<R>
    implements IGetUseCases<R>, IAddUseCases, IUpdateUseCases, IDeleteUseCases {}

abstract class IGetUseCases<R> {
  Future<R?> get({String? path, String? id, Function? fromMapList});
}

abstract class IAddUseCases {
  Future<void> add({required data, String? path});
}

abstract class IUpdateUseCases {
  Future<void> update({required data, String? path, String? id});
}

abstract class IDeleteUseCases {
  Future<void> delete({String? path, String? id});
}