import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> with DateMixin {
  late final CreateEventStore _store;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    _store = Modular.get<CreateEventStore>();
      _store.init();

  }
  @override
  dispose() {
    _store.resetValidationFields();
    super.dispose();
  }


  get prefixLocationIcon => Container(
    margin: const EdgeInsets.only(left: 18, right: 10),
    child: Image.asset(AppIcons.linkIcon, width: 20, height: 13),
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _store,
      builder: (_, state, child) {
        return Scaffold(
          body: SafeArea(
            child: SizedBox(
              width: context.sizeOf.width,
              height: context.sizeOf.height,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      BackAuthTopBarWidget(
                        action: () => nativePop(context),
                        margin: EdgeInsets.only(
                          top: 22,
                          left: 0,
                          right: 2,
                          bottom: 24,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${_store.isEditing ? "Editar" : "Novo"} evento',
                            style: AppFonts.defaultFont(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 8, top: 23),
                        child: Row(
                          children: [
                            Text(
                              "Imagem de capa*",
                              style: AppFonts.defaultFont(
                                color: AppColors.grey8,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: _store.isCoverImageValid,
                            builder: (_, value, ___) {
                              return AspectRatio(
                                aspectRatio: 343 / 144,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.grey0,
                                    border: Border.all(
                                      color: value ? AppColors.grey0 : Colors.red,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () async => await _store.getImage(),
                                    child:
                                        state is FetchedImageState ||
                                            (state is UpdateFormFieldState &&
                                                _store.coverImage.path.isNotEmpty)
                                        ? Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(
                                                  _store.coverImage,
                                                ),
                                              ),
                                            ),
                                          )
                                        : _store.isEditing
                                        ? Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  _store.eventEntity.image,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  bottom: 13.33,
                                                ),
                                                child: state is LoadingImageState
                                                    ? Container(
                                                        margin:
                                                            const EdgeInsets.symmetric(
                                                              vertical: 6,
                                                            ),
                                                        child: LoadingWidget(
                                                          size: Platform.isIOS
                                                              ? 10
                                                              : 22,
                                                        ),
                                                      )
                                                    : Image.asset(
                                                        color: value
                                                            ? AppColors.darkGreen
                                                            : Colors.red,
                                                        AppIcons.folderUpload,
                                                        width: 26.67,
                                                        height: 21.33,
                                                      ),
                                              ),
                                              Text(
                                                'Suba um arquivo PNG ou JPG com dimensões de até 343x144 e 4MB',
                                                textAlign: TextAlign.center,
                                                style: AppFonts.defaultFont(
                                                  fontSize: 13,
                                                  color: AppColors.grey6,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: _store.isCoverImageValid,
                            builder: (_, value, ___) {
                              return Visibility(
                                visible: !value,
                                child: Text(
                                  "Por favor, insira a imagem",
                                  style: TextStyle(color: Colors.red),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: TemplateFormWidget(
                          horizontalSymmetric: EdgeInsets.zero,
                          valueListenable: _store.isEventTitleValid,
                          titleMargin: const EdgeInsets.only(bottom: 4),
                          controller: _store.eventTitleController,
                          title: 'Título do evento',
                          isValid: _store.isEventTitleValid.value,
                          errorText: _store.eventTitleErrorText,
                          globalKey: _store.eventTitleKey,
                          isPressed: _store.isPressed,
                          inputDecoration: fieldInputDecoration(
                            isValid: _store.isEventTitleValid.value,
                            hintText: 'Título do seu evento',
                          ),
                          validator: (data) {
                            return _store.formValidation(
                              data,
                              _store.isEventTitleValid,
                            );
                          },
                          defaultHintColor: AppColors.hintInputForm,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: TemplateFormWidget(
                          horizontalSymmetric: EdgeInsets.zero,
                          valueListenable: _store.isEventSubtitleValid,
                          titleMargin: const EdgeInsets.only(bottom: 4),
                          controller: _store.eventSubtitleController,
                          title: 'Subtítulo do evento',
                          isValid: _store.isEventSubtitleValid.value,
                          errorText: _store.eventSubtitleErrorText,
                          globalKey: _store.eventSubtitleKey,
                          isPressed: _store.isPressed,
                          inputDecoration: fieldInputDecoration(
                            isValid: _store.isEventSubtitleValid.value,
                            hintText: 'Subtítulo do seu evento',
                          ),
                          validator: (data) {
                            return _store.formValidation(
                              data,
                              _store.isEventSubtitleValid,
                            );
                          },
                          defaultHintColor: AppColors.hintInputForm,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16, bottom: 24),
                        child: TemplateFormWidget(
                          horizontalSymmetric: EdgeInsets.zero,
                          valueListenable: _store.isEventDescriptionValid,
                          titleMargin: const EdgeInsets.only(bottom: 4),
                          controller: _store.eventDescriptionController,
                          title: 'Descrição',
                          maxLines: 4,
                          fieldHeight: 110,
                          isValid: _store.isEventDescriptionValid.value,
                          errorText: _store.eventDescriptionErrorText,
                          globalKey: _store.eventDescriptionKey,
                          isPressed: _store.isAddEventPressed,
                          inputDecoration: fieldInputDecoration(
                            hintColor: _store.isEventDescriptionValid.value
                                ? AppColors.grey5
                                : Colors.red,
                            contentPadding: const EdgeInsets.only(
                              left: 16,
                              top: 9,
                              right: 10,
                            ),
                            isValid: true,
                            // _store.isEventDescriptionValid,
                            hintText: 'Descrição do evento',
                          ),
                          validator: (data) {
                            return _store.formValidation(
                              data,
                              _store.isEventDescriptionValid,
                            );
                          },
                          defaultHintColor: AppColors.hintInputForm,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        width: context.sizeOf.width,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(AppIcons.watchIcon, height: 22),
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      child: Text(
                                        "O dia todo",
                                        style: AppFonts.defaultFont(
                                          fontSize: 13,
                                          color: AppColors.grey8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SwitchButtonWidget(
                                  value: _store.isSwitchOn,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      _store.isSwitchOn = newValue;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: 8,
                                        bottom: 18,
                                        top: 16,
                                      ),
                                      child: Text(
                                        "De",
                                        style: AppFonts.defaultFont(
                                          fontSize: 13,
                                          color: AppColors.grey8,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => setDateTime(
                                        selectedDate: _store.startDate!,
                                        onDatePicked: (newDate) {
                                          setState(() {
                                            _store.startDate = newDate;
                                          });
                                        },
                                        context: context,
                                      ),
                                      child: Text(
                                        getFormattedDateTime(_store.startDate!),
                                        style: AppFonts.defaultFont(
                                          fontSize: 15,
                                          color: AppColors.darkGreen,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: ((!_store.isSwitchOn)),
                                  child: InkWell(
                                    onTap: () => _store.pickTime(
                                      selectedTime: _store.startTime!,
                                      context: context,
                                      onTimePicked: (newTime) {
                                        setState(() {
                                          _store.startTime = newTime;
                                        });
                                      },
                                    ),
                                    child: Text(
                                      _store.formatHourToString(
                                        time: _store.startTime,
                                      ),
                                      style: AppFonts.defaultFont(
                                        fontSize: 15,
                                        color: AppColors.darkGreen,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 8),
                                      child: Text(
                                        "Até",
                                        style: AppFonts.defaultFont(
                                          fontSize: 13,
                                          color: AppColors.grey8,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => setDateTime(
                                        selectedDate: _store.endDate!,
                                        onDatePicked: (newDate) {
                                          setState(() {
                                            _store.endDate = newDate;
                                          });
                                        },
                                        context: context,
                                      ),
                                      child: Text(
                                        getFormattedDateTime(_store.endDate!),
                                        style: AppFonts.defaultFont(
                                          color: AppColors.darkGreen,
                                          fontSize: 15,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Visibility(
                                  visible: ((!_store.isSwitchOn)),
                                  child: InkWell(
                                    onTap: () => _store.pickTime(
                                      selectedTime: _store.endTime!,
                                      context: context,
                                      onTimePicked: (newTime) {
                                        setState(() {
                                          _store.endTime = newTime;
                                        });
                                      },
                                    ),
                                    child: Text(
                                      _store.formatHourToString(
                                        time: _store.endTime,
                                      ),
                                      style: AppFonts.defaultFont(
                                        fontSize: 15,
                                        color: AppColors.darkGreen,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 24),
                        child: TemplateFormWidget(
                          horizontalSymmetric: EdgeInsets.zero,
                          valueListenable: _store.isEventLocationValid,
                          titleMargin: const EdgeInsets.only(bottom: 4),
                          controller: _store.eventLocationController,
                          title: 'Localização do google maps',
                          maxLines: 4,
                          isValid: _store.isEventLocationValid.value,
                          errorText: _store.eventLocationErrorText,
                          globalKey: _store.eventLocationKey,
                          isPressed: _store.isAddEventPressed,
                          inputDecoration: fieldInputDecoration(
                            prefixIconConstraints: const BoxConstraints(),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 8,
                              ),
                              child: Image.asset(
                                AppIcons.eventLocation,
                                height: 22,
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(top: 10),
                            isValid: _store.isEventLocationValid.value,
                            hintText: 'Selecione a localização',
                          ),
                          validator: (data) {
                            return _store.locationValidation(
                              data,
                              _store.isEventLocationValid,
                            );
                          },
                          defaultHintColor: AppColors.hintInputForm,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: TemplateFormWidget(
                          horizontalSymmetric: EdgeInsets.zero,
                          valueListenable: _store.isEventLocationNameValid,
                          titleMargin: const EdgeInsets.only(bottom: 4),
                          controller: _store.eventLocationNameController,
                          maxLines: 4,
                          isValid: _store.isEventLocationNameValid.value,
                          errorText: _store.eventLocationNameErrorText,
                          globalKey: _store.eventLocationNameKey,
                          isPressed: _store.isAddEventPressed,
                          inputDecoration: fieldInputDecoration(
                            prefixIconConstraints: const BoxConstraints(),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 8,
                              ),
                              child: Image.asset(
                                AppIcons.eventLocation,
                                height: 22,
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(top: 10),
                            isValid: _store.isEventLocationNameValid.value,
                            hintText: 'Nome do local',
                          ),
                          validator: (data) {
                            return _store.formValidation(
                              data,
                              _store.isEventLocationNameValid,
                            );
                          },
                          defaultHintColor: AppColors.hintInputForm,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: TemplateFormWidget(
                          horizontalSymmetric: EdgeInsets.zero,
                          valueListenable: _store.isEventLinkValid,
                          controller: _store.eventLinkController,
                          title: 'Link para inscrição',
                          isValid: _store.isEventLinkValid.value,
                          errorText: _store.eventLinkErrorText,
                          globalKey: _store.eventLinkKey,
                          isPressed: _store.isAddEventPressed,
                          inputDecoration: fieldInputDecoration(
                            prefixIconConstraints: const BoxConstraints(),
                            prefixIcon: prefixLocationIcon,
                            isValid: _store.isEventLinkValid.value,
                            hintText: 'Link do evento',
                          ),
                          validator: (_) => null,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16, bottom: 32),
                        child: TemplateFormWidget(
                          horizontalSymmetric: EdgeInsets.zero,
                          valueListenable: _store.isContactLinkValid,
                          controller: _store.contactLinkController,
                          title: 'Link para contato',
                          isValid: _store.isContactLinkValid.value,
                          errorText: _store.contactLinkErrorText,
                          globalKey: _store.contactLinkKey,
                          isPressed: _store.isAddEventPressed,
                          inputDecoration: fieldInputDecoration(
                            prefixIconConstraints: const BoxConstraints(),
                            prefixIcon: prefixLocationIcon,
                            isValid: _store.isContactLinkValid.value,
                            hintText: 'Link do contato',
                          ),
                          validator: (_) => null,
                        ),
                      ),
                      LoadingButtonWidget(
                        margin: EdgeInsets.zero,
                          isPressed: _store.isAddEventPressed,
                        action: () async {
                          _store.addData(context);
                        },
                        label: "Salvar evento",
                        isValid: _store.isAllFieldsValid,
                      ),
                      Visibility(
                        visible: _store.isEditing,
                        child: Container(
                          margin: EdgeInsets.only(top: 16, bottom: 10),
                          child: ButtonWidget(
                            adaptiveButtonType: AdaptiveButtonType.text,
                            action: () async {
                              await _store.delete(_store.eventEntity);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            fixedSize: Size(context.sizeOf.width, 48),
                            overlayColor: Colors.white,
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.delete,
                            foregroundHoveredColor: AppColors.delete,
                            child: const Text("Deletar"),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
