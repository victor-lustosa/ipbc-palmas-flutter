import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipbc_palmas/app/shared/components/utils/validation_util.dart';
import '../../../exception/views/generic_error_view.dart';
//import '../../../shared/components/search-bar/search_bar_widget.dart';
import '../../../exception/views/no_connection_view.dart';
import '../../../shared/components/loading/loading_widget.dart';
import '../../../configs/app_configs.dart';
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
    bloc.add(LoadingEvent());
    if (context.read<ValidationUtil>().validateLyrics(context)) {
      bloc.add(CheckConnectivityEvent());
    } else {
      bloc.add(GetLyricsInHiveEvent());
    }
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
            } else if (state is SuccessfullyFetchedLyricsState ) {
              lyricsFetched = state.entities;
              data = context.read<HiveDatabaseConfigsDTO>();
              if (!(data.isLyricsUpdated)) {
                bloc.add(UpdateLyricsInHiveEvent(entities: state.entities));
                data = data.copyWith(isLyricsUpdated: true);
                context.read<DatabaseBloc>().add(UpdateDataEvent(data: data));
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
                      bloc.add(CheckConnectivityEvent());
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
                          child: LyricsListWidget(lyricsList: lyricsFetched),
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
