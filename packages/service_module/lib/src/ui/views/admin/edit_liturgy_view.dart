import 'dart:ui';
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class EditLiturgyView extends StatefulWidget {
  const EditLiturgyView({super.key});

  @override
  State<EditLiturgyView> createState() => _EditLiturgyViewState();
}

class _EditLiturgyViewState extends State<EditLiturgyView> with DateMixin {
  late EditLiturgyStore _editStore;
  late List<LiturgyModel> _liturgiesList;
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, FocusNode> _focusNodes = {};
  ValueNotifier<bool> isEventTitleValid = ValueNotifier(true);
  ValueNotifier<bool> isEventSubtitleValid = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    setLightAppBar();
    _editStore = Modular.get<EditLiturgyStore>();
    _editStore.setDayInTheWeek();
  }

  Future<void> setDateTime({
    required DateTime selectedDate,
    required Function(DateTime) onDatePicked,
    required BuildContext context,
  }) async {
    DateTime? pickedDate = await selectDateTime(
      selectedDate: selectedDate,
      context: context,
    );
    if (pickedDate != null) {
      setState(() {
        onDatePicked(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _editStore,
      builder: (context, child) {
        _liturgiesList = _editStore.items;
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              color: AppColors.white,
              width: context.sizeOf.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ServiceTopBarWidget(
                    image: _editStore.dto.image,
                    title: "Cultos de ${_editStore.dto.heading}",
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: TemplateFormWidget(
                      horizontalSymmetric: EdgeInsets.zero,
                      valueListenable: _editStore.isPreacherValid,
                      titleMargin: const EdgeInsets.only(bottom: 4),
                      controller: _editStore.preacherController,
                      title: 'Preletor',
                      isValid: _editStore.isPreacherValid.value,
                      errorText: _editStore.preacherErrorText,
                      globalKey: _editStore.preacherKey,
                      isPressed: _editStore.isPressed,
                      inputDecoration: fieldInputDecoration(
                        isValid: _editStore.isPreacherValid.value,
                        hintText: 'Preletor do culto',
                      ),
                      validator: (data) {
                        return _editStore.preacherValidation(data);
                      },
                      defaultHintColor: AppColors.hintInputForm,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: TemplateFormWidget(
                      horizontalSymmetric: EdgeInsets.zero,
                      valueListenable: _editStore.isThemeValid,
                      titleMargin: const EdgeInsets.only(bottom: 4),
                      controller: _editStore.themeController,
                      title: 'Mensagem',
                      isValid: _editStore.isThemeValid.value,
                      errorText: _editStore.themeErrorText,
                      globalKey: _editStore.themeKey,
                      isPressed: _editStore.isPressed,
                      inputDecoration: fieldInputDecoration(
                        isValid: _editStore.isThemeValid.value,
                        hintText: 'Mensagem do culto',
                      ),
                      validator: (data) {
                        return _editStore.themeValidation(data);
                      },
                      defaultHintColor: AppColors.hintInputForm,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 24),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: AppColors.grey8,
                              size: 20,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Text(
                                "Selecione o dia do culto",
                                style: AppFonts.defaultFont(
                                  fontSize: 13,
                                  color: AppColors.grey8,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () => setDateTime(
                                  selectedDate: _editStore.startDate,
                                  onDatePicked: (newDate) =>
                                      _editStore.startDate = newDate,
                                  context: context,
                                ),
                                child: Text(
                                  getFormattedDateTime(_editStore.startDate),
                                  style: AppFonts.defaultFont(
                                    fontSize: 15,
                                    color: AppColors.darkGreen,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 16.5,
                      top: 24.7,
                      bottom: 8,
                    ),
                    child: Text(
                      'Edite a liturgia do culto:',
                      style: AppFonts.defaultFont(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: AppColors.grey10,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 40,
                    ),
                    child: ReorderableListView.builder(
                      shrinkWrap: true,
                      itemCount: _liturgiesList.length,
                      buildDefaultDragHandles: false,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final currentLiturgy = _liturgiesList[index];
                        final GlobalKey itemKey = GlobalKey();

                        final Widget itemContent = Container(
                          decoration: const BoxDecoration(
                            color: AppColors.secondaryGrey2,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                ReorderableDragStartListener(
                                  index: index,
                                  child: Container(
                                    color: Colors.transparent,
                                    width: 36,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GridBallsTileWidget(index: index),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      bottom: 8,
                                      top: 8,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          _liturgiesList[index].sequence,
                                          style: AppFonts.defaultFont(
                                            color: AppColors.grey9,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Visibility(
                                          visible: _liturgiesList[index]
                                              .isAdditional,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              top: 4,
                                            ),
                                            child: Text(
                                              _liturgiesList[index].isAdditional
                                                  ? _liturgiesList[index]
                                                        .additional!
                                                  : '',
                                              style: AppFonts.defaultFont(
                                                color: AppColors.grey8,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );

                        return Container(
                          key: ValueKey(currentLiturgy),
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: GestureDetector(
                            key: itemKey,
                            onLongPressStart: (details) async {
                              Modular.get<EditLiturgyStore>().entity =
                                  currentLiturgy;
                              Modular.get<EditLiturgyStore>().index = index;
                              await showOptionsDialog(
                                context: context,
                                itemKey: itemKey,
                                itemContent: itemContent,
                                buttons: Column(
                                  children: [
                                    actionButton(
                                      context: context,
                                      top: 12,
                                      bottom: 12,
                                      icon: AppIcons.addNotes,
                                      label: 'Add Box',
                                      action: () {
                                        Modular.get<EditLiturgyStore>()
                                            .addBox();
                                        pop(context);
                                      },
                                    ),
                                    Divider(
                                      height: 1,
                                      color: AppColors.dividerModal.withValues(
                                        alpha: 25,
                                      ),
                                    ),
                                    actionButton(
                                      context: context,
                                      top: 12,
                                      bottom: 12,
                                      icon: AppIcons.contentCopy,
                                      label: 'Duplicar',
                                      action: () {
                                        Modular.get<EditLiturgyStore>()
                                            .copyEntity();
                                        pop(context);
                                      },
                                    ),
                                    Divider(
                                      height: 1,
                                      color: AppColors.dividerModal.withValues(
                                        alpha: 25,
                                      ),
                                    ),
                                    actionButton(
                                      context: context,
                                      top: 12,
                                      bottom: 12,
                                      icon: AppIcons.trash,
                                      label: 'Deletar',
                                      action: () {
                                        Modular.get<EditLiturgyStore>()
                                            .delete();
                                        pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: itemContent,
                          ),
                        );
                      },
                      onReorder: (int oldIndex, int newIndex) {
                        setState(() {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          final LiturgyModel item = _liturgiesList.removeAt(
                            oldIndex,
                          );
                          _liturgiesList.insert(newIndex, item);
                        });
                      },
                      proxyDecorator: (Widget child, _, animation) {
                        return AnimatedBuilder(
                          animation: animation,
                          builder: (BuildContext context, Widget? child) {
                            final animValue = Curves.easeInOut.transform(
                              animation.value,
                            );
                            final scale = lerpDouble(1, 1.1, animValue)!;
                            return Transform.scale(scale: scale, child: child);
                          },
                          child: child,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingButtonWidget(
            icon: Icons.check_rounded,
            backgroundColor: AppColors.confirmation,
            iconColor: AppColors.grey10,
            size: 33,
            action: () {
              Modular.get<ServicesPreviewStore>().dto = ServicesPreviewDTO(
                heading: _editStore.dto.heading,
                image: _editStore.dto.image,
                liturgiesList: _liturgiesList,
              );
              popAndPushNamed(
                AppRoutes.servicesRoute + AppRoutes.servicesPreviewRoute,
              );
            },
          ),
        );
      },
    );
  }
}
