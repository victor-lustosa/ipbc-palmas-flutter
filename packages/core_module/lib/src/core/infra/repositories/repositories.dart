abstract class IRepository<R>
    implements
        IGet,
        IAdd,
        IDelete,
        IUpdate {}

abstract class IGet<R> {
  Future<R?> get({String? path, String? id});
}

abstract class IAdd {
  Future<void> add({required data, String? path, String? id});
}

abstract class IUpdate {
  Future<void> update({required data, String? path, String? id});
}

abstract class IDelete {
  Future<void> delete({String? path, String? id});
}

