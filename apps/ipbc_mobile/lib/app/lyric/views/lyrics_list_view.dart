
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart' ;

import '../../shared/blocs/generics.dart';
import '../../shared/components/lyrics_list_widget.dart';
import '../../shared/view-models/database_view_model.dart';
import '../blocs/lyric_bloc.dart';
import '../../exception/views/generic_error_view.dart';
import '../../exception/views/no_connection_view.dart';
import '../../../layout/top-bar/title_top_bar_widget.dart';

class LyricsListView extends StatefulWidget {
  const LyricsListView({super.key});

  @override
  State<LyricsListView> createState() => _LyricsListViewState();
}

class _LyricsListViewState extends State<LyricsListView> with TickerProviderStateMixin {
  late List<LyricEntity> lyricsFetched;
  late final LyricBloc bloc;
  bool isSelected = false;
  String selectedValue = '';

  @override
  void initState() {
    super.initState();
    lyricsFetched = [];
    bloc = Modular. get<LyricBloc>();
    if (!Modular.get<DatabaseViewModel>().data.isLyricsUpdated) {
      bloc.add(CheckConnectivityEvent<LyricEvent>());
    } else {
      bloc.add(GetInHiveEvent<LyricEvent>());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<LyricBloc, GenericState<LyricState>>(
        bloc: bloc,
        builder: (context, state) {
           if (state is LoadingState<LyricState>) {
            return const LoadingWidget();
          } else if (state is NoConnectionState<LyricState>) {
            return const NoConnectionView(index: 0);
          } else if (state is DataFetchedState<LyricState, LyricEntity>) {
            lyricsFetched = state.entities;
            Modular.get<DatabaseViewModel>().checkUpdateData(context, 'lyrics');
            return SafeArea(
              child: SingleChildScrollView(
                child: RefreshIndicator(
                  color: AppColors.darkGreen,
                  onRefresh: () async {
                    bloc.add(CheckConnectivityEvent());
                  },
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
                        child: LyricsListWidget(entitiesList: lyricsFetched),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const GenericErrorView();
          }
        },
      ),
    );
  }
}
