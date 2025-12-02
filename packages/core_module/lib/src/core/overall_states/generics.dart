import 'package:flutter/cupertino.dart';

@immutable
abstract class GenericEvent<R> {}

@immutable
abstract class GenericState<R> {
  final int? id;

  const GenericState({this.id});
}

@immutable
class LoadingEvent<R> extends GenericEvent<R> {
  LoadingEvent();
}

@immutable
class AddDataEvent<R> extends GenericState<R> {
  final dynamic entity;

  const AddDataEvent({this.entity, super.id});
}

@immutable
class GetDataEvent<R> extends GenericEvent<R> {
  final String path;
  final BuildContext context;

  GetDataEvent({this.path = '', required this.context});
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
  const InitialState({super.id});
}

@immutable
class LoadingState<R> extends GenericState<R> {
  const LoadingState({super.id});
}

@immutable
class UpdateFormFieldState<R> extends GenericState<R> {
  const UpdateFormFieldState({super.id});
}

@immutable
class NoConnectionState<R> extends GenericState<R> {
  const NoConnectionState({super.id});
}

@immutable
class ExceptionState<R> extends GenericState<R> {
  final String message;

  const ExceptionState({required this.message, super.id});
}

@immutable
class DataFetchedState<R> extends GenericState<R> {
  final List? entities;

  const DataFetchedState({this.entities, super.id});
}

@immutable
class DataAddedState<R> extends GenericState<R> {
  const DataAddedState({super.id});
}

@immutable
class NotFoundState<R> extends GenericState<R> {
  const NotFoundState({super.id});
}

@immutable
class RefreshingState<R> extends GenericState<R> {
  const RefreshingState({super.id});
}
