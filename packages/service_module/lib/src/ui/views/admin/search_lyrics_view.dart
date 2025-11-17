import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/dialogs/admin/add_lyrics_dialog_widget.dart';

class SearchLyricsView extends StatefulWidget {
  const SearchLyricsView({super.key});

  @override
  State<SearchLyricsView> createState() => _SearchLyricsViewState();
}

class _SearchLyricsViewState extends State<SearchLyricsView> {
  late final SearchLyricsStore _store;
  @override
  void initState() {
    super.initState();
    _store = Modular.get<SearchLyricsStore>();
  }
  loadingWidget(BuildContext context) =>  SizedBox(
      height: context.sizeOf.height * .4,
      width: context.sizeOf.width,
      child: const LoadingWidget(
        androidRadius: 3,
        iosRadius: 14,
        color: AppColors.darkGreen,
      ),
  );

  lyricNotFound(BuildContext context) => Container(
    margin: const EdgeInsets.only(top: 150),
    child: SizedBox(
      width: context.sizeOf.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 26,
            height: 26,
            child: Image.asset(
              AppIcons.info,
              color: Colors.blueAccent,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            width: context.sizeOf.width * .6,
            child: Text(
              textAlign: TextAlign.center,
              style: AppFonts.defaultFont(
                fontSize: ResponsivityUtil<double>(sm: 13, xl: 14).get(context),
                color: AppColors.grey9,
              ),
              'Nenhuma música encontrada.',
            ),
          ),
        ],
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Container(
                color: AppColors.white,
                width: context.sizeOf.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ServiceTopBarWidget(
                      image: _store.servicesEntity.image,
                      title: "Voltar para liturgia",
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 16,
                        top: 24.7,
                        bottom: 16,
                      ),
                      child: Text(
                        'Selecione a música do culto:',
                        style: AppFonts.defaultFont(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: AppColors.grey10,
                        ),
                      ),
                    ),
                    SearchWidget(),
                    ValueListenableBuilder(
                      valueListenable: _store,
                      builder: (_, state, child) {
                        if (state is InitialState) {
                          return Container(
                            margin: EdgeInsets.only(top: context.sizeOf.height * .15),
                            child: SizedBox(
                              width: context.sizeOf.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 26,
                                    height: 26,
                                    child: Image.asset(
                                      AppIcons.info,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    width: context.sizeOf.width * .6,
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      style: AppFonts.defaultFont(
                                        fontSize: ResponsivityUtil<double>(sm: 13, xl: 14).get(context),
                                        color: AppColors.grey9,
                                      ),  
                                      'As músicas que você pesquisar aparecerão aqui',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (state is SearchSuccessState ||
                            state is NotFoundState || state is LoadingState) {
                          if (state is SearchSuccessState) {
                            if(_store.lyricsListStore.entitiesList.isNotEmpty){
                            return Column(
                              children: [
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          top: 24,
                                          left: 17,
                                        ),
                                        child: Text(
                                          "Resultados Encontrados",
                                          style: AppFonts.defaultFont(
                                            color: AppColors.grey12,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 14),
                                  child: ValueListenableBuilder(
                                    valueListenable: _store.lyricsListStore,
                                    builder: (context, state, child) {
                                      return Visibility(
                                        visible: _store.lyricsListStore
                                            .entitiesList.isNotEmpty,
                                        child: LyricsListWidget(
                                          onTap: () {
                                            pushNamed(
                                              AppRoutes.lyricsRoute +
                                                  AppRoutes.lyricRoute,
                                              arguments:
                                              _store.lyricsListStore
                                                  .lyricEntity,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                            } else {
                              return Container(
                                margin: const EdgeInsets.only(top: 150),
                                child: SizedBox(
                                  width: context.sizeOf.width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 26,
                                        height: 26,
                                        child: Image.asset(
                                          AppIcons.info,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        width: context.sizeOf.width * .6,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          style: AppFonts.defaultFont(
                                            fontSize: 13,
                                            color: AppColors.grey9,
                                          ),
                                          'Nenhuma música encontrada.',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          } else if (state is LoadingState) {
                            return loadingWidget(context);
                          } else {
                            return lyricNotFound(context);
                          }
                        } else {
                          return loadingWidget(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingButtonWidget(
          iconColor: AppColors.white,
          backgroundColor: AppColors.add,
          icon: Icons.add,
          action: () {
            showAddLyricsDialog(
              context: context,
              callback: (text) {
                _store.newLyric(text, context);
              },
            );
          },
        ),
      ),
    );
  }
}
