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
  final TextEditingController controller = TextEditingController();
  late final List<LyricEntity> _lyricsFetched = [
    LyricEntity(
      id: '1',
      title: '',
      createAt: DateTime.now(),
      albumCover: 'assets/images/default_cover_4.png',
      group: '',
      verses: [],
    ),
  ];

  @override
  void initState() {
    super.initState();
    setDarkAppBar();
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
                child: const OwnChoiceChipsWidget(),
              ),
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
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: LyricsListWidget(entitiesList: _lyricsFetched),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
