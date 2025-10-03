import 'dart:ui';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ManageServiceView extends StatefulWidget {
  const ManageServiceView({super.key});

  @override
  State<ManageServiceView> createState() => _ManageServiceViewState();
}

class _ManageServiceViewState extends State<ManageServiceView>
    with DateMixin, ValidationAndFormatMixin {
  late ManageServiceStore _store;
  final Map<String, GlobalKey> _liturgyKeys = {};
  final Map<String, GlobalKey> _tileKeys = {};
  final Map<String, double> _tileHeights = {};

  @override
  void initState() {
    super.initState();
    _store = Modular.get<ManageServiceStore>();
    _store.init();
  }

  @override
  dispose() {
    _store.resetValidationFields();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: FocusScope(
        node: _store.rootFocusNode,
        child: ValueListenableBuilder(
          valueListenable: _store,
          builder: (_, state, child) {
            return Scaffold(
              body: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusScope.of(context).unfocus(),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      color: AppColors.white,
                      width: context.sizeOf.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ServiceTopBarWidget(
                            image: _store.servicesEntity.image,
                            title: "Cultos de ${_store.servicesEntity.heading}",
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 16,
                              left: 16,
                              right: 16,
                            ),
                            child: TemplateFormWidget(
                              horizontalSymmetric: EdgeInsets.zero,
                              valueListenable: _store.isThemeValid,
                              titleMargin: const EdgeInsets.only(bottom: 4),
                              controller: _store.themeController,
                              title: 'Mensagem',
                              isValid: _store.isThemeValid.value,
                              errorText: _store.themeErrorText,
                              globalKey: _store.themeKey,
                              isPressed: _store.isSavePressed,
                              inputDecoration: fieldInputDecoration(
                                isValid: _store.isThemeValid.value,
                                hintText: 'Mensagem do culto',
                              ),
                              validator: (data) {
                                return _store.formValidation(
                                  data,
                                  _store.isThemeValid,
                                );
                              },
                              defaultHintColor: AppColors.hintInputForm,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 16,
                              left: 16,
                              right: 16,
                            ),
                            child: TemplateFormWidget(
                              horizontalSymmetric: EdgeInsets.zero,
                              valueListenable: _store.isPreacherValid,
                              titleMargin: const EdgeInsets.only(bottom: 4),
                              controller: _store.preacherController,
                              title: 'Preletor',
                              isValid: _store.isPreacherValid.value,
                              errorText: _store.preacherErrorText,
                              globalKey: _store.preacherKey,
                              isPressed: _store.isSavePressed,
                              inputDecoration: fieldInputDecoration(
                                isValid: _store.isPreacherValid.value,
                                hintText: 'Preletor do culto',
                              ),
                              validator: (data) {
                                return _store.formValidation(
                                  data,
                                  _store.isPreacherValid,
                                );
                              },
                              defaultHintColor: AppColors.hintInputForm,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 24,
                            ),
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
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: InkWell(
                                          onTap: () {
                                            setDateAndTime(
                                              selectedDate: _store.startDate!,
                                              onDatePicked: (newDate) {
                                                setState(() {
                                                  _store.startDate = newDate;
                                                  _store.startTime = TimeOfDay(
                                                    hour: newDate.hour,
                                                    minute: newDate.minute,
                                                  );
                                                });
                                              },
                                              context: context,
                                              selectedTime: _store.startTime!,
                                            );
                                          },
                                          child: Text(
                                            getFormattedDateTime(
                                              _store.startDate!,
                                            ),
                                            style: AppFonts.defaultFont(
                                              fontSize: 15,
                                              color: AppColors.darkGreen,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          pickTime(
                                            selectedTime: _store.startTime!,
                                            context: context,
                                            onTimePicked: (newTime) {
                                              setState(() {
                                                _store.startTime = newTime;
                                              });
                                            },
                                          );
                                        },
                                        child: Text(
                                          formatHourToString(
                                            time: _store.startTime,
                                          ),
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
                          InkWell(
                            child: Container(
                              height: 40,
                              decoration: const BoxDecoration(
                                color: AppColors.secondaryGrey2,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              margin: EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 25,
                              ),
                              width: context.sizeOf.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 10,
                                      left: 12,
                                    ),
                                    child: IconWidget(
                                      iconFormat: IconFormat.svg,
                                      size: Size(24, 24),
                                      iconName: AppIcons.addNotesSvg,
                                      color: AppColors.grey9,
                                    ),
                                  ),
                                  Text(
                                    'Adicionar Box',
                                    style: AppFonts.defaultFont(
                                      fontSize: 17,
                                      color: AppColors.grey9,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              _store.addBox();
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              left: 16.5,
                              top: 20,
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
                            margin: const EdgeInsets.only(left: 16, right: 16),
                            child: ReorderableListView.builder(
                              shrinkWrap: true,
                              itemCount: _store.liturgiesList.length,
                              buildDefaultDragHandles: false,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                final liturgy = _store.liturgiesList[index];
                                final itemKey = Key('${liturgy.id}');
                                final liturgyId = liturgy.id ?? '';

                                final gestureKey = _liturgyKeys.putIfAbsent(liturgyId, () => GlobalKey());
                                final tileKey = _tileKeys.putIfAbsent(liturgyId, () => GlobalKey());

                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  if (_tileHeights[liturgyId] == null && tileKey.currentContext != null) {
                                    final height = tileKey.currentContext!.size!.height;
                                    if (mounted) {
                                      setState(() {
                                        _tileHeights[liturgyId] = height;
                                      });
                                    }
                                  }
                                });

                                final double currentTileHeight = _tileHeights[liturgyId] ?? 0.0;

                                final Widget itemContent = Container(
                                  key: tileKey,
                                  decoration: const BoxDecoration(
                                    color: AppColors.secondaryGrey2,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
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
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                GridBallsTileWidget(
                                                  index: index,
                                                ),
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
                                            child: Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  TextFormField(
                                                    controller: _store.controllers["${liturgy.id}_0"],
                                                    focusNode: _store.focusNodes["${liturgy.id}_0"],
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      isDense: true,
                                                      contentPadding: EdgeInsets.zero,
                                                    ),
                                                    style: AppFonts.defaultFont(
                                                      color: AppColors.grey9,
                                                      fontSize: 17,
                                                    ),
                                                    textInputAction: TextInputAction.next,
                                                    onFieldSubmitted: (_) {
                                                      if (!liturgy.isAdditional) {
                                                        _tileHeights.remove(liturgyId);
                                                        _store.activateAdditionalField(liturgyId);
                                                      }
                                                      WidgetsBinding.instance.addPostFrameCallback((_) {
                                                        final nextFocusNode = _store.focusNodes["${liturgy.id}_1"];
                                                        if (nextFocusNode != null) {
                                                          FocusScope.of(context).requestFocus(nextFocusNode);
                                                        }
                                                      });
                                                    },
                                                    maxLines: null,
                                                    keyboardType: TextInputType.multiline,
                                                  ),
                                                  Visibility(
                                                    visible: _store.liturgiesList[index].isAdditional,
                                                    child: Container(
                                                      margin: const EdgeInsets.only(top: 4),
                                                      child: TextFormField(
                                                        controller: _store.controllers["${liturgy.id}_1"],
                                                        focusNode: _store.focusNodes["${liturgy.id}_1"],
                                                        autofocus: _store.shouldAutofocus(liturgyId),
                                                        decoration:
                                                            InputDecoration(
                                                              border: InputBorder.none,
                                                              isDense: true,
                                                              contentPadding: EdgeInsets.zero,
                                                            ),
                                                        style:
                                                            AppFonts.defaultFont(
                                                              color: AppColors.grey10,
                                                              fontSize: 13,
                                                            ),
                                                        maxLines: null,
                                                        keyboardType: TextInputType.multiline,
                                                        onChanged: (value) {
                                                          if (value.isEmpty) {
                                                            _tileHeights.remove(liturgyId);
                                                            _store.updateLiturgyItemState(liturgyId, false);
                                                            _store.focusNodes["${liturgy.id}_0"]?.requestFocus();
                                                          } else {
                                                            setState(() {});
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          key: gestureKey,
                                          margin: EdgeInsets.only(
                                            bottom: currentTileHeight < 46
                                                ? 0 : 12,
                                            right:  12,
                                          ),
                                          child: Column(
                                            mainAxisAlignment: currentTileHeight < 46
                                                ? MainAxisAlignment.center
                                                : MainAxisAlignment.end,
                                            children: [
                                              IconButtonWidget(
                                                iconFormat: IconFormat.svg,
                                                size: 18,
                                                iconName: AppIcons.popoverIcon,
                                                action: () async {
                                                  _store.liturgyModel = liturgy;
                                                  _store.index = index;
                                                  await showOptionsDialog(
                                                    context: context,
                                                    itemKey: gestureKey,
                                                    popupHeightParam: 110,
                                                    popupWidthParam: 140,
                                                    popupWidthPositionParam: 140,
                                                    verticalMarginParam: 3,
                                                    buttons: Column(
                                                      children: [
                                                        actionButton(
                                                          context: context,
                                                          top: 12,
                                                          bottom: 12,
                                                          icon: AppIcons.contentCopy,
                                                          label: 'Duplicar',
                                                          action: () {
                                                            _store.copyBox();
                                                            pop(context);
                                                          },
                                                        ),
                                                        Divider(
                                                          height: 1,
                                                          color: AppColors
                                                              .dividerModal
                                                              .withValues(
                                                            alpha: .3,
                                                          ),
                                                        ),
                                                        actionButton(
                                                          context: context,
                                                          top: 12,
                                                          bottom: 12,
                                                          icon: AppIcons.trash,
                                                          label: 'Deletar',
                                                          action: () {
                                                            pop(context);
                                                            final bool shouldMoveFocus = _store.deleteBox(key: liturgy.id);
                                                            WidgetsBinding.instance.addPostFrameCallback((_) {
                                                              if (shouldMoveFocus) {
                                                                _store.requestFocusAfterBuild();
                                                              } else {
                                                                FocusScope.of(context).unfocus();
                                                              }
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                return Container(
                                  key: itemKey,
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 8,
                                  ),
                                  child: itemContent,
                                );
                              },
                              onReorder: (int oldIndex, int newIndex) {
                                setState(() {
                                  if (oldIndex < newIndex) {
                                    newIndex -= 1;
                                  }
                                  final LiturgyEntity item = _store.liturgiesList.removeAt(oldIndex);
                                  _store.liturgiesList.insert(newIndex, item);
                                });
                                FocusScope.of(context).unfocus();
                              },
                              proxyDecorator: (Widget child, _, animation) {
                                return Material(
                                  color: Colors.transparent,
                                  child: AnimatedBuilder(
                                    animation: animation,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                          final animValue = Curves.easeInOut.transform(animation.value);
                                          final scale = lerpDouble(1, 1.1, animValue)!;
                                          return Transform.scale(
                                            scale: scale,
                                            child: child,
                                          );
                                        },
                                    child: child,
                                  ),
                                );
                              },
                            ),
                          ),

                          LoadingButtonWidget(
                            isPressed: _store.isSavePressed,
                            action: () async {
                              _store.submit(context);
                            },
                            isValid: ValueNotifier(_store.isThemeValid.value &&
                                _store.isPreacherValid.value &&
                                _store.liturgiesList.isNotEmpty),
                            label: "Salvar Culto",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
