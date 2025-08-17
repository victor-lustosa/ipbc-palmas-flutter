import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class EditLiturgyStore extends ValueNotifier<GenericState<EditLiturgyState>> with DateMixin, ConnectivityMixin {
  EditLiturgyStore({required IUseCases useCases})
    : _useCases = useCases,
      super(InitialState<EditLiturgyState>()) {
    init();
  }

  final IUseCases _useCases;
  bool isEditing = false;
  int index = 0;
  late LiturgyModel liturgyModel;
  late List<LiturgyModel> liturgiesList;
  late ServicesEntity servicesEntity;
  late ServiceEntity serviceEntity;
  TimeOfDay? serviceHour;

  final TextEditingController preacherController = TextEditingController();
  final TextEditingController themeController = TextEditingController();
  final String preacherErrorText = 'por favor, insira o preletor do culto.';
  final String themeErrorText = 'por favor, insira a mensagem do culto.';

  final preacherKey = GlobalKey<FormState>();
  final themeKey = GlobalKey<FormState>();

  ValueNotifier<bool> isPreacherValid = ValueNotifier(true);
  ValueNotifier<bool> isThemeValid = ValueNotifier(true);
  bool isPressed = false;

  final Map<String, TextEditingController> _controllers = {};
  final Map<String, FocusNode> _focusNodes = {};

  late FocusScopeNode _rootFocusNode;

  get rootFocusNode => _rootFocusNode;

  get controllers => _controllers;

  get focusNodes => _focusNodes;

  bool isAnyTextFieldFocused = false;

  init() {
    fillItems();
    controllersAndFocusNodes();
    _rootFocusNode = FocusScopeNode();
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

  void controllersAndFocusNodes({bool isRemove = false}) {
    for (int i = 0; i < liturgiesList.length; i++) {
      final liturgy = liturgiesList[i];
      final sequenceKey = '${liturgy.id}_0';
      final additionalKey = '${liturgy.id}_1';
      if(!isRemove){

      }
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
    initDate(
      startTimeParam: serviceHour,
      startDateParam: nextWeekdayWithTime(
        DateTime.now(),
        servicesEntity.dayOfWeek,
        serviceHour,
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
  static String createId() => DateTime.now().microsecondsSinceEpoch.toString();
  Future<void> addData(BuildContext context) async {
    if (validateAllFields()) {
      final response = await isConnected();
      if (response) {
        final typeList = servicesEntity.path.split('/');
        value = AddDataEvent<EditLiturgyState>();
        _useCases.add(
          data: ServiceAdapter.toMap(
            ServiceEntity(
              id: createId(),
              image: servicesEntity.image,
              theme: themeController.text,
              hour: servicesEntity.hour,
              preacher: preacherController.text,
              type: typeList[2],
              guideIsVisible: false,
              createAt: DateTime.now(),
              lyricsList: [],
              liturgiesList: liturgiesList,
              title: servicesEntity.title,
              heading: servicesEntity.heading,
            ),
          ),
          params: {'table': 'service'},
        );
        if (context.mounted) {
          showCustomSuccessDialog(
            context: context,
            title: 'Sucesso!',
            message: 'Evento salvo',
          );
        }
      }
      value = DataAddedState<EditLiturgyState>();
    } else {
      value = NoConnectionState<EditLiturgyState>();
    }
  }

  fillItems() {
    liturgiesList = [
      LiturgyModel(
        id: '0',
        isAdditional: false,
        sequence: 'Oração',
        additional: '',
      ),
      LiturgyModel(
        id: '1',
        isAdditional: true,
        sequence: 'Texto Bíblico',
        additional: 'João 10:1-6',
      ),
      LiturgyModel(
        id: '2',
        isAdditional: true,
        sequence: 'Hino 151',
        additional: 'O Bom Pastor',
      ),
      LiturgyModel(
        id: '3',
        isAdditional: true,
        sequence: 'Texto Bíblico',
        additional: 'Lucas 15:1-7',
      ),
      LiturgyModel(
        id: '4',
        isAdditional: false,
        sequence: 'Oração de confissão de pecados',
        additional: '',
      ),
      LiturgyModel(
        id: '5',
        isAdditional: false,
        sequence: 'Cânticos',
        additional: '',
      ),
      LiturgyModel(
        id: '6',
        isAdditional: true,
        sequence: 'Pregação',
        additional: 'O Bom Pastor - Salmo 23',
      ),
      LiturgyModel(
        id: '7',
        isAdditional: false,
        sequence: 'Santa Ceia',
        additional: '',
      ),
      LiturgyModel(
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
      index,
      LiturgyModel(
        id: SupaServicesUtil.createId(),
        isAdditional: true,
        sequence: 'Título',
        additional: 'Descrição',
      ),
    );
    controllersAndFocusNodes();
    notifyListeners();
  }

  void copyEntity() {
    liturgiesList.insert(
      index,
      liturgyModel.copyWith(id: SupaServicesUtil.createId()),
    );
    controllersAndFocusNodes();
    notifyListeners();
  }

  void delete() {
    liturgiesList.remove(liturgyModel);
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
}

@immutable
abstract class EditLiturgyState {}
