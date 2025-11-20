import 'dart:async';
import 'dart:math';

import 'package:core_module/core_module.dart';
import 'package:core_module/src/design_system/stores/search_store.dart';
import 'package:flutter/cupertino.dart';

import '../../core/overall_states/generic_event_bus.dart';

class SearchLyricsStore extends ValueNotifier<GenericState<SearchLyricsState>> {
  SearchLyricsStore({
    required ManageLyricStore manageLyricStore,
    required LyricsListStore lyricsListStore,
    required GenericEventBus<GenericState<SearchState>> eventBus,
  }) : _manageLyricStore = manageLyricStore,
       _lyricsListStore = lyricsListStore,
       _eventBus = eventBus,
       super(InitialState());
  final ManageLyricStore _manageLyricStore;
  final LyricsListStore _lyricsListStore;
  final GenericEventBus<GenericState<SearchState>> _eventBus;
  late final StreamSubscription _subscription;
  late ServicesEntity servicesEntity;
  final TextEditingController searchController = TextEditingController();
  ManageLyricStore get manageLyricStore => _manageLyricStore;
  LyricsListStore get lyricsListStore => _lyricsListStore;
  ValueNotifier<bool> isAddEventPressed = ValueNotifier(false);

  LyricEntity convertTextInLyric(String text) {
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


