import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class LyricsListStore extends ValueNotifier<GenericState<ManageLyricState>> {
  List<LyricEntity> entitiesList = [];
  late GlobalKey itemKey;
  int index = 0;
  late LyricEntity lyricEntity;

  LyricsListStore() : super(InitialState());
}

