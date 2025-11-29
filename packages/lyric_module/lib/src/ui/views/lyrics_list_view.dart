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
      _bloc.viewHashCode = hashCode;
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
                    _bloc.add(GetDataEvent(context: context));
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const TitleTopBarWidget(title: "Músicas"),
                        Container(
                          margin: const EdgeInsets.only(top: 37),
                          child: SearchWidget(storeId: _bloc.viewHashCode,),
                        ),

                        /*Text(state.entities.length.toString()),
                        ElevatedButton(
                            onPressed: () {
                              _bloc.add(
                                GetPaginationEvent<LyricEvent, LyricEntity>(10),
                              );
                            },
                            child: const Text('Paginação')),*/
                        Visibility(
                          visible:
                              _bloc.entitiesList.isNotEmpty,
                          child: LyricsListWidget(
                            entitiesList: _bloc.entitiesList,
                            title: "Adicionados recentemente",
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
                                      },
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
                                      action: () async {
                                        await showConfirmationDialog(
                                          confirmAction: () async {
                                            _bloc.deleteLyric(context: context);
                                          },
                                          title: "Deletar Letra",
                                          message:
                                              "A letra será deletada permanentemente. Tem certeza?",
                                          context: context,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                              _bloc.lyricsListStore.tappedIndex.value = null;
                            },
                            onTap: () {
                              pushNamed(
                                AppRoutes.lyricsRoute + AppRoutes.lyricRoute,
                                arguments: _bloc.lyricsListStore.lyricEntity,
                              );
                            },
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
