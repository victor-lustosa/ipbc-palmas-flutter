import 'dart:ui';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:service_module/src/ui/stores/edit_lyric_store.dart';

import '../../../../service_module.dart';


class EditLyricView extends StatefulWidget {
  const EditLyricView({super.key, this.dto});

  final EditLiturgyDTO? dto;

  @override
  State<EditLyricView> createState() => _EditLyricViewState();
}

class _EditLyricViewState extends State<EditLyricView> {
  List<VerseEntity> versesList = [];
  final EditLyricStore _store = Modular.get<EditLyricStore>();

  @override
  void initState() {
    super.initState();
    _store.getLyrics();
    setDarkAppBar();
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
              if (state
                  is DataFetchedState<EditLyricState, List<LyricEntity>>) {
                versesList = state.entities[0].verses;
              }
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
                          left: 19,
                          right: 19,
                          bottom: 24,
                        ),
                        child: ReorderableListView.builder(
                          shrinkWrap: true,
                          itemCount: versesList.length,
                          buildDefaultDragHandles: false,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              key: Key('${versesList[index].id}'),
                              onLongPress: () {},
                              child: Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.searchBar,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      GridBallsTileWidget(index: index),
                                      Expanded(
                                        child: VersesListWidget(
                                          isEdit: true,
                                          entity: versesList,
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
                              if (oldIndex < newIndex) {
                                newIndex -= 1;
                              }
                              final VerseEntity item = versesList.removeAt(
                                oldIndex,
                              );
                              versesList.insert(newIndex, item);
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
              ServiceModule.servicesRoute + ServiceModule.servicesPreviewRoute,
            ),
      ),
    );
  }
}
