import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../blocs/lyric_bloc.dart';

class LyricsListView extends StatefulWidget {
  const LyricsListView({super.key});

  @override
  State<LyricsListView> createState() => _LyricsListViewState();
}

class _LyricsListViewState extends State<LyricsListView>
    with TickerProviderStateMixin {
  late List<LyricEntity> _lyricsFetched;
  late final LyricBloc _bloc;
  bool isSelected = false;
  String selectedValue = '';
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _lyricsFetched = [];
    _bloc = Modular.get<LyricBloc>();
    _bloc.add(CheckConnectivityEvent<LyricEvent>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                action: () => AppRoutes().nativeNavigate(
                  LyricModule.initialRoute,
                  context,
                ),
              );
            } else if (state is DataFetchedState<LyricState, LyricEntity>) {
              _lyricsFetched = state.entities;
              return RefreshIndicator(
                color: AppColors.darkGreen,
                onRefresh: () async {
                  _bloc.add(CheckConnectivityEvent());
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const TitleTopBarWidget(title: "Músicas"),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 38,
                          bottom: 13,
                        ),
                        child: SearchBarWidget(
                          controller: controller,
                          action: () {},
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 21.5,
                        ),
                        child: const OwnChoiceChipsWidget(),
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
                        child: LyricsListWidget(entitiesList: _lyricsFetched),
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
    );
  }
}
