import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../blocs/lyric_bloc.dart';
import '../domain/use-cases/lyrics_use_cases.dart';
import '../domain/entities/lyric_entity.dart';
import '../../shared/components/side-bar/side_bar_widget.dart';
import '../../shared/components/top-bar/top_bar_widget.dart';
import '../../core/infra/repositories/repository.dart';
import '../../shared/configs/app_fonts.dart';
import '../../shared/configs/app_colors.dart';
import '../../shared/configs/app_icons.dart';
import '../../shared/configs/app_routes.dart';

class LyricsListView extends StatefulWidget {
  const LyricsListView({super.key});

  @override
  State<LyricsListView> createState() => _LyricsListViewState();
}

class _LyricsListViewState extends State<LyricsListView> {
  late List<LyricEntity> lyricsFetched;
  late List<LyricEntity> lyricsFiltered;
  late List<String> lettersCarousel;
  late List<String> drawerNames;
  late LyricBloc bloc;
  bool isSelected = false;
  String selectedValue = '';
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
    var aCode = 'A'.codeUnitAt(0);
    var zCode = 'Z'.codeUnitAt(0);
    lettersCarousel = List<String>.generate(
      zCode - aCode + 1,
      (index) => String.fromCharCode(aCode + index),
    );
  }

  @override
  void initState() {
    lyricsFetched = [];
    lyricsFiltered = [];
    lettersCarousel = [];
    fillLettersCarousel();
    bloc = LyricBloc(
        lyricsUseCase: LyricsUseCases(
            repository: context.read<Repository<LyricEntity>>()));
    bloc.add(GetLyricsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.black12,
      appBar: TopBarWidget(),
      endDrawer: SideBarWidget(drawerNames: drawerNames),
      drawerEnableOpenDragGesture: true,
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocBuilder<LyricBloc, LyricState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is InitialState) {
                return const Center(child:CircularProgressIndicator(
                   valueColor: AlwaysStoppedAnimation<Color>(
                       AppColors.darkGreen)));
              } else if (state is SuccessfullyFetchedLyricsState ||
                  state is SuccessfullyFilteredLyricsState) {
                if (state is SuccessfullyFetchedLyricsState &&
                    selectedValue == '') {
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
                //TODO: autor, ano de produçao, todos os diretos reservados
                //TODO: ADICIONAR MENSAGEM DE NENHUM RESULTADO ENCONTRADO
                return SingleChildScrollView(
                  child: RefreshIndicator(
                    color: AppColors.darkGreen,
                    onRefresh: () async {
                      bloc.add(GetLyricsEvent());
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Row(
                            children: [
                              /*Column(
                                children: const [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        size: 40,
                                        Icons.navigate_before_rounded,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),*/
                              Padding(
                                padding: const EdgeInsets.only(bottom: 33.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 28.0),
                                      child: SvgPicture.asset(
                                        AppIcons.lyricsIconName,
                                        color: AppColors.black,
                                        matchTextDirection: true,
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text("Músicas/Letras",
                                            style: AppFonts.h2)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 26.0),
                          child: SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: lettersCarousel.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      width: lettersCarousel[index] ==
                                                  selectedValue &&
                                              isSelected
                                          ? 50
                                          : 40,
                                      child: ElevatedButton(
                                          onPressed: () => {
                                                setState(() {
                                                  if (!isSelected) {
                                                    selectedValue =
                                                        lettersCarousel[index];
                                                    isSelected = true;
                                                    bloc.add(LyricsFilterEvent(
                                                        letter: lettersCarousel[
                                                            index],
                                                        lyrics: lyricsFetched));
                                                  } else {
                                                    isSelected = false;
                                                    selectedValue = '';
                                                    lyricsFiltered =
                                                        lyricsFetched;
                                                  }
                                                })
                                              },
                                          style: ButtonStyle(
                                            overlayColor:
                                                MaterialStateProperty.all(
                                                    AppColors.darkGreen),
                                            elevation:
                                                const MaterialStatePropertyAll(
                                                    0),
                                            shape: MaterialStateProperty.all(
                                                const CircleBorder()),
                                            padding: MaterialStateProperty.all(
                                                const EdgeInsets.all(0)),
                                            backgroundColor: MaterialStateProperty
                                                .all(lettersCarousel[index] ==
                                                            selectedValue &&
                                                        isSelected
                                                    ? AppColors.darkGreen
                                                    : AppColors
                                                        .white), // <-- Button color
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                  child: Text(
                                                      lettersCarousel[index],
                                                      style: lettersCarousel[
                                                                      index] ==
                                                                  selectedValue &&
                                                              isSelected
                                                          ? AppFonts
                                                              .carouselGreen
                                                          : AppFonts
                                                              .carouselWhite)),
                                            ],
                                          )),
                                    );
                                  })),
                        ),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: lyricsFiltered.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 28, right: 28),
                                child: Container(
                                  decoration: lyricsFiltered.length ==
                                              index + 1 &&
                                          lyricsFiltered.length > 1
                                      ? const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(width: 0.1)))
                                      : const BoxDecoration(
                                          border: Border(
                                              top: BorderSide(width: 0.1),
                                              bottom: BorderSide(width: 0.1))),
                                  child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 0),
                                      title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                    '${lyricsFiltered[index].title} - ${lyricsFiltered[index].group}',
                                                    style: AppFonts.body),
                                              ],
                                            ),
                                            Column(children: [
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(context,
                                                      AppRoutes.lyricRoute,
                                                      arguments: lyricsFiltered[
                                                          index]);
                                                },
                                                icon: const Icon(
                                                  size: 33,
                                                  Icons.navigate_next_outlined,
                                                  color: AppColors.darkGreen,
                                                ),
                                              )
                                            ])
                                          ]),
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.lyricRoute,
                                            arguments: lyricsFiltered[index]);
                                      }),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                );
              } else {
                return Text('aconteceu um erro [Establishment_page_one]');
              }
            }),
      ),
    );
  }
}
