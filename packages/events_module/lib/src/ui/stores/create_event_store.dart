import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:core_module/core_module.dart';

class CreateEventStore extends ValueNotifier<GenericState<CreateEventState>>
    with ImageMixin {
  CreateEventStore() : super(InitialState<CreateEventState>());

  final TextEditingController eventTitleController = TextEditingController();
  final TextEditingController eventLocationController = TextEditingController();
  final TextEditingController eventLinkController = TextEditingController();
  final TextEditingController contactLinkController = TextEditingController();
  final TextEditingController eventLinkDescriptionController =
      TextEditingController();
  final TextEditingController eventDescriptionController =
      TextEditingController();
  final String eventTitleErrorText = 'por favor, insira o título do evento.';
  final String contactLinkErrorText = 'por favor, insira o título do evento.';
  final String eventLocationErrorText = 'por favor, insira o título do evento.';
  final String eventDescriptionErrorText =
      'por favor, insira o título do evento.';
  final String eventLinkErrorText = 'por favor, insira o link do evento.';
  final String eventLinkDescriptionErrorText =
      'por favor, insira o link do evento.';
  final eventTitleKey = GlobalKey<FormState>();
  final contactLinkKey = GlobalKey<FormState>();
  final eventLinkKey = GlobalKey<FormState>();
  final eventLinkDescriptionKey = GlobalKey<FormState>();
  final eventLocationKey = GlobalKey<FormState>();
  final eventDescriptionKey = GlobalKey<FormState>();
  ValueNotifier<bool> isEventTitleValid = ValueNotifier(true);
  ValueNotifier<bool> isContactLinkValid = ValueNotifier(true);
  ValueNotifier<bool> isEventLocationValid = ValueNotifier(true);
  ValueNotifier<bool> isEventDescriptionValid = ValueNotifier(true);
  ValueNotifier<bool> isEventLinkValid = ValueNotifier(true);
  ValueNotifier<bool> isEventLinkDescriptionValid = ValueNotifier(true);
  ValueNotifier<bool> isCoverImageValid = ValueNotifier(true);
  bool isPressed = false;
  File coverImage = File('');

  titleValidation(String? data) {
    if (data == null || data.isEmpty) {
      changeValue(isEventTitleValid, false);
      return null;
    } else {
      changeValue(isEventTitleValid, true);
      return null;
    }
  }
  emailValidation(String? data) {
    return null;
  }

  changeValue(ValueNotifier<bool> valueNotifier, bool newValue ) {
    Future.delayed(Duration.zero, () async {
      valueNotifier.value = newValue;
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
}



@immutable
abstract class CreateEventState {}

class LoadingImageState extends GenericState<CreateEventState> {}

class FetchedImageState extends GenericState<CreateEventState> {}

class ExceptionImageState extends GenericState<CreateEventState> {}
