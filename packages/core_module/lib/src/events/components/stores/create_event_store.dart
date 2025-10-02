import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:core_module/src/events/infra/use_cases/event_use_cases.dart';
import 'package:flutter/material.dart';

class CreateEventStore extends ValueNotifier<GenericState<CreateEventState>>
    with ImageMixin, ConnectivityMixin, DateMixin, ValidationAndFormatMixin {
  bool isSwitchOn = false;
  bool isEditing = false;
  bool isChangedOrAdded = false;
  Function? updateEventListViewCallback;
  Function? updateCallbackParam;
  Function? updateHomeViewCallback;
  final IUseCases _useCases;
  final IEventUseCases _eventUseCases;
  final String eventPath = 'event';
  String fromCalled = '';

  CreateEventStore({
    required IUseCases useCases,
    required IEventUseCases eventUseCases,
  }) : _eventUseCases = eventUseCases,
       _useCases = useCases,
       super(InitialState<CreateEventState>()) {
    controllerValidators = {
      eventTitleController: isEventTitleValid,
      eventSubtitleController: isEventSubtitleValid,
      eventLocationController: isEventLocationValid,
      eventLocationNameController: isEventLocationNameValid,
      eventDescriptionController: isEventDescriptionValid,
    };
    initDate();
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
      'por favor, insira um link de localização válido.';
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
  ValueNotifier<bool> isPressed = ValueNotifier(false);
  ValueNotifier<bool> isAddEventPressed = ValueNotifier(false);
  ValueNotifier<bool> isFormValid = ValueNotifier(true);

  get isAllFieldsValid =>
      isEventTitleValid.value &&
      isEventSubtitleValid.value &&
      isEventLocationValid.value &&
      isEventLocationNameValid.value &&
      isEventDescriptionValid.value &&
      isEventLinkValid.value &&
      isEventLinkDescriptionValid.value &&
      isContactLinkValid.value &&
      isCoverImageValid.value;


  File coverImage = File('');
  late EventEntity eventEntity;

  void init() {
    if (isEditing) {
      fillFormWithEvent(eventEntity);
    } else {
      eventTitleController.clear();
      eventSubtitleController.clear();
      coverImage = File('');
      final now = DateTime.now();
      startDate = DateTime(now.year, now.month, now.day, 08, 0);
      endDate = DateTime(now.year, now.month, now.day, 18, 0);
      startTime = TimeOfDay(hour: 08, minute: 00);
      endTime = TimeOfDay(hour: 18, minute: 30);
      eventDescriptionController.clear();
      eventLocationController.clear();
      eventLocationNameController.clear();
      eventLinkController.clear();
      contactLinkController.clear();
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

  changeValue(ValueNotifier<bool> valueNotifier, bool newValue) {
    Future.delayed(Duration.zero, () async {
      valueNotifier.value = newValue;
      value = UpdateFormFieldState();
    });
  }

  locationValidation(String? data, ValueNotifier<bool> isValid) {
    if (!isLocationLinkValid(data)) {
      changeValue(isValid, false);
      return null;
    } else {
      changeValue(isValid, true);
      return null;
    }
  }

  bool isLocationLinkValid(String? data) {
    return (isEmptyData(data) || (isValidGoogleMapsLink(data!)));
  }

  fillFormWithEvent(EventEntity event) {
    eventEntity = event;
    eventTitleController.text = event.title;
    eventSubtitleController.text = event.subtitle;
    coverImage = File('');
    startDate = event.startDateTime;
    endDate = event.endDateTime;
    startTime = TimeOfDay(
      hour: event.startDateTime.hour,
      minute: event.startDateTime.minute,
    );
    endTime = TimeOfDay(
      hour: event.endDateTime.hour,
      minute: event.endDateTime.minute,
    );
    eventDescriptionController.text = event.description;
    eventLocationController.text = event.location ?? '';
    eventLocationNameController.text = event.localName!;
    eventLinkController.text = event.signUpLink ?? '';
    contactLinkController.text = event.contactLink ?? '';
    isSwitchOn = event.isAllDay;
  }

  Future<bool> validateDateTime(BuildContext context) async {
    if (startDate!.isAfter(endDate!)) {
      if (context.mounted) {
        await showCustomMessageDialog(
          type: DialogType.error,
          context: context,
          title: 'Data inválida',
          message: 'A data final não pode ser anterior à data inicial.',
        );
      }
      return false;
    }
    if (!isSwitchOn &&
        startDate!.year == endDate!.year &&
        startDate!.month == endDate!.month &&
        startDate!.day == endDate!.day) {

      final startMinutes = startTime!.hour * 60 + startTime!.minute;
      final endMinutes = endTime!.hour * 60 + endTime!.minute;
      if (startMinutes >= endMinutes) {
        if (context.mounted) {
          await showCustomMessageDialog(
            type: DialogType.error,
            context: context,
            title: 'Hora inválida',
            message: 'A hora final deve ser posterior à hora inicial.',
          );
        }
        return false;
      }
    }
    return true;
  }

  Future<bool> validateAllFields(BuildContext context) async {
    bool allTextValid = true;
    controllerValidators.forEach((controller, isValid) {
      if (controller.text.trim().isEmpty) {
        formValidation(controller.text, isValid);
        allTextValid = false;
      }
    });

    if (!isLocationLinkValid(eventLocationController.text)) {
      changeValue(isEventLocationValid, false);
      allTextValid = false;
    }
    if (await validateDateTime(context) == false) {
      allTextValid = false;
    }

    final imageValid = isEditing ? true : coverImage.path.trim().isNotEmpty;
    changeValue(isCoverImageValid, imageValid);

    changeValue(isFormValid, allTextValid && imageValid);
    return allTextValid && imageValid;
  }

  bool isEmptyData(String? data) {
    return (data == null || data.isEmpty);
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

  EventEntity fillEventEntity(String resultUrl, Map<String, double>? latLong) {
    EventEntity entity = EventEntity(
      id: isEditing ? eventEntity.id : null,
      title: eventTitleController.text,
      subtitle: eventSubtitleController.text,
      image: resultUrl,
      startDateTime: combineDateAndTime(startDate!, startTime!),
      endDateTime: combineDateAndTime(endDate!, endTime!),
      description: eventDescriptionController.text,
      isAllDay: isSwitchOn,
      location: eventLocationController.text,
      localName: eventLocationNameController.text,
      signUpLink: eventLinkController.text.isEmpty
          ? null
          : eventLinkController.text,
      contactLink: contactLinkController.text.isEmpty
          ? null
          : contactLinkController.text,
      createAt: isEditing ? eventEntity.createAt : DateTime.now(),
      latitude: latLong?['lat'],
      longitude: latLong?['lng'],
    );
    eventEntity = entity;
    return entity;
  }

  bool isValidGoogleMapsLink(String url) {
    final regex = RegExp(r'^https:\/\/maps\.app\.goo\.gl\/[A-Za-z0-9]+$');
    return regex.hasMatch(url);
  }

  Future<bool> addData(BuildContext context) async {
    isAddEventPressed.value = true;
    if (await validateAllFields(context)) {
      final response = await isConnected();
      if (response) {
        Map<String, double>? latLong;
        if (eventLocationController.text.isNotEmpty &&
            isValidGoogleMapsLink(eventLocationController.text)) {
          latLong = await _eventUseCases.getLocationFromUrl(
            url: eventLocationController.text,
          );

          if (latLong == null &&
              eventLocationController.text.isNotEmpty &&
              context.mounted) {
            await showCustomMessageDialog(
              type: DialogType.error,
              context: context,
              title: 'Erro',
              message:
                  'Não foi possível extrair a localização do link fornecido. Por favor, verifique o link e tente novamente.',
            );
            return Future.value(false);
          }
        }
        value = AddDataEvent<CreateEventState>();
        String? resultUrl;
        bool isImageUpdated = (isEditing && coverImage.path.isNotEmpty);
        if (isImageUpdated || !isEditing) {
          resultUrl = await _useCases.saveImage(
            coverImage: coverImage,
            bucketName: 'covers',
            fileName:
                'mobile_event_covers/${formatText(eventTitleController.text)}_${DateTime.now().toIso8601String()}.jpg',
          );
        }

        if (resultUrl != null || !isImageUpdated) {
          await _useCases.upsert(
            data: EventAdapter.toMap(
              fillEventEntity(
                isEditing ? eventEntity.image : resultUrl!,
                latLong,
              ),
            ),
            params: {'table': 'event'},
          );
          if (context.mounted) {
            isChangedOrAdded = true;
            await showCustomMessageDialog(
              type: DialogType.success,
              context: context,
              title: 'Sucesso!',
              message: 'Evento salvo',
            );
          }
          if (updateCallbackParam != null && context.mounted) {
            updateCallbackParam!();
          }
          value = DataAddedState<CreateEventState>();
          isAddEventPressed.value = false;
          return Future.value(true);
        }
      } else {
        value = NoConnectionState<CreateEventState>();
        isAddEventPressed.value = false;
        return Future.value(false);
      }
    }
    isAddEventPressed.value = false;
    return Future.value(false);
  }

  Future<dynamic> delete(EventEntity entity) async {
    final response = await _useCases.delete(
      params: {
        'table': 'event',
        'referenceField': 'id',
        'referenceValue': entity.id,
        'selectFields': 'id',
      },
    );
    isChangedOrAdded = true;
    notifyListeners();
    return Future.value(response[0]);
  }



  resetValidationFields() {
    isFormValid.value = true;
    isEventTitleValid.value = true;
    isEventSubtitleValid.value = true;
    isEventLocationValid.value = true;
    isEventLocationNameValid.value = true;
    isEventDescriptionValid.value = true;
    isEventLinkValid.value = true;
    isEventLinkDescriptionValid.value = true;
    isContactLinkValid.value = true;
    isCoverImageValid.value = true;

  }
}

@immutable
abstract class CreateEventState {}

class LoadingImageState extends GenericState<CreateEventState> {}

class FetchedImageState extends GenericState<CreateEventState> {}

class ExceptionImageState extends GenericState<CreateEventState> {}
