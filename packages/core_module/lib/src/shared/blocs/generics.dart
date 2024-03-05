abstract class GenericEvent<R> {}
abstract class GenericState<R> {}

class LoadingEvent<R> extends GenericEvent<R> {
  LoadingEvent();
}

class CheckConnectivityEvent<R> extends GenericEvent<R>  {
  final String path;
  CheckConnectivityEvent({this.path = ''});
}

class GetInSupaEvent<R> extends GenericEvent<R> {
  GetInSupaEvent();
}

class GetInHiveEvent<R> extends GenericEvent<R> {
  final String path;
  GetInHiveEvent({this.path = ''});
}

class UpdateInHiveEvent<R> extends GenericEvent<R> {
  final dynamic entities;
  UpdateInHiveEvent({required this.entities});
}

class LoadingState<R> extends GenericState<R> {
  LoadingState();
}

class NoConnectionState<R> extends GenericState<R> {
  NoConnectionState();
}

class ExceptionState<R> extends GenericState<R> {
  final String message;
  ExceptionState({required this.message});
}

class DataFetchedState<R, T> extends GenericState<R> {
  final List<T> entities;
  DataFetchedState({required this.entities});
}