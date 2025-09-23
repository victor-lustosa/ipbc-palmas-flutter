import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class ManageLyricStore extends ValueNotifier<GenericState<ManageLyricState>> {
  ManageLyricStore() : super(InitialState());

  final List<LyricEntity> _lyricsFetched = [];
  late void Function() buttonCallback;
  late LyricEntity lyric;
  bool isEditing = false;
  final Map<String, TextEditingController> _controllers = {};
  final TextEditingController titleController = TextEditingController();
  final TextEditingController groupController = TextEditingController();
  final Map<String, FocusNode> _focusNodes = {};
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode groupFocusNode = FocusNode();

  bool isAnyTextFieldFocused = false;

  late FocusScopeNode _rootFocusNode;

  List<LyricEntity> get lyricsFetched => _lyricsFetched;

  get controllers => _controllers;

  get focusNodes => _focusNodes;

  get rootFocusNode => _rootFocusNode;

  addLyric() {
    _lyricsFetched.add(lyric);
    value = UpdateLyricsListState();
  }

  clear(){
    controllers.forEach((key, controller) => controller.dispose());
    focusNodes.forEach((key, focusNode) => focusNode.dispose());
    rootFocusNode.removeListener(_handleRootFocusChange);
    rootFocusNode.dispose();
  }

  init() {
    initializeControllersAndFocusNodes();
    titleController.text = lyric.title;
    groupController.text = lyric.group;
    _rootFocusNode = FocusScopeNode();
    rootFocusNode.addListener(_handleRootFocusChange);
  }

  void _handleRootFocusChange() {
    if (isAnyTextFieldFocused != rootFocusNode.hasFocus) {
      isAnyTextFieldFocused = rootFocusNode.hasFocus;
      notifyListeners();
    }
  }

  void initializeControllersAndFocusNodes() {
    for (int i = 0; i < lyric.verses.length; i++) {
      final verse = lyric.verses[i];
      for (int j = 0; j < verse.versesList.length; j++) {
        final key = '${verse.id}_$j';
        _controllers[key] = TextEditingController(text: verse.versesList[j]);
        _focusNodes[key] = FocusNode();
      }
    }
  }

  void updateControllersAndFocusNodes() {
    final Set<String> currentKeys = {};
    for (int i = 0; i < lyric.verses.length; i++) {
      final verse = lyric.verses[i];
      for (int j = 0; j < verse.versesList.length; j++) {
        final key = '${verse.id}_$j';
        currentKeys.add(key);

        if (!_controllers.containsKey(key)) {
          _controllers[key] = TextEditingController(text: verse.versesList[j]);
        } else {
          if (_controllers[key]?.text != verse.versesList[j]) {
            final TextSelection previousSelection = _controllers[key]!.selection;
            _controllers[key]!.text = verse.versesList[j];
            _controllers[key]!.selection = previousSelection.copyWith(
              baseOffset: previousSelection.baseOffset.clamp(
                0,
                _controllers[key]!.text.length,
              ),
              extentOffset: previousSelection.extentOffset.clamp(
                0,
                _controllers[key]!.text.length,
              ),
            );
          }
        }

        if (!_focusNodes.containsKey(key)) {
          _focusNodes[key] = FocusNode();
        }
      }
    }

    _controllers.keys.toList().forEach((key) {
      if (!currentKeys.contains(key)) {
        _controllers.remove(key)?.dispose();
        _focusNodes.remove(key)?.dispose();
      }
    });
  }

  void attributeFocusToFormField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String newValue,
  }) {
    if (focusNode == titleFocusNode) {
      lyric = lyric.copyWith(title: newValue);
    } else if (focusNode == groupFocusNode) {
      lyric = lyric.copyWith(group: newValue);
    }
  }

  void newOrder({required int oldIndex, required int newIndex}) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final VerseEntity item = lyric.verses.removeAt(oldIndex);
    lyric.verses.insert(newIndex, item);
    updateControllersAndFocusNodes();
  }

  void updateTiles({
    required VerseEntity verse,
    required int position,
    required String lineKey,
  }) {
    if (!_controllers.containsKey(lineKey)) {
      _controllers[lineKey] = TextEditingController(
        text: verse.versesList[position],
      );
    }
    if (!_focusNodes.containsKey(lineKey)) {
      _focusNodes[lineKey] = FocusNode();
    }
    if (_controllers[lineKey]!.text != verse.versesList[position]) {
      final TextSelection previousSelection = _controllers[lineKey]!.selection;
      _controllers[lineKey]!.text = verse.versesList[position];
      _controllers[lineKey]!.selection = previousSelection.copyWith(
        baseOffset: previousSelection.baseOffset.clamp(
          0,
          _controllers[lineKey]!.text.length,
        ),
        extentOffset: previousSelection.extentOffset.clamp(
          0,
          _controllers[lineKey]!.text.length,
        ),
      );
    }
  }
}

@immutable
abstract class ManageLyricState {}

class UpdateLyricsListState extends GenericState<ManageLyricState> {}
