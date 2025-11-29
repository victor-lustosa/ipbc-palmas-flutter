import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

enum SearchParameters {
  title(label: 'título', column: 'title'),
  artist(label: 'artista', column: 'group');

  final String label;
  final String column;

  const SearchParameters({required this.label, required this.column});
}

class SearchStore extends ValueNotifier<GenericState<SearchState>> {
  SearchStore({
    required IUseCases useCases,
    required GenericEventBus<GenericState<SearchState>> eventBus,
  }) : _useCases = useCases,
       _eventBus = eventBus,
       super(InitialState());
  int? _currentStoreId;
  late ServicesEntity servicesEntity;
  final IUseCases _useCases;
  final GenericEventBus<GenericState<SearchState>> _eventBus;

  final TextEditingController searchController = TextEditingController();
  String searchField = '';
  bool isSelected = false;
  int selectedIndex = 0;

  void init(int storeId) {
    searchController.text = '';
    _currentStoreId = storeId;
  }

  void selectOptions(int index) {
    selectedIndex = index;
  }

  void searchLyrics() async {
    _eventBus.emit(LoadingState<SearchState>(id: _currentStoreId));
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
    if (lyrics.isNotEmpty) {
      _eventBus.emit(DataFetchedState<SearchState>(entities: lyrics, id: _currentStoreId));
    } else {
      _eventBus.emit(NotFoundState<SearchState>(id: _currentStoreId));
    }
  }
}

@immutable
abstract class SearchState {}
