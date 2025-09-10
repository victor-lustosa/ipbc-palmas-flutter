import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:core_module/core_module.dart';

class ServicesPreviewStore
    extends ValueNotifier<GenericState<ServicesPreviewState>> {
  ServicesPreviewStore({
    required ManageLyricStore manageLyricStore,
    required LyricsListStore lyricsListStore,
  }) : _manageLyricStore = manageLyricStore,
       _lyricsListStore = lyricsListStore,
       super(InitialState());

  final ManageLyricStore _manageLyricStore;
  final LyricsListStore _lyricsListStore;

  late ServiceEntity serviceEntity;
  late ServicesEntity servicesEntity;

  get manageLyricStore => _manageLyricStore;
  get lyricsListStore => _lyricsListStore;

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
      id: MockUtil.createId(),
      title: 'Título Padrão',
      group: 'Grupo Padrão',
      albumCover: AppImages.defaultCoversList[Random().nextInt(4)],
      createAt: DateTime.now().toIso8601String(),
      verses: parsedVerseEntities,
    );
  }
}

@immutable
abstract class ServicesPreviewState {}
