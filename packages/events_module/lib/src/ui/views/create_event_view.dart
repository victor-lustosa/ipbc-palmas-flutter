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
    return ValueListenableBuilder(
        valueListenable: store,
        builder: (_, state, child) {
          return Scaffold(
            body: SafeArea(
              child: SizedBox(
                width: context.sizeOf.width,
                height: context.sizeOf.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MainTopBarWidget(),
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
                      Column(
                        children: [
                          ValueListenableBuilder(
                              valueListenable: store.isCoverImageValid,
                              builder: (_, value, ___) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.grey0,
                                    border: Border.all(color: value ? AppColors.grey0 : Colors.red),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  width: context.sizeOf.width,
                                  height: 144,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: InkWell(
                                    onTap: () async => await store.getImage(),
                                    child: state is FetchedImageState
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
                                                  margin: const EdgeInsets.only(
                                                      top: 41.33,
                                                      bottom: 13.33),
                                                  child: state
                                                          is LoadingImageState
                                                      ? Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 6),
                                                          child: LoadingWidget(
                                                              size:
                                                                  Platform.isIOS
                                                                      ? 10
                                                                      : 22))
                                                      : Image.asset(
                                                          color: value ? AppColors.darkGreen : Colors.red,
                                                          AppIcons.folderUpload,
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
                                  child: Text("Por favor, insira a imagem", style: TextStyle(color: Colors.red)),
                                );
                              }),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: ValueListenableBuilder(
                            valueListenable: store.isEventTitleValid,
                            builder: (_, value, ___) {
                              return TemplateFormWidget(
                                titleMargin: const EdgeInsets.only(bottom: 4),
                                controller: store.eventTitleController,
                                title: 'Título do evento',
                                isValid: value,
                                errorText: store.eventTitleErrorText,
                                globalKey: store.eventTitleKey,
                                isPressed: store.isPressed,
                                inputDecoration: fieldInputDecoration(
                                  isValid: value,
                                  hintText: 'Título do seu evento',
                                ),
                                validator: (data) {
                                  return store.titleValidation(data);
                                },
                                defaultHintColor: AppColors.hintInputForm,
                              );
                            }),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: ValueListenableBuilder(
                            valueListenable: store.isEventTitleValid,
                            builder: (_, value, ___) {
                              return TemplateFormWidget(
                                titleMargin: const EdgeInsets.only(bottom: 4),
                                controller: store.eventDescriptionController,
                                title: 'Descrição',
                                maxLines: 4,
                                fieldHeight: 110,
                                isValid: value,
                                errorText: store.eventDescriptionErrorText,
                                globalKey: store.eventDescriptionKey,
                                isPressed: store.isPressed,
                                inputDecoration: fieldInputDecoration(
                                  hintColor:
                                      value // store.isEventDescriptionValid
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
                                  return store.emailValidation(data);
                                },
                                defaultHintColor: AppColors.hintInputForm,
                              );
                            }),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: ValueListenableBuilder(
                            valueListenable: store.isEventTitleValid,
                            builder: (_, value, ___) {
                              return TemplateFormWidget(
                                titleMargin: const EdgeInsets.only(bottom: 4),
                                controller: store.eventLocationController,
                                title: 'Localização',
                                maxLines: 4,
                                isValid: value,
                                errorText: store.eventLocationErrorText,
                                globalKey: store.eventLocationKey,
                                isPressed: store.isPressed,
                                inputDecoration: fieldInputDecoration(
                                  prefixIconConstraints: const BoxConstraints(),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 8),
                                    child: Image.asset(
                                      AppIcons.eventLocation,
                                      height: 22,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  isValid: value,
                                  hintText: 'Selecione a localização',
                                ),
                                validator: (data) {
                                  return store.emailValidation(data);
                                },
                                defaultHintColor: AppColors.hintInputForm,
                              );
                            }),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: ValueListenableBuilder(
                            valueListenable: store.isEventTitleValid,
                            builder: (_, value, ___) {
                              return TemplateFormWidget(
                                controller: store.eventLinkController,
                                title: 'Link',
                                isValid: value,
                                errorText: store.eventLinkErrorText,
                                globalKey: store.eventLinkKey,
                                isPressed: store.isPressed,
                                inputDecoration: fieldInputDecoration(
                                  prefixIconConstraints: const BoxConstraints(),
                                  prefixIcon: prefixLocationIcon,
                                  isValid: value,
                                  hintText: 'Link do evento',
                                ),
                                validator: (data) {
                                  return store.emailValidation(data);
                                },
                              );
                            }),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: ValueListenableBuilder(
                            valueListenable: store.isEventTitleValid,
                            builder: (_, value, ___) {
                              return TemplateFormWidget(
                                controller:
                                    store.eventLinkDescriptionController,
                                isValid: value,
                                errorText: store.eventLinkDescriptionErrorText,
                                globalKey: store.eventLinkDescriptionKey,
                                isPressed: store.isPressed,
                                inputDecoration: fieldInputDecoration(
                                  isValid: value,
                                  hintText: 'Descrição do link',
                                ),
                                validator: (data) {
                                  return store.emailValidation(data);
                                },
                              );
                            }),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16, bottom: 60),
                        child: ValueListenableBuilder(
                            valueListenable: store.isEventTitleValid,
                            builder: (_, value, ___) {
                              return TemplateFormWidget(
                                controller: store.contactLinkController,
                                title: 'Link para contato',
                                isValid: value,
                                errorText: store.contactLinkErrorText,
                                globalKey: store.contactLinkKey,
                                isPressed: store.isPressed,
                                inputDecoration: fieldInputDecoration(
                                  prefixIconConstraints: const BoxConstraints(),
                                  prefixIcon: prefixLocationIcon,
                                  isValid: value,
                                  hintText: 'Link do contato',
                                ),
                                validator: (data) {
                                  return store.emailValidation(data);
                                },
                              );
                            }),
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
                AppRoutes.eventRoute + AppRoutes.detailEventRoute,
              ),
            ),
          );
        });
  }
}
