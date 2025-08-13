import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../stores/create_event_store.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  late final CreateEventStore store;



  @override
  void initState() {
    super.initState();
    store = Modular.get<CreateEventStore>();
    Modular.get<AppGlobalKeys>().resetAuthAvatarKey();
    final now = DateTime.now();
    store.startDate = DateTime(now.year, now.month, now.day, 8, 0);
    store.endDate = DateTime(now.year, now.month, now.day, 18, 0);
  }

  String getFormattedDateTime(DateTime dateTime) {
    final formatter = DateFormat('EEE, d MMM yyyy', 'pt_BR');
    String formatted = formatter.format(dateTime);
    formatted = formatted.replaceAll('.', '');
    formatted = formatted.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
    return formatted;
  }

  get prefixLocationIcon => Container(
        margin: const EdgeInsets.only(left: 18, right: 10),
        child: Image.asset(
          AppIcons.linkIcon,
          width: 20,
          height: 13,
        ),
      );

  Future<void> _selectDateTime(
      {required DateTime selectedDate,
        required Function(DateTime) onDatePicked}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('pt', 'BR'),
    );

    if (pickedDate != null) {
      setState(() {
        onDatePicked(pickedDate);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: store,
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
                        BackAuthTopBarWidget(action: () => nativePop(context),
                        margin: EdgeInsets.only(top: 22, left: 0, right: 2, bottom: 24),),
                        Row(
                          children: [
                            Text(
                              "Novo evento",
                              style: AppFonts.defaultFont(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            bottom: 8,
                            top: 23,
                          ),
                          child: Row(children: [
                            Text(
                              "Imagem de capa*",
                              style: AppFonts.defaultFont(
                                  color: AppColors.grey8,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            ),
                          ]),
                        ),
                        Column(
                          children: [
                            ValueListenableBuilder(
                                valueListenable: store.isCoverImageValid,
                                builder: (_, value, ___) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.grey0,
                                      border: Border.all(
                                          color: value
                                              ? AppColors.grey0
                                              : Colors.red),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    width: context.sizeOf.width,
                                    height: 144,
                                    child: InkWell(
                                      onTap: () async => await store.getImage(),
                                      child: state is FetchedImageState ||
                                              (state is UpdateFormFieldState &&
                                                  store.coverImage.path
                                                      .isNotEmpty)
                                          ? Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: FileImage(
                                                    store.coverImage,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Column(
                                              children: [
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 41.33,
                                                            bottom: 13.33),
                                                    child: state
                                                            is LoadingImageState
                                                        ? Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        6),
                                                            child: LoadingWidget(
                                                                size: Platform
                                                                        .isIOS
                                                                    ? 10
                                                                    : 22))
                                                        : Image.asset(
                                                            color: value
                                                                ? AppColors
                                                                    .darkGreen
                                                                : Colors.red,
                                                            AppIcons
                                                                .folderUpload,
                                                            width: 26.67,
                                                            height: 21.33,
                                                          )),
                                                Text(
                                                  'Suba um arquivo PNG ou JPG com dimensões de até 343x144 e 4MB',
                                                  textAlign: TextAlign.center,
                                                  style: AppFonts.defaultFont(
                                                      fontSize: 13,
                                                      color: AppColors.grey6),
                                                )
                                              ],
                                            ),
                                    ),
                                  );
                                }),
                            ValueListenableBuilder(
                                valueListenable: store.isCoverImageValid,
                                builder: (_, value, ___) {
                                  return Visibility(
                                    visible: !value,
                                    child: Text("Por favor, insira a imagem",
                                        style: TextStyle(color: Colors.red)),
                                  );
                                }),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: TemplateFormWidget(
                            horizontalSymmetric: EdgeInsets.zero,
                            valueListenable: store.isEventTitleValid,
                            titleMargin: const EdgeInsets.only(bottom: 4),
                            controller: store.eventTitleController,
                            title: 'Título do evento',
                            isValid: store.isEventTitleValid.value,
                            errorText: store.eventTitleErrorText,
                            globalKey: store.eventTitleKey,
                            isPressed: store.isPressed,
                            inputDecoration: fieldInputDecoration(
                              isValid: store.isEventTitleValid.value,
                              hintText: 'Título do seu evento',
                            ),
                            validator: (data) {
                              return store.formValidation(data, store.isEventTitleValid);
                            },
                            defaultHintColor: AppColors.hintInputForm,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: TemplateFormWidget(
                            horizontalSymmetric: EdgeInsets.zero,
                            valueListenable: store.isEventSubtitleValid,
                            titleMargin: const EdgeInsets.only(bottom: 4),
                            controller: store.eventSubtitleController,
                            title: 'Subtítulo do evento',
                            isValid: store.isEventSubtitleValid.value,
                            errorText: store.eventSubtitleErrorText,
                            globalKey: store.eventSubtitleKey,
                            isPressed: store.isPressed,
                            inputDecoration: fieldInputDecoration(
                              isValid: store.isEventSubtitleValid.value,
                              hintText: 'Subtítulo do seu evento',
                            ),
                            validator: (data) {
                              return store.formValidation(data, store.isEventSubtitleValid);
                            },
                            defaultHintColor: AppColors.hintInputForm,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16, bottom: 24),
                          child: TemplateFormWidget(
                            horizontalSymmetric: EdgeInsets.zero,
                            valueListenable: store.isEventDescriptionValid,
                            titleMargin: const EdgeInsets.only(bottom: 4),
                            controller: store.eventDescriptionController,
                            title: 'Descrição',
                            maxLines: 4,
                            fieldHeight: 110,
                            isValid: store.isEventDescriptionValid.value,
                            errorText: store.eventDescriptionErrorText,
                            globalKey: store.eventDescriptionKey,
                            isPressed: store.isPressed,
                            inputDecoration: fieldInputDecoration(
                              hintColor: store.isEventDescriptionValid
                                      .value // store.isEventDescriptionValid
                                  ? AppColors.grey5
                                  : Colors.red,
                              contentPadding: const EdgeInsets.only(
                                left: 16,
                                top: 9,
                                right: 10,
                              ),
                              isValid: true,
                              // store.isEventDescriptionValid,
                              hintText: 'Descrição do evento',
                            ),
                            validator: (data) {
                              return store.formValidation(data, store.isEventDescriptionValid);
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        AppIcons.watchIcon,
                                        height: 22,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 8),
                                        child: Text(
                                          "O dia todo",
                                          style: AppFonts.defaultFont(
                                            fontSize: 13,
                                            color: AppColors.grey8,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SwitchButtonWidget(
                                    value: store.isSwitchOn,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        store.isSwitchOn = newValue;
                                      });
                                    },
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: 8, bottom: 18, top: 16),
                                        child: Text(
                                          "De",
                                          style: AppFonts.defaultFont(
                                            fontSize: 13,
                                            color: AppColors.grey8,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => _selectDateTime(
                                            selectedDate: store.startDate,
                                            onDatePicked: (newDate) =>
                                            store.startDate = newDate),
                                        child: Text(
                                          getFormattedDateTime(store.startDate),
                                          style: AppFonts.defaultFont(
                                            fontSize: 15,
                                            color: AppColors.darkGreen,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Visibility(
                                    visible: !store.isSwitchOn,
                                    child: InkWell(
                                      onTap: () => store.pickTime(
                                        selectedTime: store.startTime,
                                         context: context,
                                        onTimePicked: (newTime) {
                                          setState(() {
                                            store.startTime = newTime;
                                          });
                                        },
                                      ),
                                      child: Text(
                                        store.formatTime(store.startTime),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        onTap: () => _selectDateTime(
                                            selectedDate: store.endDate,
                                            onDatePicked: (newDate) =>
                                            store.endDate = newDate),
                                        child: Text(
                                          getFormattedDateTime(store.endDate),
                                          style: AppFonts.defaultFont(
                                            color: AppColors.darkGreen,
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: !store.isSwitchOn,
                                    child: InkWell(
                                      onTap: () => store.pickTime(
                                        selectedTime: store.endTime,
                                        context: context,
                                        onTimePicked: (newTime) {
                                          setState(() {
                                            store.endTime = newTime;
                                          });
                                        },
                                      ),
                                      child: Text(
                                        store.formatTime(store.endTime),
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
                            valueListenable: store.isEventLocationValid,
                            titleMargin: const EdgeInsets.only(bottom: 4),
                            controller: store.eventLocationController,
                            title: 'Localização do google maps',
                            maxLines: 4,
                            isValid: store.isEventLocationValid.value,
                            errorText: store.eventLocationErrorText,
                            globalKey: store.eventLocationKey,
                            isPressed: store.isPressed,
                            inputDecoration: fieldInputDecoration(
                              prefixIconConstraints: const BoxConstraints(),
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 8),
                                child: Image.asset(
                                  AppIcons.eventLocation,
                                  height: 22,
                                ),
                              ),
                              contentPadding: const EdgeInsets.only(
                                top: 10,
                              ),
                              isValid: store.isEventLocationValid.value,
                              hintText: 'Selecione a localização',
                            ),
                            validator: (data) {
                              return store.formValidation(data, store.isEventLocationValid);
                            },
                            defaultHintColor: AppColors.hintInputForm,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: TemplateFormWidget(
                            horizontalSymmetric: EdgeInsets.zero,
                            valueListenable: store.isEventLocationNameValid,
                            titleMargin: const EdgeInsets.only(bottom: 4),
                            controller: store.eventLocationNameController,
                            maxLines: 4,
                            isValid: store.isEventLocationNameValid.value,
                            errorText: store.eventLocationNameErrorText,
                            globalKey: store.eventLocationNameKey,
                            isPressed: store.isPressed,
                            inputDecoration: fieldInputDecoration(
                              prefixIconConstraints: const BoxConstraints(),
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 8),
                                child: Image.asset(
                                  AppIcons.eventLocation,
                                  height: 22,
                                ),
                              ),
                              contentPadding: const EdgeInsets.only(
                                top: 10,
                              ),
                              isValid: store.isEventLocationNameValid.value,
                              hintText: 'Nome do local',
                            ),
                            validator: (data) {
                              return store.formValidation(data, store.isEventLocationNameValid);
                            },
                            defaultHintColor: AppColors.hintInputForm,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: TemplateFormWidget(
                            horizontalSymmetric: EdgeInsets.zero,
                            valueListenable: store.isEventLinkValid,
                            controller: store.eventLinkController,
                            title: 'Link para inscrição',
                            isValid: store.isEventLinkValid.value,
                            errorText: store.eventLinkErrorText,
                            globalKey: store.eventLinkKey,
                            isPressed: store.isPressed,
                            inputDecoration: fieldInputDecoration(
                              prefixIconConstraints: const BoxConstraints(),
                              prefixIcon: prefixLocationIcon,
                              isValid: store.isEventLinkValid.value,
                              hintText: 'Link do evento',
                            ),
                            validator: (data) {
                              return store.formValidation(data, store.isEventLinkValid);
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16, bottom: 32),
                          child: TemplateFormWidget(
                            horizontalSymmetric: EdgeInsets.zero,
                            valueListenable: store.isContactLinkValid,
                            controller: store.contactLinkController,
                            title: 'Link para contato',
                            isValid: store.isContactLinkValid.value,
                            errorText: store.contactLinkErrorText,
                            globalKey: store.contactLinkKey,
                            isPressed: store.isPressed,
                            inputDecoration: fieldInputDecoration(
                              prefixIconConstraints: const BoxConstraints(),
                              prefixIcon: prefixLocationIcon,
                              isValid: store.isContactLinkValid.value,
                              hintText: 'Link do contato',
                            ),
                            validator: (data) {
                              return store.formValidation(data, store.isContactLinkValid);
                            },
                          ),
                        ),
                        ButtonWidget(
                          action: () {

                            store.addData(context);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          fixedSize: Size(context.sizeOf.width, 48),
                          backgroundColor: AppColors.darkGreen,
                          shadowColor: AppColors.grey0,
                          foregroundColor: AppColors.white,
                          child: const Text(
                            "Salvar evento",
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16, bottom: 40),
                          child: ButtonWidget(
                            adaptiveButtonType: AdaptiveButtonType.text,
                            action: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            fixedSize: Size(context.sizeOf.width, 48),
                            overlayColor: Colors.white,
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.delete,
                            foregroundHoveredColor: AppColors.delete,
                            child: const Text(
                              "Deletar",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
