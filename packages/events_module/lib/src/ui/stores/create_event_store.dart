import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class CreateEventStore extends ValueNotifier<GenericState<CreateEventState>>
    with ImageMixin, ConnectivityMixin {
  bool isSwitchOn = false;

  final IUseCases _useCases;
  final String eventPath = 'event';

  CreateEventStore({required IUseCases useCases})
    : _useCases = useCases,
      super(InitialState<CreateEventState>()) {
    controllerValidators = {
      eventTitleController: isEventTitleValid,
      eventSubtitleController: isEventSubtitleValid,
      contactLinkController: isContactLinkValid,
      eventLocationController: isEventLocationValid,
      eventLocationNameController: isEventLocationNameValid,
      eventLinkController: isEventLinkValid,
      eventDescriptionController: isEventDescriptionValid,
    };
  }

  late final Map<TextEditingController, ValueNotifier<bool>>
  controllerValidators;
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
  final String eventSubtitleErrorText =
      'por favor, insira o subtítulo do evento.';
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
  Future<void> pickTime({
    required TimeOfDay selectedTime,
    required Function(TimeOfDay) onTimePicked,
    required BuildContext context,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      onTimePicked(picked);
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

  bool validateAllFields() {
    bool allTextValid = true;
    controllerValidators.forEach((controller, isValid) {
      if (controller.text.trim().isEmpty) {
        formValidation(controller.text, isValid);
        allTextValid = false;
      }
    });
    final imageValid = coverImage.path.trim().isNotEmpty;
    changeValue(isCoverImageValid, imageValid);

    return allTextValid && imageValid;
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

  EventEntity fillEventEntity(String resultUrl) {
    EventEntity entity = EventEntity(
      id: createId(),
      title: eventTitleController.text,
      subtitle: eventSubtitleController.text,
      image: resultUrl,
      startDateTime: combineDateAndTime(startDate, startTime),
      endDateTime: combineDateAndTime(endDate, endTime),
      description: eventDescriptionController.text,
      location: eventLocationController.text,
      localName: eventLocationNameController.text,
      signUpLink: eventLinkController.text,
      contactLink: contactLinkController.text,
      createAt: DateTime.now(),
    );
    return entity;
  }

  static String createId() => DateTime.now().microsecondsSinceEpoch.toString();

  Future<void> addData(BuildContext context) async {
    if (validateAllFields()) {
      final response = await isConnected();
      if (response) {
        value = AddDataEvent<CreateEventState>();
        final resultUrl = await _useCases.saveImage(
          coverImage: coverImage,
          eventTitle: eventTitleController.text,
        );
        if (resultUrl != null) {
          _useCases.add(
            path: 'event',
            data: EventAdapter.toMap(fillEventEntity(resultUrl)),
          );
          showCustomSuccessDialog(
            context: context,
            title: 'Sucesso!',
            message: 'Evento salvo',
          );
        }
        value = DataAddedState<CreateEventState>();
      } else {
        value = NoConnectionState<CreateEventState>();
      }
    }
  }

  DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}

@immutable
abstract class CreateEventState {}

class LoadingImageState extends GenericState<CreateEventState> {}

class FetchedImageState extends GenericState<CreateEventState> {}

class ExceptionImageState extends GenericState<CreateEventState> {}

class UpdateFormFieldState extends GenericState<CreateEventState> {}
