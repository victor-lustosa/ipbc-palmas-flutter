import 'package:lyric_module/src/ui/blocs/lyric_bloc.dart';

abstract class Filter<T, R> {
  List<T> filterListing(R event, List<T>? list);
}

class FilterFactory<R, T> extends Filter<T, FilterEvent<R, T>> {
  @override
  List<T> filterListing(FilterEvent<R, T> event, List<T>? list) {
    List<T> listEntity = event.typeFilter.filterListing(event, list);
    return listEntity;
  }
}
