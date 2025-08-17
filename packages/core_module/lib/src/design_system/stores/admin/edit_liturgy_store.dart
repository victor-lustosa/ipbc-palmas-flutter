import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../../core/infra/adapters/liturgy_adapter.dart';

class EditLiturgyStore extends ValueNotifier<GenericState<EditLiturgyState>>
    with DateMixin, ConnectivityMixin {
  EditLiturgyStore({required IUseCases useCases})
    : _useCases = useCases,
      super(InitialState<EditLiturgyState>()) {
    servicesEntity = ServicesEntity(
      image:
          "https://xrvmfhpmelyvupfylnfk.supabase.co/storage/v1/object/public/covers/mobile_service_covers/saturday_evening.png",
      id: "0",
      hour: "19h30",
      title: "Sábado à noite",
      heading: "sábado à noite (UMP)",
      path: "service/type/saturday-services/createAt/true",
    );
    init();
  }

  final IUseCases _useCases;
  bool isEditing = false;
  int index = 0;
  late LiturgyModel liturgyModel;
  late List<LiturgyEntity> liturgiesList;
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
    setDayInTheWeek();
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

  edit({required ServicesEntity servicesEntityParam, required ServiceEntity serviceEntityParam}) {
    isEditing = true;
    servicesEntity = servicesEntityParam;
    serviceEntity = serviceEntityParam;
    liturgiesList = serviceEntityParam.liturgiesList ?? [];
    themeController.text = serviceEntity.title;
    preacherController.text = serviceEntity.preacher;
    startDate = DateTime.parse(int.parse(serviceEntity.hour.split('h').first));
    startTime = parseTimeOfDayFromH(serviceEntity.hour);
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

  Future<void> addData(BuildContext context) async {
    if (validateAllFields()) {
      final response = await isConnected();
      if (response) {
        final typeList = servicesEntity.path.split('/');
        value = AddDataEvent<EditLiturgyState>();
        final liturgyResponse = await _useCases.add(
          params: {'table': 'liturgies', 'selectFields': 'id'},
          data: LiturgyAdapter.supabaseToMap(
            LiturgySupabase(
              id: MockUtil.createId(),
              liturgy: LiturgyAdapter.toMapList(liturgiesList),
            ),
          ),
        );
        final serviceResponse = await _useCases.add(
        data: ServiceAdapter.toMap(
          ServiceEntity(
            id: MockUtil.createId(),
            image: servicesEntity.image,
            theme: themeController.text,
            hour: servicesEntity.hour,
            preacher: preacherController.text,
            type: typeList[2],
            guideIsVisible: false,
            createAt: DateTime.now(),
            title: servicesEntity.title,
            heading: servicesEntity.heading,
          ),
        ),
        params: {'table': 'service', 'selectFields': 'id'},
      );
        await _useCases.add(
          params: {'table': 'service_liturgies'},
          data: ServiceAdapter.serviceLiturgiesToMap(
            ServiceLiturgiesSupabase(
              id: MockUtil.createId(),
              liturgyId: liturgyResponse[0]['id'],
              serviceId: serviceResponse[0]['id'],
            ),
          ),
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
      0,
      LiturgyModel(
        id: MockUtil.createId(),
        isAdditional: true,
        sequence: 'Título',
        additional: 'Descrição',
      ),
    );
    controllersAndFocusNodes();
    notifyListeners();
  }

  void copyEntity() {
    liturgiesList.insert(index, liturgyModel.copyWith(id: MockUtil.createId()));
    controllersAndFocusNodes();
    notifyListeners();
  }

  void delete({required String? key}) {
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
}

@immutable
abstract class EditLiturgyState {}
