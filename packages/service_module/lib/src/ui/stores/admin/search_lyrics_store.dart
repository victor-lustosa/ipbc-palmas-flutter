import 'package:flutter/cupertino.dart';
import 'package:core_module/core_module.dart';

class SearchLyricsStore extends ValueNotifier<GenericState<SearchLyricsState>> {
  SearchLyricsStore() : super(InitialState());

  String createId() => DateTime.now().microsecondsSinceEpoch.toString();

  convertTextInLyric(String text) async {
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
    pushNamed(
      AppRoutes.servicesRoute + AppRoutes.editLyricRoute,
      arguments: LyricEntity(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: 'Título Padrão',
        group: 'Grupo Padrão',
        albumCover: '',
        createAt: DateTime.now().toIso8601String(),
        verses: parsedVerseEntities,
      ),
    );
  }
}

@immutable
abstract class SearchLyricsState {}

class SearchingState extends GenericState<SearchLyricsState> {}

class SearchSuccessState extends GenericState<SearchLyricsState> {}

class SearchErrorState extends GenericState<SearchLyricsState> {}

class NotFoundState extends GenericState<SearchLyricsState> {}
