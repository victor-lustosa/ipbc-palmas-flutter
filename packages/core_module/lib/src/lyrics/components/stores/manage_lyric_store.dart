import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class ManageLyricStore extends ValueNotifier<GenericState<ManageLyricState>> {
  ManageLyricStore({
    required IUseCases useCases,
    required LyricsListStore lyricsListStore,
  }) : _useCases = useCases,
       _lyricsListStore = lyricsListStore,
       super(InitialState());

  final IUseCases _useCases;
  final LyricsListStore _lyricsListStore;
  late void Function() buttonCallback;
  late ValueNotifier<LyricEntity> lyric = ValueNotifier(LyricEntity.empty());
  bool isEditing = false;
  late String serviceId;
  ValueNotifier<bool> isSavePressed = ValueNotifier(false);
  final Map<String, TextEditingController> _controllers = {};
  final TextEditingController titleController = TextEditingController();
  final TextEditingController groupController = TextEditingController();
  final Map<String, FocusNode> _focusNodes = {};
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode groupFocusNode = FocusNode();

  bool isAnyTextFieldFocused = false;

  late FocusScopeNode _rootFocusNode;

  get controllers => _controllers;

  get focusNodes => _focusNodes;

  get rootFocusNode => _rootFocusNode;

  clear() {
    if(!isEditing){
      controllers.forEach((key, controller) => controller.dispose());
      focusNodes.forEach((key, focusNode) => focusNode.dispose());
      rootFocusNode.removeListener(_handleRootFocusChange);
      rootFocusNode.dispose();
    }
  }

  init() {
    initializeControllersAndFocusNodes();
    titleController.text = lyric.value.title;
    groupController.text = lyric.value.group;
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
    for (int i = 0; i < lyric.value.verses.length; i++) {
      final verse = lyric.value.verses[i];
      for (int j = 0; j < verse.versesList.length; j++) {
        final key = '${verse.id}_$j';
        _controllers[key] = TextEditingController(text: verse.versesList[j]);
        _focusNodes[key] = FocusNode();
      }
    }
  }

  void toggleChorusStatus(int verseIndex) {
    final verse = lyric.value.verses[verseIndex];

    final updatedVerse = verse.copyWith(isChorus: !verse.isChorus);

    final updatedVerses = List<VerseEntity>.from(lyric.value.verses);
    updatedVerses[verseIndex] = updatedVerse;

    lyric.value = lyric.value.copyWith(verses: updatedVerses);
    value = UpdateTilesState();
  }

  void updateControllersAndFocusNodes() {
    final Set<String> currentKeys = {};
    for (int i = 0; i < lyric.value.verses.length; i++) {
      final verse = lyric.value.verses[i];
      for (int j = 0; j < verse.versesList.length; j++) {
        final key = '${verse.id}_$j';
        currentKeys.add(key);

        if (!_controllers.containsKey(key)) {
          _controllers[key] = TextEditingController(text: verse.versesList[j]);
        } else {
          if (_controllers[key]?.text != verse.versesList[j]) {
            final TextSelection previousSelection =
                _controllers[key]!.selection;
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
      lyric.value = lyric.value.copyWith(title: newValue);
    } else if (focusNode == groupFocusNode) {
      lyric.value = lyric.value.copyWith(group: newValue);
    }
  }

  void newOrder({required int oldIndex, required int newIndex}) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final VerseEntity item = lyric.value.verses.removeAt(oldIndex);
    lyric.value.verses.insert(newIndex, item);
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

  void saveLyric(BuildContext context) async {
    isSavePressed.value = true;
    try {
      final lyricsResponse = await _useCases.upsert(
        params: {'table': 'lyrics', 'selectFields': 'id'},
        data: LyricAdapter.toMap(lyric.value),
      );
      await _useCases.upsert(
        params: {'table': 'service_lyrics'},
        data: {
          'service_id': int.parse(serviceId),
          'lyric_id': lyricsResponse[0]['id'],
        },
      );
      lyric.value = lyric.value.copyWith(
        id: lyricsResponse[0]['id'].toString(),
      );
      if (context.mounted) {
        await showCustomMessageDialog(
          type: DialogType.success,
          context: context,
          title: 'Sucesso!',
          message: 'Musica salva com sucesso.',
        );
      }
      Future.delayed(Duration(milliseconds: 500), () {
        _lyricsListStore.entitiesList.add(lyric.value);
        isSavePressed.value = false;
        value = UpdateTilesState();
      });
      buttonCallback();
    } catch (e) {
      if (context.mounted) {
        await showCustomMessageDialog(
          type: DialogType.error,
          context: context,
          title: 'Erro ao salvar!',
          message: 'Ocorreu um erro ao salvar a música. Verifique a internet e tente novamente.',
        );
      }
    isSavePressed.value = false;
    value = UpdateTilesState();
    }
  }

  deleteLyric({required BuildContext context, required String lyricId}) async {
    await _useCases.delete(
      params: {
        'table': 'service_lyrics',
        'whereClause': 'lyric_id',
        'id': int.parse(lyricId),
      },
    );

    await _useCases.delete(
      params: {
        'table': 'lyrics',
        'whereClause': 'id',
        'id': int.parse(lyricId),
      },
    );
    if (context.mounted) {
      await showCustomMessageDialog(
        type: DialogType.success,
        context: context,
        title: 'Sucesso!',
        message: 'Música deletada com sucesso.',
      );
    }
    _lyricsListStore.entitiesList.remove(
      _lyricsListStore.entitiesList.firstWhere((e) => e.id == lyricId),
    );
    value = UpdateTilesState();
  }
}

@immutable
abstract class ManageLyricState {}

class UpdateTilesState extends GenericState<ManageLyricState> {}
