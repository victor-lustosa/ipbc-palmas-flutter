import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:core_module/core_module.dart';

class ServicesPreviewStore extends ValueNotifier<GenericState<ServicesPreviewState>> {
  ServicesPreviewStore() : super(InitialState());

  late ServiceEntity serviceEntity;
  late ServicesEntity servicesEntity;

  convertTextInLyric(String text) {
    final List<String> rawVerseBlocks = text.split(RegExp(r'\n\s*\n+'));

    final List<VerseEntity> parsedVerseEntities = [];

    for (int i = 0; i < rawVerseBlocks.length; i++) {
      final String block = rawVerseBlocks[i].trim();
      if (block.isEmpty) continue;

      final List<String> versesInBlock =
          block
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
    return LyricModel(
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
