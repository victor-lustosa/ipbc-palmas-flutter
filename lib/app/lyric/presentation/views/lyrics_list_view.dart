import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../exception/view/generic_error_view.dart';
//import '../../../shared/components/search-bar/search_bar_widget.dart';
import '../../../exception/view/no_connection_view.dart';
import '../../../shared/components/loading/loading_widget.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/layout/top-bar/title_top_bar_widget.dart';
import '../../../splash/presentation/blocs/database_bloc.dart';
import '../../infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../blocs/lyric_bloc.dart';
import '../../domain/entities/lyric_entity.dart';
import '../../../shared/layout/side-bar/side_bar_widget.dart';
import '../components/lyrics_list_widget.dart';

class LyricsListView extends StatefulWidget {
  const LyricsListView({super.key});

  @override
  State<LyricsListView> createState() => _LyricsListViewState();
}

class _LyricsListViewState extends State<LyricsListView>
    with TickerProviderStateMixin {

  late List<LyricEntity> lyricsFetched;
  late List<LyricEntity> lyricsFiltered;
  late List<String> drawerNames;
  late final LyricBloc bloc;
  bool isSelected = false;
  String selectedValue = '';
  late HiveDatabaseConfigsDTO data;

  fillLettersCarousel() {
    drawerNames = [
      'Sobre IPB Palmas',
      'Músicas/Letras',
      'Agenda',
      'Playlist de sermões',
      'Pastoral',
      'Dízimos e Ofertas',
      'Sociedades internas'
    ];
  }

  @override
  void initState() {
    super.initState();
    lyricsFetched = [];
    lyricsFiltered = [];
    fillLettersCarousel();
    bloc = context.read<LyricBloc>();
    data = context.read<HiveDatabaseConfigsDTO>();
    bloc.add(CheckConnectivityEvent(data: data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawerScrimColor: Colors.black26,
        endDrawer: SideBarWidget(
          drawerNames: drawerNames,
        ),
        drawerEnableOpenDragGesture: true,
        backgroundColor: AppColors.white,
        body: BlocBuilder<LyricBloc, LyricState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is InitialState) {
              return const LoadingWidget();
            } else if (state is LoadingLyricsState) {
              return const LoadingWidget();
            } else if (state is NoConnectionAvailableState) {
              return const NoConnectionView(index: 0);
            } else if (state is SuccessfullyFetchedLyricsState || state is SuccessfullyFilteredLyricsState) {

              if (!(data.isLyricsUpdated) || (data.fireUpdateId != data.hiveUpdateId)) {
                data = data.copyWith(isLyricsUpdated: true);
                context.read<DatabaseBloc>().add(UpdateDataEvent(data: data));
              }

              if (state is SuccessfullyFetchedLyricsState && selectedValue == '') {

                lyricsFetched = state.entities;
                lyricsFiltered = state.entities;

              } else {
                if (state is SuccessfullyFilteredLyricsState &&
                    selectedValue != '') {
                  lyricsFiltered = state.entities;
                } else {
                  lyricsFiltered = lyricsFetched;
                }
              }
              // ignore: todo
              //TODO: autor, ano de produçao
              // ignore: todo
              //TODO: ADICIONAR MENSAGEM DE NENHUM RESULTADO ENCONTRADO
              return SafeArea(
                child: SingleChildScrollView(
                  child: RefreshIndicator(
                    color: AppColors.darkGreen,
                    onRefresh: () async {
                      bloc.add(CheckConnectivityEvent(data: data));
                    },
                    child: Column(
                      children: [
                        const TitleTopBarWidget(title: "Músicas/Letras"),
                        /* const Padding(
                          padding: EdgeInsets.only(
                            left: 19,
                            top: 30,
                          ),
                          child: SearchBarWidget(),
                        ),*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 40, left: 17),
                              child: Text(
                                "Adicionados recentemente",
                                style: AppFonts.headlineLyrics,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 27),
                          child: LyricsListWidget(lyricsList: lyricsFiltered),
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
        )
        /*,floatingActionButton: SizedBox(
        height: 58,
        width: 58,
        child: FloatingActionButton(
          elevation: 1.8,
          highlightElevation: 1.8,
          focusElevation: 1.8,
          hoverElevation: 1.8,
          onPressed: () {},
          backgroundColor: AppColors.darkBlue,
          child: const Icon(
            size: 45,
            Icons.add_rounded,
            color: AppColors.white,
          ),
          // icon: Icon(Icons.map, size: 15, color: Colors.white)
        ),
      ),*/
        );
  }
}
