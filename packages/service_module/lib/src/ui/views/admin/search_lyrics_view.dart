import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../../../service_module.dart';

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
                  'Selecione as músicas do culto:',
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
              Visibility(
                visible: false,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 16, top: 38),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Image.asset(AppIcons.info),
                          ),
                          Container(
                            width: context.sizeOf.width * .83,
                            margin: const EdgeInsets.only(left: 12),
                            child: Text(
                              style: AppFonts.defaultFont(
                                fontSize: 13,
                                color: AppColors.grey9,
                              ),
                              'Esta música ainda não está salva na biblioteca. Incluir música da internet?',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 24, left: 17),
                          child: Text(
                            "Pesquisa da internet",
                            style: AppFonts.defaultFont(
                              color: AppColors.grey12,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: true,
                child: Container(
                  margin: const EdgeInsets.only( top: 150),
                  child: SizedBox(
                    width: context.sizeOf.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 26,
                          height: 26,
                          child: Image.asset(AppIcons.info,color: Colors.blueAccent,),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
