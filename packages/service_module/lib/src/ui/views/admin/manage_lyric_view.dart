import 'dart:ui';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ManageLyricView extends StatefulWidget {
  const ManageLyricView({super.key});

  @override
  State<ManageLyricView> createState() => _ManageLyricViewState();
}

class _ManageLyricViewState extends State<ManageLyricView> {
  final ManageLyricStore _store = Modular.get<ManageLyricStore>();

  @override
  void initState() {
    super.initState();
    _store.init();
  }

  @override
  void dispose() {
    _store.clear();
    super.dispose();
  }

  formField({
    required TextEditingController controller,
    required FocusNode focusNode,
  }) => Align(
    alignment: Alignment.center,
    child: Container(
      width: context.sizeOf.width,
      margin: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        buildCounter:
            (
              BuildContext context, {
              required int currentLength,
              required int? maxLength,
              required bool isFocused,
            }) => null,
        controller: controller,
        focusNode: focusNode,
        maxLength: 40,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        style: AppFonts.defaultFont(
          fontWeight: FontWeight.w500,
          color: AppColors.grey9,
          fontSize: 17,
        ),
        keyboardType: TextInputType.multiline,
        onChanged: (newValue) {
          _store.attributeFocusToFormField(
            focusNode: focusNode,
            controller: controller,
            newValue: newValue,
          );
        },
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: FocusScope(
        node: _store.rootFocusNode,
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ValueListenableBuilder(
                valueListenable: _store,
                builder: (_, state, child) {
                  if (state is LoadingState<ManageLyricState>) {
                    return const LoadingWidget(
                      androidRadius: 3,
                      iosRadius: 14,
                      color: AppColors.darkGreen,
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 16, top: 10),
                            child: BackButtonWidget(
                              color: AppColors.darkGreen,
                              action: () => nativePop(context),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: const EdgeInsets.only(top: 16, bottom: 30),
                              child: Text(
                                'Confira a letra e a ordem das estrofes:',
                                style: AppFonts.defaultFont(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.grey8,
                                ),
                              ),
                            ),
                          ),
                          formField(
                            controller: _store.titleController,
                            focusNode: _store.titleFocusNode,
                          ),
                          formField(
                            controller: _store.groupController,
                            focusNode: _store.groupFocusNode,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: ReorderableListView.builder(
                              shrinkWrap: true,
                              itemCount: _store.lyric.verses.length,
                              buildDefaultDragHandles: false,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                final verse = _store.lyric.verses[index];
                                final Key itemKey = Key('${verse.id}');
                                final GlobalKey gestureKey = GlobalKey();

                                return Container(
                                  key: itemKey,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryGrey2,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                  ),
                                  margin: const EdgeInsets.symmetric(vertical: 8),
                                  child: GestureDetector(
                                    key: gestureKey,
                                    child: IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          IgnorePointer(
                                            ignoring:
                                                _store.isAnyTextFieldFocused,
                                            child: GestureDetector(
                                              onLongPressStart: (_) async {
                                                FocusScope.of(context).unfocus();
                                                HapticFeedback.lightImpact();
                                              },
                                              child:
                                                  ReorderableDelayedDragStartListener(
                                                    index: index,
                                                    child: SizedBox(
                                                      width: 32,
                                                      height: 50,
                                                      child: GridBallsTileWidget(
                                                        index: index,
                                                      ),
                                                    ),
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                left: 3,
                                                top: 14,
                                                bottom: 14,
                                                right: 8,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: List.generate(
                                                  verse.versesList.length,
                                                  (position) {
                                                    final lineKey =
                                                        '${verse.id}_$position';

                                                    _store.updateTiles(
                                                      verse: verse,
                                                      position: position,
                                                      lineKey: lineKey,
                                                    );

                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom:
                                                            position ==
                                                                verse
                                                                        .versesList
                                                                        .length -
                                                                    1
                                                            ? 0
                                                            : 6,
                                                      ),
                                                      child: TextFormField(
                                                        controller: _store
                                                            .controllers[lineKey],
                                                        focusNode: _store
                                                            .focusNodes[lineKey],
                                                        decoration:
                                                            InputDecoration(
                                                              border: InputBorder
                                                                  .none,
                                                              isDense: true,
                                                              contentPadding:
                                                                  EdgeInsets.zero,
                                                            ),
                                                        style: AppFonts.defaultFont(
                                                          color: AppColors.grey10,
                                                          fontSize:
                                                              context
                                                                      .sizeOf
                                                                      .width >
                                                                  ResponsivityUtil
                                                                      .smallDeviceWidth
                                                              ? 16
                                                              : 14,
                                                        ),
                                                        maxLines: null,
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        onChanged: (newValue) {
                                                          verse.versesList[position] =
                                                              newValue;
                                                        },
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            width: 30,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                IconButtonWidget(
                                                  action: () async {
                                                    await showOptionsDialog(
                                                      context: context,
                                                      itemKey: gestureKey,
                                                      popupHeightParam: 110,
                                                      popupWidthParam: 160,
                                                      popupWidthPositionParam:
                                                          160,
                                                      verticalMarginParam: 3,
                                                      buttons: Column(
                                                        children: [
                                                          actionButton(
                                                            context: context,
                                                            top: 12,
                                                            bottom: 12,
                                                            icon:
                                                                AppIcons.addNotes,
                                                            label: 'Refrão',
                                                            action: () {},
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
                                                            icon:
                                                                AppIcons.addNotes,
                                                            label: 'Add Box',
                                                            action: () {},
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
                                                            icon: AppIcons
                                                                .contentCopy,
                                                            label: 'Duplicar',
                                                            action: () {},
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
                                                            action: () {},
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  size: 20,
                                                  color: AppColors.grey7,
                                                  androidIcon: Icons.menu,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              onReorder: (int oldIndex, int newIndex) {
                                setState(() {
                                  _store.newOrder(
                                    oldIndex: oldIndex,
                                    newIndex: newIndex,
                                  );
                                });
                              },
                              proxyDecorator: (Widget child, int index, animation) {
                                return Material(
                                  color: Colors.transparent,
                                  child: AnimatedBuilder(
                                    animation: animation,
                                    builder: (BuildContext context, Widget? _) {
                                      final animValue = Curves.easeInOut
                                          .transform(animation.value);
                                      final scale = lerpDouble(
                                        1,
                                        1.05,
                                        animValue,
                                      )!;

                                      return LayoutBuilder(
                                        builder: (innerContext, constraints) {
                                          final double childHeight =
                                              constraints.maxHeight.isFinite &&
                                                  constraints.maxHeight > 0
                                              ? constraints.maxHeight
                                              : 100.0;

                                          final double scaleCompensationOffset =
                                              childHeight * (scale - 1) / 2;
                                          final double gapCompensationOffset =
                                              childHeight * 0.2;

                                          return Transform.translate(
                                            offset: Offset(
                                              0,
                                              -scaleCompensationOffset +
                                                  gapCompensationOffset,
                                            ),
                                            child: Transform.scale(
                                              scale: scale,
                                              child: child,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: child,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          floatingActionButton: FloatingButtonWidget(
            icon: Icons.check_rounded,
            backgroundColor: AppColors.confirmation,
            iconColor: AppColors.grey10,
            size: 33,
            action: () {
              _store.buttonCallback();
            },
          ),
        ),
      ),
    );
  }
}
