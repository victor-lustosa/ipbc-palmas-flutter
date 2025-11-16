import 'dart:math';

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

class SearchLyricsStore extends ValueNotifier<GenericState<SearchLyricsState>> {
  SearchLyricsStore({
    required ManageLyricStore manageLyricStore,
    required LyricsListStore lyricsListStore,
    required IUseCases useCases,
  }) : _manageLyricStore = manageLyricStore,
       _lyricsListStore = lyricsListStore,
       _useCases = useCases,
       super(InitialState());
  final ManageLyricStore _manageLyricStore;
  final LyricsListStore _lyricsListStore;
  late ServicesEntity servicesEntity;
  final IUseCases _useCases;
  final TextEditingController _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;
  ManageLyricStore get manageLyricStore => _manageLyricStore;
  LyricsListStore get lyricsListStore => _lyricsListStore;

  bool isSelected = false;
  int selectedIndex = 0;

  init(){
    _searchController.text = '';
  }
  selectOptions(int index) {
    selectedIndex = index;
  }

  void searchLyrics(String valueParam) async {
    value = LoadingState();
    List<LyricEntity> lyrics = await _useCases.get(
      params: {
        'table': 'lyrics',
        'orderBy': 'create_at',
        'likeColumn': SearchParameters.values[selectedIndex].column,
        'likeValue': valueParam,
        'ascending': false,
        'selectFields': 'id, title, group, album_cover, create_at, verses',
      },
      converter: LyricAdapter.fromMapList,
    );
    _lyricsListStore.entitiesList = lyrics;
    value = SearchSuccessState();
  }

  convertTextInLyric(String text) {
    final List<String> rawVerseBlocks = text.split(RegExp(r'\n\s*\n+'));

    final List<VerseEntity> parsedVerseEntities = [];

    for (int i = 0; i < rawVerseBlocks.length; i++) {
      final String block = rawVerseBlocks[i].trim();
      if (block.isEmpty) continue;

      final List<String> versesInBlock = block
          .split('\n')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      if (versesInBlock.isNotEmpty) {
        parsedVerseEntities.add(
          VerseEntity(id: i, isChorus: false, versesList: versesInBlock),
        );
      }
    }
    return LyricEntity(
      title: 'Título Padrão',
      group: 'Grupo Padrão',
      albumCover: AppImages.defaultCoversList[Random().nextInt(4)],
      createAt: DateTime.now().toIso8601String(),
      verses: parsedVerseEntities,
    );
  }

  void newLyric(String? text, BuildContext context) {
    if (text != null && text.isNotEmpty) {
      manageLyricStore.lyric.value = convertTextInLyric(text);
      manageLyricStore.isEditing = false;
      manageLyricStore.buttonCallback = () {
        popUntil(
          (route) =>
              route.settings.name ==
              AppRoutes.servicesRoute + AppRoutes.serviceRoute,
        );
      };
      pop(context);
      pushNamed(AppRoutes.servicesRoute + AppRoutes.manageLyricsRoute);
    }
  }
}

@immutable
abstract class SearchLyricsState {}

class SearchSuccessState extends GenericState<SearchLyricsState> {}

class SearchErrorState extends GenericState<SearchLyricsState> {}

class NotFoundState extends GenericState<SearchLyricsState> {}
