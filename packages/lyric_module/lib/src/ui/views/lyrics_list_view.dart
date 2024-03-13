
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart' ;

import '../blocs/lyric_bloc.dart';

class LyricsListView extends StatefulWidget {
  const LyricsListView({super.key});

  @override
  State<LyricsListView> createState() => _LyricsListViewState();
}

class _LyricsListViewState extends State<LyricsListView> with TickerProviderStateMixin {
  late List<LyricEntity> _lyricsFetched;
  late final LyricBloc _bloc;
  bool isSelected = false;
  String selectedValue = '';

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
                androidRadius: 3.5,
                iosRadius: 12,
                color: AppColors.darkGreen,
              );
            } else if (state is NoConnectionState<LyricState>) {
              return const NoConnectionView(index: 0);
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
                      const TitleTopBarWidget(title: "Músicas/Letras"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 36, left: 17),
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
                        margin: const EdgeInsets.only(top: 20),
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
