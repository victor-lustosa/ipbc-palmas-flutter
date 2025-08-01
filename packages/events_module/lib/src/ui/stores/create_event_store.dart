import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class CreateEventStore extends ValueNotifier<GenericState<CreateEventState>>
    with ImageMixin, ConnectivityMixin {

  bool isSwitchOn = false;

  final IUseCases _useCases;
  final String eventPath = 'event';
  CreateEventStore({required IUseCases useCases})
      : _useCases = useCases,
        super(InitialState<CreateEventState>());

  final TextEditingController eventTitleController = TextEditingController();
  final TextEditingController eventSubtitleController = TextEditingController();
  final TextEditingController eventLocationController = TextEditingController();
  final TextEditingController eventLocationNameController =
      TextEditingController();
  final TextEditingController eventLinkController = TextEditingController();
  final TextEditingController contactLinkController = TextEditingController();
  final TextEditingController eventLinkDescriptionController =
      TextEditingController();
  final TextEditingController eventDescriptionController =
      TextEditingController();
  final String eventTitleErrorText = 'por favor, insira o título do evento.';
  final String eventSubtitleErrorText = 'por favor, insira o título do evento.';
  final String contactLinkErrorText =
      'por favor, insira o link do contato do evento.';
  final String eventLocationErrorText =
      'por favor, insira o link da localização do evento.';
  final String eventLocationNameErrorText =
      'por favor, insira o nome da localização do evento.';
  final String eventDescriptionErrorText =
      'por favor, insira a descrição do evento.';
  final String eventLinkErrorText = 'por favor, insira o link do evento.';
  final String eventLinkDescriptionErrorText =
      'por favor, insira a descrição do link do evento.';
  final eventTitleKey = GlobalKey<FormState>();
  final eventSubtitleKey = GlobalKey<FormState>();
  final contactLinkKey = GlobalKey<FormState>();
  final eventLinkKey = GlobalKey<FormState>();
  final eventLinkDescriptionKey = GlobalKey<FormState>();
  final eventLocationKey = GlobalKey<FormState>();
  final eventLocationNameKey = GlobalKey<FormState>();
  final eventDescriptionKey = GlobalKey<FormState>();
  ValueNotifier<bool> isEventTitleValid = ValueNotifier(true);
  ValueNotifier<bool> isEventSubtitleValid = ValueNotifier(true);
  ValueNotifier<bool> isContactLinkValid = ValueNotifier(true);
  ValueNotifier<bool> isEventLocationValid = ValueNotifier(true);
  ValueNotifier<bool> isEventLocationNameValid = ValueNotifier(true);
  ValueNotifier<bool> isEventDescriptionValid = ValueNotifier(true);
  ValueNotifier<bool> isEventLinkValid = ValueNotifier(true);
  ValueNotifier<bool> isEventLinkDescriptionValid = ValueNotifier(true);
  ValueNotifier<bool> isCoverImageValid = ValueNotifier(true);
  bool isPressed = false;
  File coverImage = File('');


  late DateTime startDate;
  late DateTime endDate;
  TimeOfDay startTime = TimeOfDay(hour: 08, minute: 00);
  TimeOfDay endTime = TimeOfDay(hour: 18, minute: 30);

  // Função para formatar como "19h30"
  String formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '${hour}h$minute';
  }

  // Função para abrir o relógio
  Future<void> pickTime(
      {required TimeOfDay selectedTime,
        required Function(TimeOfDay) onTimePicked, required BuildContext context}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      onTimePicked(picked);
    }
  }



  titleValidation(String? data) {
    if (data == null || data.isEmpty) {
      changeValue(isEventTitleValid, false);
      return null;
    } else {
      changeValue(isEventTitleValid, true);
      return null;
    }
  }

  subtitleValidation(String? data) {
    if (data == null || data.isEmpty) {
      changeValue(isEventSubtitleValid, false);
      return null;
    } else {
      changeValue(isEventSubtitleValid, true);
      return null;
    }
  }

  descriptionValidation(String? data) {
    if (isEmptyData(data)) {
      changeValue(isEventDescriptionValid, false);
      return null;
    } else {
      changeValue(isEventDescriptionValid, true);
      return null;
    }
  }

  locationValidation(String? data) {
    if (isEmptyData(data)) {
      changeValue(isEventLocationValid, false);
      return null;
    } else {
      changeValue(isEventLocationValid, true);
      return null;
    }
  }

  linkValidation(String? data) {
    if (isEmptyData(data)) {
      changeValue(isEventLinkValid, false);
      return null;
    } else {
      changeValue(isEventLinkValid, true);
      return null;
    }
  }

  linkDescriptionValidation(String? data) {
    if (isEmptyData(data)) {
      changeValue(isEventLinkDescriptionValid, false);
      return null;
    } else {
      changeValue(isEventLinkDescriptionValid, true);
      return null;
    }
  }

  contactLinkValidation(String? data) {
    if (isEmptyData(data)) {
      changeValue(isContactLinkValid, false);
      return null;
    } else {
      changeValue(isContactLinkValid, true);
      return null;
    }
  }

  bool isEmptyData(String? data) {
    return (data == null || data.isEmpty);
  }

  emailValidation(String? data) {
    return null;
  }

  changeValue(ValueNotifier<bool> valueNotifier, bool newValue) {
    Future.delayed(Duration.zero, () async {
      valueNotifier.value = newValue;
      value = UpdateFormFieldState();
    });
  }

  getImage() async {
    value = LoadingImageState();
    final result = await getGalleryImage();
    if (result != null) {
      coverImage = result;
      value = FetchedImageState();
      changeValue(isCoverImageValid, true);
    } else {
      if (coverImage.path.isEmpty) {
        value = InitialState<CreateEventState>();
        changeValue(isCoverImageValid, false);
      } else {
        value = FetchedImageState();
        changeValue(isCoverImageValid, true);
      }
    }
  }

  EventEntity fillEventEntity(){
    EventEntity entity = EventEntity(
      id: createId(),
      title: eventTitleController.text,
      subtitle: eventSubtitleController.text,
      image: coverImage.path,
      startDateTime: combineDateAndTime(startDate, startTime),
      endDateTime: combineDateAndTime(endDate, endTime),
      description: eventDescriptionController.text,
      location: eventLocationController.text,
      localName: eventLocationNameController.text,
      signUpLink: eventLinkController.text,
      contactLink: contactLinkController.text,
      createAt: DateTime.now()
    );
    return entity;
  }
  static String createId() => DateTime.now().microsecondsSinceEpoch.toString();

  Future<void> addData() async {
    final response = await isConnected();
    if (response) {
      value = AddDataEvent<CreateEventState>();
      _useCases.add(path: 'event', data: EventAdapter.toMap(fillEventEntity()));
      value = DataAddedState<CreateEventState>();
    } else{
      value = NoConnectionState<CreateEventState>();
    }
  }

  DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }



}

@immutable
abstract class CreateEventState {}

class LoadingImageState extends GenericState<CreateEventState> {}

class FetchedImageState extends GenericState<CreateEventState> {}

class ExceptionImageState extends GenericState<CreateEventState> {}

class UpdateFormFieldState extends GenericState<CreateEventState> {}
