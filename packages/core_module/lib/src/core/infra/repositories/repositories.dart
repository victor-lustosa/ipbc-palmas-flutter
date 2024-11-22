abstract class IRepository
    implements
        IGet,
        IAdd,
        IDelete,
        IUpdate {}

abstract class IGet {
  Future<dynamic> get<T>({String? path, String? id});
}

abstract class IAdd {
  Future<void> add<T>({required data, String? path, String? id});
}

abstract class IUpdate {
  Future<void> update<T>({required data, String? path, String? id});
}

abstract class IDelete {
  Future<void> delete<T>({String? path, String? id});
}

