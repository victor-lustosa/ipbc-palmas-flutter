import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class EditLyricStore extends ValueNotifier<GenericState<EditLyricState>> {
  EditLyricStore() : super(InitialState());

  final List<LyricModel> _lyricsFetched = [];
  late void Function() buttonCallback;
  get lyricsFetched => _lyricsFetched;
  late LyricModel lyric;
  bool isEditing = false;

  addLyric() {
    _lyricsFetched.add(lyric);
    value = UpdateLyricsListState();
  }
}

@immutable
abstract class EditLyricState {}

class UpdateLyricsListState extends GenericState<EditLyricState> {}