import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

enum SearchParameters {
  title(label: 'título', column: 'title'),
  artist(label: 'artista', column: 'group'),
  hino(label: 'hino', column: 'group');

  final String label;
  final String column;

  const SearchParameters({required this.label, required this.column});
}

class SearchStore extends ValueNotifier<GenericState<SearchState>> {
  SearchStore({
    required ManageLyricStore manageLyricStore,
    required GenericEventBus<GenericState<LyricsListState>> eventBus,
  }) : _eventBus = eventBus,
       _manageLyricStore = manageLyricStore,
       super(InitialState());
  int? _currentStoreId;

  late ServicesEntity servicesEntity;
  final GenericEventBus<GenericState<LyricsListState>> _eventBus;
  final ManageLyricStore _manageLyricStore;
  final TextEditingController searchController = TextEditingController();
  bool isSelected = false;
  int selectedIndex = 0;
  int limit = 0;

  void init(int storeId, bool startsEmpty, BuildContext context) {
    searchController.text = '';
    _currentStoreId = storeId;
    if (!startsEmpty) searchLyrics('', context);
  }

  void selectOptions(int index) {
    selectedIndex = index;
  }

  void searchLyrics(String searchField, BuildContext context) async {
    _eventBus.emit(LoadingState<LyricsListState>(id: _currentStoreId));
    List<LyricEntity> lyrics = await _manageLyricStore.getOnlineLyrics(
      context: context,
      params: {
        'table': 'lyrics',
        'orderBy': 'create_at',
        'likeColumn': SearchParameters.values[selectedIndex].column,
        'likeValue':
            (SearchParameters.values[selectedIndex].column ==
                    SearchParameters.hino.column) &&
                searchField.isEmpty
            ? '%hino%'
            : searchField,
        'ascending': false,
        'selectFields': 'id, title, group, album_cover, create_at, verses',
        if (limit > 0) 'limit': limit,
      },
    );
    if (lyrics.isNotEmpty) {
      _eventBus.emit(
        DataFetchedState<LyricsListState>(
          entities: lyrics,
          id: _currentStoreId,
        ),
      );
    } else {
      _eventBus.emit(NotFoundState<LyricsListState>(id: _currentStoreId));
    }
  }
}

@immutable
abstract class SearchState {}
