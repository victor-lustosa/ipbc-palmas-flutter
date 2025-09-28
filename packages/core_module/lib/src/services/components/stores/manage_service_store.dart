
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class ManageServiceStore extends ValueNotifier<GenericState<ManageServiceState>>
    with DateMixin, ConnectivityMixin {
  ManageServiceStore({
    required IUseCases useCases,
  }) : _useCases = useCases,
       super(InitialState<ManageServiceState>());

  String? _nextFocusId;
  String? _currentlyFocusedLiturgyId;
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
  ValueNotifier<bool> isSavePressed = ValueNotifier(false);

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
  }

  resetValidationFields() {
    changeValue(isThemeValid, true);
    changeValue(isPreacherValid, true);
  }

  clearFocusAndControllers() {
    for (var node in _focusNodes.values) {
      node.dispose();
    }
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    _focusNodes.clear();
    _controllers.clear();
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

  void controllersAndFocusNodes() {
    clearFocusAndControllers();
    for (var liturgy in liturgiesList) {
      _addControllersAndFocusNodesForItem(liturgy);
    }
  }

  void _addControllersAndFocusNodesForItem(LiturgyEntity liturgy) {
    final liturgyId = liturgy.id!;
    final sequenceKey = '${liturgyId}_0';
    final additionalKey = '${liturgyId}_1';

    void focusListener(bool hasFocus) {
      if (hasFocus) {
        _currentlyFocusedLiturgyId = liturgyId;
      } else {
        if (_currentlyFocusedLiturgyId == liturgyId) {
          _currentlyFocusedLiturgyId = null;
        }
      }
      value = UpdateFormFieldState();
    }

    final titleController = TextEditingController(text: liturgy.sequence);
    final titleFocusNode = FocusNode();

    titleFocusNode.addListener(() => focusListener(titleFocusNode.hasFocus));

    _controllers[sequenceKey] = titleController;
    _focusNodes[sequenceKey] = titleFocusNode;

    if (liturgy.isAdditional) {
      final subtitleController = TextEditingController(text: liturgy.additional);
      final subtitleFocusNode = FocusNode();
      subtitleFocusNode.addListener(() {
        focusListener(subtitleFocusNode.hasFocus);
        value = UpdateFormFieldState();
        if (!subtitleFocusNode.hasFocus && subtitleController.text.isEmpty) {
          final index = liturgiesList.indexWhere((item) => item.id == liturgyId);
          if (index != -1 && liturgiesList[index].isAdditional) {
            liturgiesList[index] = liturgiesList[index].copyWith(isAdditional: false);
          }
        }
      });

      _controllers[additionalKey] = subtitleController;
      _focusNodes[additionalKey] = subtitleFocusNode;
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
    value = UpdateFormFieldState();
  }

  bool isEmptyData(String? data) {
    return (data == null || data.isEmpty);
  }

  changeValue(ValueNotifier<bool> valueNotifier, bool newValue) {
    Future.delayed(Duration.zero, () async {
      valueNotifier.value = newValue;
      value = UpdateFormFieldState();
    });
  }

  Future<void> submit(BuildContext context) async {
    isSavePressed.value = true;
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
          await showCustomMessageDialog(
            context: context,
            title: 'Sucesso!',
            message: 'Culto salvo',
            type: DialogType.success,
          );

          Modular.get<ServiceStore>().servicesEntity = servicesEntity;
          Modular.get<ServiceStore>().serviceEntity = serviceEntity!;

          if (updateCallbackParam != null && context.mounted) {
            updateCallbackParam!();
          }
        }
      }
      value = DataAddedState<ManageServiceState>();
      isSavePressed.value = false;
    } else {
      isSavePressed.value = false;
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
    value = UpdateFormFieldState();
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
    value = UpdateFormFieldState();
  }

  void addBox() {
    liturgiesList.insert(
      0,
      LiturgyEntity(
        id: (liturgiesList.length + 1).toString(),
        isAdditional: false,
        sequence: 'Título',
      ),
    );
    controllersAndFocusNodes();
    value = UpdateFormFieldState();
  }

  void copyBox() {
    final String currentSequence =
        _controllers['${liturgyModel.id}_0']?.text ?? liturgyModel.sequence;
    final String? currentAdditional =
        _controllers['${liturgyModel.id}_1']?.text;

    final updatedLiturgyModel = liturgyModel.copyWith(
      sequence: currentSequence,
      additional: currentAdditional,
    );
    liturgiesList[index] = updatedLiturgyModel;
    final newLiturgy = updatedLiturgyModel.copyWith(
      id: (liturgiesList.length + 1).toString(),
    );

    liturgiesList.insert(index + 1, newLiturgy);
    controllersAndFocusNodes();
    value = UpdateFormFieldState();
  }

  bool deleteBox({required String? key}) {
    if (key == null) return false;

    final indexToDelete = liturgiesList.indexWhere((item) => item.id == key);
    if (indexToDelete == -1) return false;

    bool shouldMoveFocus = false;

    if (_currentlyFocusedLiturgyId != null) {
      shouldMoveFocus = true;

      final indexToFocus = (indexToDelete > 0) ? indexToDelete - 1 : 0;
      if (liturgiesList.length > 1) {
        _nextFocusId = liturgiesList[indexToFocus].id;
      } else {
        _nextFocusId = null;
      }
    }

    liturgiesList.removeAt(indexToDelete);

    if (liturgiesList.isNotEmpty) {
      final indexToFocus = (indexToDelete > 0) ? indexToDelete - 1 : 0;
      _nextFocusId = liturgiesList[indexToFocus].id;
    }

    _controllers.remove("${key}_0")?.dispose();
    _focusNodes.remove("${key}_0")?.dispose();
    _controllers.remove("${key}_1")?.dispose();
    _focusNodes.remove("${key}_1")?.dispose();

    value = UpdateFormFieldState();
    return shouldMoveFocus;
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

  void activateAdditionalField(String liturgyId) {
    final index = liturgiesList.indexWhere((item) => item.id == liturgyId);
    if (index != -1) {
      final liturgy = liturgiesList[index];
      if (!liturgy.isAdditional) {
        _nextFocusId = liturgyId;
        liturgiesList[index] = liturgy.copyWith(isAdditional: true);
        _addControllersAndFocusNodesForItem(liturgiesList[index]);
        value = UpdateFormFieldState();
      }
    }
  }

  void requestFocusAfterBuild() {
    if (_nextFocusId != null) {
      final focusNode = _focusNodes["${_nextFocusId}_0"];
      focusNode?.requestFocus();
      _nextFocusId = null;
    }
  }

  void deactivateAdditionalField(String liturgyId) {
    final additionalKey = '${liturgyId}_1';
    _controllers.remove(additionalKey);
    _focusNodes.remove(additionalKey);
  }

  bool shouldAutofocus(String liturgyId) {
    if (_nextFocusId == liturgyId) {
      _nextFocusId = null;
      return true;
    }
    return false;
  }
  void updateLiturgyItemState(String liturgyId, bool isAdditional) {
    final index = liturgiesList.indexWhere((item) => item.id == liturgyId);
    if (index != -1) {
      liturgiesList[index] = liturgiesList[index].copyWith(isAdditional: isAdditional);
      notifyListeners();
    }
  }
}

@immutable
abstract class ManageServiceState {}
