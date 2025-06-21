import 'dart:ui';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:service_module/src/ui/stores/admin/edit_lyric_store.dart';

class EditLyricView extends StatefulWidget {
  const EditLyricView({super.key, required this.entity});

  final LyricEntity entity;

  @override
  State<EditLyricView> createState() => _EditLyricViewState();
}

class _EditLyricViewState extends State<EditLyricView> {
  final EditLyricStore _store = Modular.get<EditLyricStore>();

  @override
  void initState() {
    super.initState();
    setDarkAppBar();
    _store.initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _store,
          builder: (_, state, child) {
            if (state is LoadingState<EditLyricState>) {
              return const LoadingWidget(
                androidRadius: 3,
                iosRadius: 14,
                color: AppColors.darkGreen,
              );
            } else {
              return SingleChildScrollView(
                child: Container(
                  color: AppColors.white,
                  width: context.sizeOf.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 16.5,
                          top: 24.7,
                          bottom: 16,
                        ),
                        child: Text(
                          'Edite a letra:',
                          style: AppFonts.defaultFont(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: AppColors.grey10,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 19, right: 19),
                        child: ReorderableListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.entity.verses.length,
                          buildDefaultDragHandles: false,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              key: Key('${widget.entity.verses[index].id}'),
                              onLongPress: () {},
                              child: Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                ),
                                child: ClipRRect(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.secondaryGrey2,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        GridBallsTileWidget(index: index),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.all(16),
                                            child: ListView.separated(
                                              separatorBuilder: (__, _) {
                                                return const SizedBox(
                                                  height: 6,
                                                );
                                              },
                                              itemCount:
                                                  widget
                                                      .entity
                                                      .verses[index]
                                                      .versesList
                                                      .length,
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: ((__, position) {
                                                return Text(
                                                  widget
                                                      .entity
                                                      .verses[index]
                                                      .versesList[position],
                                                  style: AppFonts.defaultFont(
                                                    color: AppColors.grey10,
                                                    fontSize:
                                                        context.sizeOf.width >
                                                                ResponsivityUtil
                                                                    .smallDeviceWidth
                                                            ? 16
                                                            : 14,
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          onReorder: (int oldIndex, int newIndex) {
                            setState(() {
                              if (oldIndex < newIndex) {
                                newIndex -= 1;
                              }
                              final VerseEntity item = widget.entity.verses
                                  .removeAt(oldIndex);
                              widget.entity.verses.insert(newIndex, item);
                            });
                          },
                          proxyDecorator: (Widget child, _, animation) {
                            return AnimatedBuilder(
                              animation: animation,
                              builder: (BuildContext context, Widget? child) {
                                final animValue = Curves.easeInOut.transform(
                                  animation.value,
                                );
                                final scale = lerpDouble(1, 1.05, animValue)!;
                                return Transform.scale(
                                  scale: scale,
                                  child: child,
                                );
                              },
                              child: child,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingButtonWidget(
        icon: Icons.check_rounded,
        backgroundColor: AppColors.confirmation,
        iconColor: AppColors.grey10,
        size: 33,
        action:
            () => pushNamed(
              AppRoutes.servicesRoute + AppRoutes.servicesPreviewRoute,
            ),
      ),
    );
  }
}
