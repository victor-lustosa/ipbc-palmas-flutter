import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';


class EditLyricStore extends ValueNotifier<GenericState<EditLyricState>> {
  EditLyricStore() : super(LoadingState());

  void getLyrics() async {
    List<LyricEntity>? lyricsList = await MockUtil.convertMockJson<List<LyricModel>>('assets/mocks/lyrics_mock.json', 'lyrics');
    if (lyricsList!.isNotEmpty) {
      value = DataFetchedState<EditLyricState, LyricEntity>(entities: lyricsList);
    }
  }
}

@immutable
abstract class EditLyricState{}



