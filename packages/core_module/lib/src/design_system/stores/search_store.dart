
import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

enum SearchParameters {
  title(label: 'título', column: 'title'),
  artist(label: 'artista', column: 'group');

  final String label;
  final String column;

  const SearchParameters({
    required this.label,
    required this.column,
  });
}

class SearchStore extends ValueNotifier<GenericState<SearchState>> {
  SearchStore({
    required IUseCases useCases,
  }) :
       _useCases = useCases,
       super(InitialState());
  late ServicesEntity servicesEntity;
  final IUseCases _useCases;
  final TextEditingController searchController = TextEditingController();
  String searchField = '';
  List<LyricEntity> lyricsFetched = [];
  bool isSelected = false;
  int selectedIndex = 0;

  init(){
    searchController.text = '';
  }
  selectOptions(int index) {
    selectedIndex = index;
  }

  void searchLyrics() async {
    value = LoadingState();
    List<LyricEntity> lyrics = await _useCases.get(
      params: {
        'table': 'lyrics',
        'orderBy': 'create_at',
        'likeColumn': SearchParameters.values[selectedIndex].column,
        'likeValue': searchField,
        'ascending': false,
        'selectFields': 'id, title, group, album_cover, create_at, verses',
      },
      converter: LyricAdapter.fromMapList,
    );
    lyricsFetched = lyrics;
  }
}

@immutable
abstract class SearchState {}

class SearchSuccessState extends GenericState<SearchState> {}

class SearchErrorState extends GenericState<SearchState> {}

class NotFoundState extends GenericState<SearchState> {}
