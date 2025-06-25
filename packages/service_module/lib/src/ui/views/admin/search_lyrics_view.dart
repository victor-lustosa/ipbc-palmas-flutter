import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../../../service_module.dart';
import '../../components/dialogs/admin/add_lyrics_dialog_widget.dart';
import '../../stores/admin/search_lyrics_store.dart';

class SearchLyricsView extends StatefulWidget {
  const SearchLyricsView({super.key, required this.dto});

  final EditLiturgyDTO dto;

  @override
  State<SearchLyricsView> createState() => _SearchLyricsViewState();
}

class _SearchLyricsViewState extends State<SearchLyricsView> {
  bool isSelected = false;
  String selectedValue = '';
  int selectedIndex = 0;
  final TextEditingController controller = TextEditingController();
  late final List<LyricEntity> _lyricsFetched = [LyricModel.empty()];
  final SearchLyricsStore _store = Modular.get<SearchLyricsStore>();

  @override
  void initState() {
    super.initState();
    setDarkAppBar();
  }

  int selectOptions(int index) {
    selectedIndex = index;
    return selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.white,
          width: context.sizeOf.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ServiceTopBarWidget(image: widget.dto.image),
              Container(
                margin: const EdgeInsets.only(
                  left: 16.5,
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
              Container(
                margin: const EdgeInsets.only(bottom: 13),
                child: SearchBarWidget(controller: controller, action: () {}),
              ),
              Container(
                margin: const EdgeInsets.only(left: 21.5),
                child: OwnChoiceChipsWidget(
                  isInitWithoutSelection: true,
                  action: selectOptions,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _store,
                builder: (_, state, child) {
                  if (state is InitialState) {
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
                                'As músicas que você pesquisar aparecerão aqui',
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is SearchSuccessState || state is NotFoundState) {
                    if (state is SearchSuccessState) {
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
                        ],
                      );
                    }
                    else {
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
                  } else {
                    return const LoadingWidget(
                      androidRadius: 3,
                      iosRadius: 14,
                      color: AppColors.darkGreen,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingButtonWidget(
        iconColor: AppColors.white,
        backgroundColor: AppColors.add,
        icon: Icons.add,
        action:
            () => showAddLyricsDialog(
                context: context, callback: (text) {
                  if (text != null && text.isNotEmpty) {
                    _store.convertTextInLyric(text);
                  }
            })
      ),
    );
  }
}
