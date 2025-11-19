import 'dart:async';

class GenericEventBus<T> {
  final _controller = StreamController<T>.broadcast();
  Stream<T> get stream => _controller.stream;
  void emit(T event) => _controller.add(event);
  void dispose() => _controller.close();
}