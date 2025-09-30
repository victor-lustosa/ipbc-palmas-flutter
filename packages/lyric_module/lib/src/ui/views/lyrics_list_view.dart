import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../blocs/lyric_bloc.dart';

class LyricsListView extends StatefulWidget {
  const LyricsListView({super.key});

  @override
  State<LyricsListView> createState() => _LyricsListViewState();
}

class _LyricsListViewState extends State<LyricsListView>
    with TickerProviderStateMixin {
  late final LyricBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<LyricBloc>();
    WidgetsBinding.instance.addPostFrameCallback((frameCallback) {
      _bloc.init(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: BlocBuilder<LyricBloc, GenericState<LyricState>>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is LoadingState<LyricState>) {
                return const LoadingWidget(
                  androidRadius: 3,
                  iosRadius: 14,
                  color: AppColors.darkGreen,
                );
              } else if (state is NoConnectionState<LyricState>) {
                return NoConnectionView(
                  action: () =>
                      nativePushReplacementNamed(AppRoutes.rootRoute, context),
                );
              } else if (state is DataFetchedState<LyricState>) {
                return RefreshIndicator(
                  color: AppColors.darkGreen,
                  onRefresh: () async {
                    _bloc.add(GetDataEvent());
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const TitleTopBarWidget(title: "Músicas"),
                        /*Text(state.entities.length.toString()),
                        ElevatedButton(
                            onPressed: () {
                              _bloc.add(
                                GetPaginationEvent<LyricEvent, LyricEntity>(10),
                              );
                            },
                            child: const Text('Paginação')),*/
                        Container(
                          margin: const EdgeInsets.only(top: 30, bottom: 13),
                          child: SearchBarWidget(
                            controller: _bloc.controller,
                            onChange: (value) {
                              bool writing = value.length > 1;
                              _bloc.add(
                                FilterEvent<LyricEvent, LyricEntity>(
                                  _bloc.controller.text,
                                  writing,
                                  _bloc.selectedIndex == 0
                                      ? TitleFilter()
                                      : ArtistFilter(),
                                  // FilterFactory<LyricEvent,List<LyricEntity>>(index: selectedIndex),
                                  _bloc.selectedIndex,
                                ),
                              );
                            },
                            action: () {
                              // _bloc.add(
                              //     FilterEvent(controller.text, selectedIndex));
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 21.5),
                          child: OwnChoiceChipsWidget(
                            action: _bloc.selectOptions,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 24, left: 17),
                              child: Text(
                                "Adicionados recentemente",
                                style: AppFonts.defaultFont(
                                  color: AppColors.grey12,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 14),
                          child: ValueListenableBuilder(
                              valueListenable: _bloc.lyricsListStore,
                              builder: (context, state, child) {
                              return LyricsListWidget(
                                onLongPressStart: (details) async {
                                  await showOptionsDialog(
                                    context: context,
                                    itemKey: _bloc.lyricsListStore.itemKey,
                                    popupHeightParam: 110,
                                    popupWidthParam: 160,
                                    popupWidthPositionParam: 160,
                                    verticalMarginParam: 3,
                                    buttons: Column(
                                      children: [
                                        actionButton(
                                          context: context,
                                          top: 12,
                                          bottom: 12,
                                          icon: AppIcons.edit,
                                          label: 'Editar',
                                          action: () {
                                            _bloc.editLyric(context);
                                          }
                                        ),
                                        Divider(
                                          height: 1,
                                          color: AppColors.dividerModal.withValues(
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
                                            _bloc.deleteLyric(context: context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                onTap: () {
                                  pushNamed(
                                    AppRoutes.lyricsRoute + AppRoutes.lyricRoute,
                                    arguments: _bloc.lyricsListStore.lyricEntity,
                                  );
                                },
                              );
                            }
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const GenericErrorView();
              }
            },
          ),
        ),
      ),
    );
  }
}
