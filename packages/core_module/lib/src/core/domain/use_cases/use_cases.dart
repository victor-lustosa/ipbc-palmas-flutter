abstract class IUseCases
    implements IGetUseCases, IAddUseCases, IUpdateUseCases, IDeleteUseCases {}

abstract class IGetUseCases {
  Future<dynamic> get({String? path, String? id, required Function converter});
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
