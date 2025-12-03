import 'dart:math';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class ManageLyricStore extends ValueNotifier<GenericState<ManageLyricState>>
    with ConnectivityMixin {
  ManageLyricStore({
    required IUseCases onlineUseCases,
    required LyricsListStore lyricsListStore,
    // IUseCases? offlineUseCases,
  }) : _onlineUseCases = onlineUseCases,
       // _offlineUseCases = offlineUseCases,
       _lyricsListStore = lyricsListStore,
       super(InitialState());
  final IUseCases _onlineUseCases;

  //final IUseCases? _offlineUseCases;
  final LyricsListStore _lyricsListStore;
  late void Function() buttonCallback;
  late ValueNotifier<LyricEntity> lyric = ValueNotifier(LyricEntity.empty());
  bool isEditing = false;
  late String serviceId;
  bool hasAttached = true;
  ValueNotifier<bool> isSavePressed = ValueNotifier(false);
  final Map<String, TextEditingController> _controllers = {};
  final TextEditingController titleController = TextEditingController();
  final TextEditingController groupController = TextEditingController();
  final Map<String, FocusNode> _focusNodes = {};
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode groupFocusNode = FocusNode();

  bool isAnyTextFieldFocused = false;

  late FocusScopeNode _rootFocusNode;

  Map<String, TextEditingController> get controllers => _controllers;

  Map<String, FocusNode> get focusNodes => _focusNodes;

  FocusScopeNode get rootFocusNode => _rootFocusNode;

  void clear() {
    if (!isEditing) {
      controllers.forEach((key, controller) => controller.dispose());
      focusNodes.forEach((key, focusNode) => focusNode.dispose());
      rootFocusNode.removeListener(_handleRootFocusChange);
      rootFocusNode.dispose();
    }
  }

  void init() {
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

  void attachLyric({
    required BuildContext context,
    String? serviceId,
    String? text,
  }) {
    if (text != null && text.isNotEmpty) {
      lyric.value = convertTextInLyric(text);
      isEditing = false;
    } else {
      lyric.value = _lyricsListStore.selectedLyric;
      isEditing = true;
      Future.delayed(Duration(milliseconds: 100), () {
        _lyricsListStore.tappedIndex.value = null;
      });
    }
  }

  Future<List<LyricEntity>> getOnlineLyrics({
    required Map<String, Object> params,
    required BuildContext context,
  }) async {
    final response = await _onlineUseCases.get(params: params);
    return response.fold(
      (l) => LyricAdapter.fromMapList(l),
      (GenericException r) => showCustomToast(
        type: .error,
        context: context,
        duration: const Duration(seconds: 1),
        title: 'Erro ao Carregar Letras',
        message:
            'Ocorreu um erro ao carregar as letras. Verifique a internet e tente novamente.',
      ),
    );
  }

  Future<List<LyricEntity>> getOnlineLyricsPagination({
    required Map<String, Object> params,
    required BuildContext context,
  }) async {
    final response = await _onlineUseCases.get(params: params);
    return response.fold(
      (l) => LyricAdapter.fromMapList(l),
      (GenericException r) => showCustomToast(
        type: .error,
        context: context,
        duration: const Duration(seconds: 1),
        title: 'Erro ao Carregar Letras',
        message:
            'Ocorreu um erro ao carregar as letras. Verifique a internet e tente novamente.',
      ),
    );
  }

  void toggleChorusStatus(int verseIndex) {
    final verse = lyric.value.verses[verseIndex];

    final updatedVerse = verse.copyWith(isChorus: !verse.isChorus);

    final updatedVerses = List<VerseEntity>.from(lyric.value.verses);
    updatedVerses[verseIndex] = updatedVerse;

    lyric.value = lyric.value.copyWith(verses: updatedVerses);
    value = RefreshingState();
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

  void toast(
    BuildContext context,
    String message,
    String title, {
    Function()? onDelayedAction,
    ToastType? type,
  }) {
    if (context.mounted) {
      showCustomToast(
        type: type ?? ToastType.error,
        context: context,
        duration: const Duration(seconds: 1),
        title: title,
        message: message,
        onDelayedAction: onDelayedAction,
      );
    }
  }

  Future<LyricEntity?> saveLyric(BuildContext context) async {
    isSavePressed.value = true;
    if (await isConnected(context: context)) {
      final response = await _onlineUseCases.upsert(
        params: {'table': 'lyrics', 'selectFields': 'id'},
        data: LyricAdapter.toMap(lyric.value),
      );
      response.fold(
        (lyricsResponse) async {
          if (hasAttached) {
            final response = await _onlineUseCases.upsert(
              params: {'table': 'service_lyrics'},
              data: {
                'service_id': int.parse(serviceId),
                'lyric_id': lyricsResponse[0]['id'],
              },
            );
            response.fold((_) {}, (GenericException r) {
              bool isDuplicated = (r.code == '23505');
              return right(
                toast(
                  context,
                  type: isDuplicated ? ToastType.warning : null,
                  isDuplicated
                      ? 'Essa letra já existe na lista de letras do culto.'
                      : 'Ocorreu um erro ao salvar a música. Verifique a internet e tente novamente.',
                  isDuplicated ? 'Letra duplicada!' : 'Problema ao salvar!',
                  onDelayedAction: () {
                    isSavePressed.value = false;
                    value = RefreshingState();
                  },
                ),
              );
            });
          }

          lyric.value = lyric.value.copyWith(
            id: lyricsResponse[0]['id'].toString(),
          );

          if (context.mounted) {
            showCustomToast(
              context: context,
              title: 'Sucesso!',
              message: 'Musica salva com sucesso.',
              duration: const Duration(seconds: 1),
              onDelayedAction: () {
                isSavePressed.value = false;
                value = RefreshingState();
                buttonCallback();
              },
            );
          }
        },
        (_) {
          return right(
            toast(
              context,
              'Ocorreu um erro ao salvar a música. Verifique a internet e tente novamente.',
              'Erro ao salvar!',
              onDelayedAction: () {
                isSavePressed.value = false;
                value = RefreshingState();
              },
            ),
          );
        },
      );
      return lyric.value;
    } else {
      return null;
    }
  }

  Future<void> deleteLyric({
    required BuildContext context,
    String lyricId = '',
    Map<String, dynamic>? params,
    bool isAttached = false,
  }) async {
    final response = await _onlineUseCases.delete(
      params:
          params ??
          {
            'table': 'lyrics',
            'whereClause': 'id',
            'referenceValue': int.parse(lyricId),
          },
    );
    response.fold(
      (_) {
        if (!isAttached) {
          _lyricsListStore.entitiesList.remove(
            _lyricsListStore.entitiesList.firstWhere((e) => e.id == lyricId),
          );
        }
        if (context.mounted) {
          showCustomToast(
            context: context,
            title: 'Sucesso!',
            message: 'Música deletada com sucesso.',
          );
        }
      },
      (_) => toast(
        context,
        'Ocorreu um erro ao deletar a música. Verifique a internet e tente novamente.',
        'Erro ao deletar!',
      ),
    );
  }
}

@immutable
abstract class ManageLyricState {}
