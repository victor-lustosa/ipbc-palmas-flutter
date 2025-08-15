import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class EditLiturgyDTO {
  EditLiturgyDTO({required this.heading, required this.image});

  final String heading;
  final String image;
}

class EditLiturgyStore extends ChangeNotifier with DateMixin {

  EditLiturgyStore(){
    init();
  }

  int index = 0;
  late LiturgyModel entity;
  late EditLiturgyDTO dto;
  late List<LiturgyModel> liturgiesList;
  TimeOfDay? serviceHour;
  late int? dayOfWeek;

  final Map<String, TextEditingController> _controllers = {};
  final Map<String, FocusNode> _focusNodes = {};

  late FocusScopeNode _rootFocusNode;
  get rootFocusNode => _rootFocusNode;
  get controllers => _controllers;

  get focusNodes => _focusNodes;

  bool isAnyTextFieldFocused = false;

  init(){
    fillItems();
    initializeControllersAndFocusNodes();
    _rootFocusNode = FocusScopeNode();
  }
  void initializeControllersAndFocusNodes() {
    for (int i = 0; i < liturgiesList.length; i++) {
      final liturgy = liturgiesList[i];
        final sequenceKey = '${liturgy.id}_0';
        final additionalKey = '${liturgy.id}_1';
        _controllers[sequenceKey] = TextEditingController(text: liturgiesList[i].sequence);
        _focusNodes[sequenceKey] = FocusNode();
        if(liturgy.isAdditional){
          _controllers[additionalKey] = TextEditingController(text: liturgiesList[i].additional);
          _focusNodes[additionalKey] = FocusNode();
        }
      }
    }

  final TextEditingController preacherController = TextEditingController();
  final TextEditingController themeController = TextEditingController();
  final String preacherErrorText = 'por favor, insira o preletor do culto.';
  final String themeErrorText = 'por favor, insira a mensagem do culto.';

  final preacherKey = GlobalKey<FormState>();
  final themeKey = GlobalKey<FormState>();

  ValueNotifier<bool> isPreacherValid = ValueNotifier(true);
  ValueNotifier<bool> isThemeValid = ValueNotifier(true);
  bool isPressed = false;

  preacherValidation(String? data) {
    if (data == null || data.isEmpty) {
      changeValue(isPreacherValid, false);
      return null;
    } else {
      changeValue(isPreacherValid, true);
      return null;
    }
  }

  setDayInTheWeek() {
    initDate(
      startDateParam: nextWeekdayWithTime(
        DateTime.now(),
        dayOfWeek,
        serviceHour,
      ),
    );
    notifyListeners();
  }

  themeValidation(String? data) {
    if (data == null || data.isEmpty) {
      changeValue(isThemeValid, false);
      return null;
    } else {
      changeValue(isThemeValid, true);
      return null;
    }
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

  void setEditLiturgyDTO(EditLiturgyDTO dto) {
    this.dto = dto;
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
    notifyListeners();
  }

  void copyEntity() {
    liturgiesList.insert(index, entity.copyWith(id: SupaServicesUtil.createId()));
    notifyListeners();
  }

  void delete() {
    liturgiesList.remove(entity);
    notifyListeners();
  }
}
