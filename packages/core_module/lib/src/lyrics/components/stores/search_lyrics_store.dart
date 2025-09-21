import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class SearchLyricsStore extends ValueNotifier<GenericState<SearchLyricsState>> {
  SearchLyricsStore({required ManageServiceStore manageServiceStore})
    : _manageServiceStore = manageServiceStore,
      super(InitialState());
  final ManageServiceStore _manageServiceStore;
  final TextEditingController _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;
  ManageServiceStore get manageServiceStore => _manageServiceStore;

  bool isSelected = false;
  int selectedIndex = 0;

  int selectOptions(int index) {
    selectedIndex = index;
    return selectedIndex;
  }

  void searchLyrics() {
    searchController.text;
    selectedIndex;
  }
}

@immutable
abstract class SearchLyricsState {}

class SearchingState extends GenericState<SearchLyricsState> {}

class SearchSuccessState extends GenericState<SearchLyricsState> {}

class SearchErrorState extends GenericState<SearchLyricsState> {}

class NotFoundState extends GenericState<SearchLyricsState> {}
