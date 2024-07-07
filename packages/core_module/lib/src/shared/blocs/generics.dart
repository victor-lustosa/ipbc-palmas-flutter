import 'package:flutter/cupertino.dart';

@immutable
abstract class GenericEvent<R> {}

@immutable
abstract class GenericState<R> {}

@immutable
class LoadingEvent<R> extends GenericEvent<R> {
  LoadingEvent();
}

@immutable
class CheckConnectivityEvent<R> extends GenericEvent<R> {
  final String path;
  CheckConnectivityEvent({this.path = ''});
}

@immutable
class GetInSupaEvent<R> extends GenericEvent<R> {
  GetInSupaEvent();
}

@immutable
class GetInHiveEvent<R> extends GenericEvent<R> {
  final String path;
  GetInHiveEvent({this.path = ''});
}

@immutable
class UpdateInHiveEvent<R> extends GenericEvent<R> {
  final dynamic entities;
  UpdateInHiveEvent({required this.entities});
}

@immutable
class InitialState<R> extends GenericState<R> {
  InitialState();
}

@immutable
class LoadingState<R> extends GenericState<R> {
  LoadingState();
}

@immutable
class NoConnectionState<R> extends GenericState<R> {
  NoConnectionState();
}

@immutable
class ExceptionState<R> extends GenericState<R> {
  final String message;
  ExceptionState({required this.message});
}

@immutable
class DataFetchedState<R, T> extends GenericState<R> {
  final List<T> entities;
  DataFetchedState({
    this.entities = const [],
  });
}
