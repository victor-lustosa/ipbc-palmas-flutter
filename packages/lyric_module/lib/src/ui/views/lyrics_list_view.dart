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
  bool isSelected = false;
  String selectedValue = '';
  final TextEditingController controller = TextEditingController();
  late final LyricsListStore _lyricsListStore;
  late final EditLyricStore _editLyricStore;

  @override
  void initState() {
    super.initState();
    setLightAppBar();
    _bloc = Modular.get<LyricBloc>();
    _bloc.add(GetDataEvent<LyricEvent>());
    WidgetsBinding.instance.addPostFrameCallback((frameCallback) {
      initializeEditLyricStore();
    });
    _lyricsListStore = Modular.get<LyricsListStore>();
    _editLyricStore = Modular.get<EditLyricStore>();
  }

  initializeEditLyricStore() async {
    EditLyricStore editLyricStore = Modular.get<EditLyricStore>();
    editLyricStore.isEditing = true;
    editLyricStore.buttonCallback = () {
      _bloc.add(GetDataEvent<LyricEvent>());
      pop(context);
    };
  }

  int selectedIndex = 0;

  int selectOptions(int index) {
    selectedIndex = index;
    return selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    // int selectedIndex = 0;
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
              } else if (state
                  is DataFetchedState<LyricState, List<LyricModel>>) {
                _lyricsListStore.entitiesList = state.entities;
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
                            controller: controller,
                            onChange: (value) {
                              bool writing = value.length > 1;
                              _bloc.add(
                                FilterEvent<LyricEvent, LyricEntity>(
                                  controller.text,
                                  writing,
                                  selectedIndex == 0
                                      ? TitleFilter()
                                      : ArtistFilter(),
                                  // FilterFactory<LyricEvent,List<LyricEntity>>(index: selectedIndex),
                                  selectedIndex,
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
                          child: OwnChoiceChipsWidget(action: selectOptions),
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
                          child: LyricsListWidget(
                            onLongPressStart: (details) async {
                              await showEditDialog(
                                context: context,
                                itemKey: _lyricsListStore.itemKey,
                                popupHeightParam: 110,
                                verticalMarginParam: 3,
                                buttons: Column(
                                  children: [
                                    actionButton(
                                      context: context,
                                      top: 20,
                                      bottom: 12,
                                      icon: AppIcons.edit,
                                      label: 'Editar',
                                      action: () {
                                        _editLyricStore.isEditing = true;
                                        pushNamed(
                                          AppRoutes.servicesRoute +
                                              AppRoutes.editLyricRoute,
                                          arguments:
                                              _lyricsListStore.lyricModel,
                                        );
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
                                      bottom: 20,
                                      icon: AppIcons.trash,
                                      label: 'Deletar',
                                      action: () {},
                                    ),
                                  ],
                                ),
                              );
                            },
                            onTap: () {
                              pushNamed(
                                AppRoutes.lyricsRoute + AppRoutes.lyricRoute,
                                arguments: _lyricsListStore.lyricModel,
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
