abstract class IRepository implements IGet, IGetByPagination, IAdd, IDelete, IUpdate {}

abstract class IGet {
  Future<dynamic> get<T>({String? path});
}

abstract class IGetByPagination {
  Future<dynamic> getByPagination<T>({String? path});
}

abstract class IAdd {
  Future<void> add<T>({required data, String? path});
}

abstract class IUpdate {
  Future<void> update<T>({required data, String? path});
}

abstract class IDelete {
  Future<void> delete<T>({String? path});
}
