import 'package:core_module/core_module.dart';

abstract class Filter<T, R> {
  final dynamic emit;
  final void Function(GenericEvent) addEvent;
  Filter({required this.emit, required this.addEvent});

  void searchTypeFilter(R event, List<T>? list);
}

class MyFilter extends Filter<LyricEntity, FilterEvent> {
  MyFilter({required super.emit, required super.addEvent});

  @override
  void searchTypeFilter(FilterEvent event, List? list) {
    if (event.writing) {
      emit;
    } else {
      event;
    }
  }
}
