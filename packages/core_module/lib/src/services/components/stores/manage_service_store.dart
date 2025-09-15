import 'dart:math';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class ManageServiceStore extends ValueNotifier<GenericState<ManageServiceState>>
    with DateMixin, ConnectivityMixin {
  ManageServiceStore({
    required IUseCases useCases,
    required SearchLyricsStore searchLyricsStore,
    required ManageLyricStore manageLyricStore,
  }) : _useCases = useCases,
       _searchLyricsStore = searchLyricsStore,
       _manageLyricStore = manageLyricStore,
       super(InitialState<ManageServiceState>());
  final SearchLyricsStore _searchLyricsStore;
  final ManageLyricStore _manageLyricStore;

  get searchLyricsStore => _searchLyricsStore;
  final IUseCases _useCases;
  bool isEditing = false;
  int index = 0;
  late LiturgyEntity liturgyModel;
  late List<LiturgyEntity> liturgiesList;
  late ServicesEntity servicesEntity;
  ServiceEntity? serviceEntity;
  late Function? updateCallbackParam;

  TextEditingController preacherController = TextEditingController();
  TextEditingController themeController = TextEditingController();
  final String preacherErrorText = 'por favor, insira o preletor do culto.';
  final String themeErrorText = 'por favor, insira a mensagem do culto.';

  final preacherKey = GlobalKey<FormState>();
  final themeKey = GlobalKey<FormState>();

  ValueNotifier<bool> isPreacherValid = ValueNotifier(true);
  ValueNotifier<bool> isThemeValid = ValueNotifier(true);
  ValueNotifier<bool> isPressed = ValueNotifier(false);

  final Map<String, TextEditingController> _controllers = {};
  final Map<String, FocusNode> _focusNodes = {};

  late FocusScopeNode _rootFocusNode;

  get rootFocusNode => _rootFocusNode;

  get controllers => _controllers;

  get focusNodes => _focusNodes;

  bool isAnyTextFieldFocused = false;

  init() {
    if (!isEditing) {
      fillItems();
      setDayInTheWeek();
      controllersAndFocusNodes();
      preacherController.clear();
      themeController.clear();
    }
    _rootFocusNode = FocusScopeNode();
    _rootFocusNode.addListener(_handleRootFocusChange);
  }

  clear() {
    _rootFocusNode.removeListener(_handleRootFocusChange);
    resetValidationFields();
  }

  void _handleRootFocusChange() {
    if (isAnyTextFieldFocused != _rootFocusNode.hasFocus) {
      isAnyTextFieldFocused = _rootFocusNode.hasFocus;
      notifyListeners();
    }
  }

  formValidation(String? data, ValueNotifier<bool> isValid) {
    if (isEmptyData(data)) {
      changeValue(isValid, false);
      return null;
    } else {
      changeValue(isValid, true);
      return null;
    }
  }

  edit() {
    isEditing = true;
    liturgiesList = serviceEntity?.liturgiesList ?? [];
    themeController.text = serviceEntity!.theme;
    preacherController.text = serviceEntity!.preacher;
    startDate = serviceEntity?.serviceDate;
    startTime = TimeOfDay(
      hour: serviceEntity!.serviceDate.hour,
      minute: serviceEntity!.serviceDate.minute,
    );
    controllersAndFocusNodes();
  }

  void controllersAndFocusNodes({bool isRemove = false}) {
    for (int i = 0; i < liturgiesList.length; i++) {
      final liturgy = liturgiesList[i];
      final sequenceKey = '${liturgy.id}_0';
      final additionalKey = '${liturgy.id}_1';
      _controllers[sequenceKey] = TextEditingController(
        text: liturgiesList[i].sequence,
      );
      _focusNodes[sequenceKey] = FocusNode();
      if (liturgy.isAdditional) {
        _controllers[additionalKey] = TextEditingController(
          text: liturgiesList[i].additional,
        );
        _focusNodes[additionalKey] = FocusNode();
      }
    }
  }

  setDayInTheWeek() {
    startTime = TimeOfDay(
      hour: servicesEntity.serviceDate.hour,
      minute: servicesEntity.serviceDate.minute,
    );
    initDate(
      startDateParam: nextWeekdayWithTime(
        DateTime.now(),
        servicesEntity.dayOfWeek,
        startTime,
      ),
    );
    notifyListeners();
  }

  resetValidationFields() {
    changeValue(isThemeValid, true);
    changeValue(isPreacherValid, true);
  }

  bool isEmptyData(String? data) {
    return (data == null || data.isEmpty);
  }

  changeValue(ValueNotifier<bool> valueNotifier, bool newValue) {
    Future.delayed(Duration.zero, () async {
      valueNotifier.value = newValue;
      notifyListeners();
    });
  }

  Future<void> submit(BuildContext context) async {
    if (validateAllFields()) {
      final response = await isConnected();
      if (response) {
        final typeList = servicesEntity.path.split('/');
        value = AddDataEvent<ManageServiceState>();
        bool isServiceNotNull = serviceEntity != null;
        serviceEntity = ServiceEntity(
          id: (isEditing && isServiceNotNull) ? serviceEntity!.id : null,
          image: servicesEntity.image,
          theme: themeController.text,
          serviceDate: DateTime(
            startDate!.year,
            startDate!.month,
            startDate!.day,
            startTime!.hour,
            startTime!.minute,
          ),
          liturgiesList: liturgiesList,
          serviceLiturgiesTableId: isServiceNotNull
              ? serviceEntity!.serviceLiturgiesTableId
              : '',
          liturgiesTableId: isServiceNotNull
              ? serviceEntity!.liturgiesTableId
              : '',
          preacher: preacherController.text,
          type: typeList[2],
          guideIsVisible: liturgiesList.isNotEmpty,
          createAt: (isEditing && isServiceNotNull)
              ? serviceEntity!.createAt
              : DateTime.now(),
          title: servicesEntity.title,
          heading: servicesEntity.heading,
        );

        await _useCases.upsert(
          params: {'table': 'service'},
          data: ServiceAdapter.toMap(serviceEntity!),
        );

        if (context.mounted) {
          await showCustomSuccessDialog(
            context: context,
            title: 'Sucesso!',
            message: 'Culto salvo',
          );

          Modular.get<ServiceStore>().servicesEntity = servicesEntity;
          Modular.get<ServiceStore>().serviceEntity = serviceEntity!;

          if (updateCallbackParam != null && context.mounted) {
            updateCallbackParam!();
          }
        }
      }
      value = DataAddedState<ManageServiceState>();
    } else {
      value = NoConnectionState<ManageServiceState>();
    }
  }

  Future<dynamic> delete(ServiceEntity entitiesList) async {
    final response = await _useCases.delete(
      params: {
        'table': 'service',
        'referenceField': 'id',
        'referenceValue': entitiesList.id,
        'selectFields': 'id',
      },
    );
    notifyListeners();
    return Future.value(response[0]);
  }

  fillItems() {
    liturgiesList = [
      LiturgyEntity(
        id: '0',
        isAdditional: false,
        sequence: 'Oração',
        additional: '',
      ),
      LiturgyEntity(
        id: '1',
        isAdditional: true,
        sequence: 'Texto Bíblico',
        additional: 'João 10:1-6',
      ),
      LiturgyEntity(
        id: '2',
        isAdditional: true,
        sequence: 'Hino 151',
        additional: 'O Bom Pastor',
      ),
      LiturgyEntity(
        id: '3',
        isAdditional: true,
        sequence: 'Texto Bíblico',
        additional: 'Lucas 15:1-7',
      ),
      LiturgyEntity(
        id: '4',
        isAdditional: false,
        sequence: 'Oração de confissão de pecados',
        additional: '',
      ),
      LiturgyEntity(
        id: '5',
        isAdditional: false,
        sequence: 'Cânticos',
        additional: '',
      ),
      LiturgyEntity(
        id: '6',
        isAdditional: true,
        sequence: 'Pregação',
        additional: 'O Bom Pastor - Salmo 23',
      ),
      LiturgyEntity(
        id: '7',
        isAdditional: false,
        sequence: 'Santa Ceia',
        additional: '',
      ),
      LiturgyEntity(
        id: '8',
        isAdditional: false,
        sequence: 'Oração final',
        additional: '',
      ),
    ];
    notifyListeners();
  }

  void addBox() {
    liturgiesList.insert(
      0,
      LiturgyEntity(
        id: MockUtil.createId(),
        isAdditional: true,
        sequence: 'Título',
        additional: 'Descrição',
      ),
    );
    controllersAndFocusNodes();
    notifyListeners();
  }

  void copyBox() {
    liturgiesList.insert(index, liturgyModel.copyWith(id: MockUtil.createId()));
    controllersAndFocusNodes();
    notifyListeners();
  }

  void deleteBox({required String? key}) {
    liturgiesList.remove(liturgyModel);
    _controllers.remove("${key}_0");
    _focusNodes.remove("${key}_0");
    if (liturgyModel.isAdditional) {
      _controllers.remove("${key}_1");
      _focusNodes.remove("${key}_1");
    }
    controllersAndFocusNodes();
    notifyListeners();
  }

  bool validateAllFields() {
    bool allTextValid = true;
    if (preacherController.text.trim().isEmpty ||
        themeController.text.trim().isEmpty) {
      formValidation(preacherController.text, isPreacherValid);
      formValidation(themeController.text, isThemeValid);
      allTextValid = false;
    }
    return allTextValid;
  }
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

  void addLyric({required String? text}) {
    if (text != null && text.isNotEmpty) {
      _manageLyricStore.lyric = convertTextInLyric(text);
      _manageLyricStore.buttonCallback = () {
        _manageLyricStore.addLyric();
        popUntil(
          (route) =>
              route.settings.name ==
              AppRoutes.servicesRoute + AppRoutes.serviceRoute,
        );
      };
      pushNamed(AppRoutes.servicesRoute + AppRoutes.manageLyricsRoute);
    }
  }
}

@immutable
abstract class ManageServiceState {}
