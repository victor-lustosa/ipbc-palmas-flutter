import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

enum SearchParameters {
  title(label: 'título', column: 'title'),
  artist(label: 'artista', column: 'artist'),
  hymns(label: 'hino', column: 'is_hymn');

  final String label;
  final String column;

  const SearchParameters({required this.label, required this.column});
}

class SearchStore extends ValueNotifier<GenericState<SearchState>> {
  SearchStore({
    required ManageLyricStore manageLyricStore,
    required LyricsListStore lyricsListStore,
    required GenericEventBus<GenericState<LyricsListState>> eventBus,
  }) : _eventBus = eventBus,
       _lyricsListStore = lyricsListStore,
       _manageLyricStore = manageLyricStore,
       super(InitialState());
  int? _currentStoreId;

  final LyricsListStore _lyricsListStore;
  late ServicesEntity servicesEntity;
  final GenericEventBus<GenericState<LyricsListState>> _eventBus;
  final ManageLyricStore _manageLyricStore;
  final TextEditingController searchController = TextEditingController();

  LyricsListStore get lyricsListStore => _lyricsListStore;

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

  Future<void> searchLyrics(String searchField, BuildContext context) async {

    _eventBus.emit(LoadingState<LyricsListState>(id: _currentStoreId));

    bool isHymn = (SearchParameters.values[selectedIndex].column == SearchParameters.hymns.column);

    _lyricsListStore.isHymn = isHymn ? true : false;

    _lyricsListStore.isNotSearch = searchField.isEmpty ? true : false;

    List<LyricEntity>? lyrics = await _manageLyricStore.getOnlineLyrics(
      context: context,
      params: {
        'table': 'lyrics',
        'orderBy': isHymn ? 'hymn_number' : 'create_at',
        'likeColumn': isHymn
            ? SearchParameters.title.column
            : SearchParameters.values[selectedIndex].column,
        'likeValue': searchField,
        'ascending': isHymn ? true : false,
        if (isHymn) 'filterColumn': 'is_hymn',
        if (isHymn) 'filterValue': true,
        'selectFields':
            'id, title, artist, album_cover, create_at, verses, is_hymn, hymn_number',
        if (limit > 0) 'limit': limit,
      },
    );
    if (lyrics != null && lyrics.isNotEmpty) {
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
