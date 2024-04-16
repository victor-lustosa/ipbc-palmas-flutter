import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  final TextEditingController _eventTitleController = TextEditingController();
  final TextEditingController _eventLocationController =
      TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();
  final String _eventTitleErrorText = 'por favor, insira o título do evento.';
  final String _eventLocationErrorText =
      'por favor, insira o título do evento.';
  final String _eventDescriptionErrorText =
      'por favor, insira o título do evento.';
  final _eventTitleKey = GlobalKey<FormState>();
  final _eventLocationKey = GlobalKey<FormState>();
  final _eventDescriptionKey = GlobalKey<FormState>();
  bool _isEventTitleValid = true;
  bool _isEventLocationValid = true;
  bool _isEventDescriptionValid = true;
  bool _isPressed = false;

  _emailValidation(String? data) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: context.mediaQuery.size.width,
          height: context.mediaQuery.size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const MainTopBarWidget(),
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: Row(
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
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8, top: 23, left: 16),
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
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  width: context.mediaQuery.size.width,
                  height: 144,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    isValid: _isEventTitleValid,
                    errorText: _eventTitleErrorText,
                    globalKey: _eventTitleKey,
                    isPressed: _isPressed,
                    inputDecoration: fieldInputDecoration(
                      isValid: _isEventTitleValid,
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
                    isValid: _isEventDescriptionValid,
                    errorText: _eventDescriptionErrorText,
                    globalKey: _eventDescriptionKey,
                    isPressed: _isPressed,
                    inputDecoration: fieldInputDecoration(
                      hintColor: _isEventDescriptionValid
                          ? AppColors.grey5
                          : Colors.red,
                      contentPadding: const EdgeInsets.only(
                        left: 16,
                        top: 9,
                        right: 10,
                      ),
                      isValid: _isEventDescriptionValid,
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
                    isValid: _isEventLocationValid,
                    errorText: _eventLocationErrorText,
                    globalKey: _eventLocationKey,
                    isPressed: _isPressed,
                    inputDecoration: fieldInputDecoration(
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 24,
                        minHeight: 24,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, bottom: 10, right: 4),
                        child: Image.asset(AppIcons.eventLocation),
                      ),
                      contentPadding: const EdgeInsets.only(
                        top: 10,
                      ),
                      isValid: _isEventLocationValid,
                      hintText: 'Selecione a localização',
                    ),
                    validator: (data) {
                      return _emailValidation(data);
                    },
                    defaultHintColor: AppColors.hintInputForm,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
