import 'package:core_module/core_module.dart';
import 'package:lyric_module/src/ui/blocs/lyric_bloc.dart';

abstract class Filter<T, R> {
  List<T> filterListing(R event, List<T>? list);
}

// music filter

class MusicFilter extends Filter<LyricEntity, FilterEvent> {
  @override
  List<LyricEntity> filterListing(FilterEvent event, List<LyricEntity>? list) {
    List<LyricEntity> filterList;

    filterList = list!
        .where(
          (element) => element.title
              .toLowerCase()
              .contains(event.searchText.toLowerCase()),
        )
        .toList();

    return filterList;
  }
}
//My artist filter

class ArtistFilter extends Filter<LyricEntity, FilterEvent> {
  @override
  List<LyricEntity> filterListing(FilterEvent event, List<LyricEntity>? list) {
    late List<LyricEntity> filterList;

    filterList = list!
        .where(
          (element) => element.group
              .toLowerCase()
              .contains(event.searchText.toLowerCase()),
        )
        .toList();

    return filterList;
  }
}

class FilterFactory extends Filter<LyricEntity, FilterEvent> {
  @override
  List<LyricEntity> filterListing(FilterEvent event, List<LyricEntity>? list) {
    late List<LyricEntity> filterList;

    if (event.selectIndex == 0) {
      filterList = MusicFilter().filterListing(event, list);
    } else if (event.selectIndex == 2) {
      filterList = ArtistFilter().filterListing(event, list);
    }

    return filterList;
  }
}
