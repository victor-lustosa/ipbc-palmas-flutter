import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../../events_module.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  final TextEditingController _eventTitleController = TextEditingController();
  final TextEditingController _eventLocationController =
      TextEditingController();
  final TextEditingController _eventLinkController = TextEditingController();
  final TextEditingController _contactLinkController = TextEditingController();
  final TextEditingController _eventLinkDescriptionController =
      TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();
  final String _eventTitleErrorText = 'por favor, insira o título do evento.';
  final String _contactLinkErrorText = 'por favor, insira o título do evento.';
  final String _eventLocationErrorText =
      'por favor, insira o título do evento.';
  final String _eventDescriptionErrorText =
      'por favor, insira o título do evento.';
  final String _eventLinkErrorText = 'por favor, insira o link do evento.';
  final String _eventLinkDescriptionErrorText =
      'por favor, insira o link do evento.';
  final _eventTitleKey = GlobalKey<FormState>();
  final _contactLinkKey = GlobalKey<FormState>();
  final _eventLinkKey = GlobalKey<FormState>();
  final _eventLinkDescriptionKey = GlobalKey<FormState>();
  final _eventLocationKey = GlobalKey<FormState>();
  final _eventDescriptionKey = GlobalKey<FormState>();
  bool isEventTitleValid = true;
  bool isContactLinkValid = true;
  bool isEventLocationValid = true;
  bool isEventDescriptionValid = true;
  bool isEventLinkValid = true;
  bool isEventLinkDescriptionValid = true;
  bool isPressed = false;

  _emailValidation(String? data) {
    return null;
  }

  get prefixLocationIcon => Container(
        margin: const EdgeInsets.only(left: 18, right: 10),
        child: Image.asset(
          AppIcons.linkIcon,
          width: 20,
          height: 13,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: context.sizeOf.width,
          height: context.sizeOf.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                MainTopBarWidget(
                  topBarList: [
                    BackButtonWidget(action: () => nativePop(context)),
                    AuthCircleAvatarWidget()
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 16, right: 17),
                      child: BackButtonWidget(
                        action: () => nativePop(context),
                      ),
                    ),
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
                    left: 16,
                  ),
                  child: Row(children: [
                    Text(
                      "Imagem de capa",
                      style: AppFonts.defaultFont(
                          color: AppColors.grey8,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                  ]),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.grey0,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  width: context.sizeOf.width,
                  height: 144,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      Container(
                          margin:
                              const EdgeInsets.only(top: 41.33, bottom: 13.33),
                          child: Image.asset(
                            AppIcons.folderUpload,
                            width: 26.67,
                            height: 21.33,
                          )),
                      Text(
                        'Suba um arquivo PNG ou JPG com dimensões de até 343x144 e 4MB',
                        textAlign: TextAlign.center,
                        style: AppFonts.defaultFont(
                            fontSize: 13, color: AppColors.grey6),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: TemplateFormWidget(
                    titleMargin: const EdgeInsets.only(bottom: 4),
                    controller: _eventTitleController,
                    title: 'Título do evento',
                    isValid: isEventTitleValid,
                    errorText: _eventTitleErrorText,
                    globalKey: _eventTitleKey,
                    isPressed: isPressed,
                    inputDecoration: fieldInputDecoration(
                      isValid: isEventTitleValid,
                      hintText: 'Título do seu evento',
                    ),
                    validator: (data) {
                      return _emailValidation(data);
                    },
                    defaultHintColor: AppColors.hintInputForm,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: TemplateFormWidget(
                    titleMargin: const EdgeInsets.only(bottom: 4),
                    controller: _eventDescriptionController,
                    title: 'Descrição',
                    maxLines: 4,
                    fieldHeight: 110,
                    isValid: isEventDescriptionValid,
                    errorText: _eventDescriptionErrorText,
                    globalKey: _eventDescriptionKey,
                    isPressed: isPressed,
                    inputDecoration: fieldInputDecoration(
                      hintColor: isEventDescriptionValid
                          ? AppColors.grey5
                          : Colors.red,
                      contentPadding: const EdgeInsets.only(
                        left: 16,
                        top: 9,
                        right: 10,
                      ),
                      isValid: isEventDescriptionValid,
                      hintText: 'Descrição do evento',
                    ),
                    validator: (data) {
                      return _emailValidation(data);
                    },
                    defaultHintColor: AppColors.hintInputForm,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: TemplateFormWidget(
                    titleMargin: const EdgeInsets.only(bottom: 4),
                    controller: _eventLocationController,
                    title: 'Localização',
                    maxLines: 4,
                    isValid: isEventLocationValid,
                    errorText: _eventLocationErrorText,
                    globalKey: _eventLocationKey,
                    isPressed: isPressed,
                    inputDecoration: fieldInputDecoration(
                      prefixIconConstraints: const BoxConstraints(),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        child: Image.asset(
                          AppIcons.eventLocation,
                          height: 22,
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(
                        top: 10,
                      ),
                      isValid: isEventLocationValid,
                      hintText: 'Selecione a localização',
                    ),
                    validator: (data) {
                      return _emailValidation(data);
                    },
                    defaultHintColor: AppColors.hintInputForm,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: TemplateFormWidget(
                    controller: _eventLinkController,
                    title: 'Link',
                    isValid: isEventLinkValid,
                    errorText: _eventLinkErrorText,
                    globalKey: _eventLinkKey,
                    isPressed: isPressed,
                    inputDecoration: fieldInputDecoration(
                      prefixIconConstraints: const BoxConstraints(),
                      prefixIcon: prefixLocationIcon,
                      isValid: isEventLocationValid,
                      hintText: 'Link do evento',
                    ),
                    validator: (data) {
                      return _emailValidation(data);
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TemplateFormWidget(
                    controller: _eventLinkDescriptionController,
                    isValid: isEventLinkDescriptionValid,
                    errorText: _eventLinkDescriptionErrorText,
                    globalKey: _eventLinkDescriptionKey,
                    isPressed: isPressed,
                    inputDecoration: fieldInputDecoration(
                      isValid: isEventLinkDescriptionValid,
                      hintText: 'Descrição do link',
                    ),
                    validator: (data) {
                      return _emailValidation(data);
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16, bottom: 60),
                  child: TemplateFormWidget(
                    controller: _contactLinkController,
                    title: 'Link para contato',
                    isValid: isContactLinkValid,
                    errorText: _contactLinkErrorText,
                    globalKey: _contactLinkKey,
                    isPressed: isPressed,
                    inputDecoration: fieldInputDecoration(
                      prefixIconConstraints: const BoxConstraints(),
                      prefixIcon: prefixLocationIcon,
                      isValid: isContactLinkValid,
                      hintText: 'Link do contato',
                    ),
                    validator: (data) {
                      return _emailValidation(data);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingButtonWidget(
        icon: Icons.check_rounded,
        backgroundColor: AppColors.confirmation,
        iconColor: AppColors.grey10,
        size: 33,
        action: () => navigate(
          EventModule.eventRoute + EventModule.detailEventRoute,
        ),
      ),
    );
  }
}
