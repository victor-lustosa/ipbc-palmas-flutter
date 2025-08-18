import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class ServicesPreviewView extends StatefulWidget {
  const ServicesPreviewView({super.key});

  @override
  State<ServicesPreviewView> createState() => _ServicesPreviewViewState();
}

class _ServicesPreviewViewState extends State<ServicesPreviewView> {
  final ServicesPreviewStore _servicesPreviewStore =
      Modular.get<ServicesPreviewStore>();
  final EditLyricStore _editLyricStore = Modular.get<EditLyricStore>();
  late final LyricsListStore _lyricsListStore;

  @override
  void initState() {
    super.initState();
    _lyricsListStore = Modular.get<LyricsListStore>();
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
              ServiceTopBarWidget(
                image: _servicesPreviewStore.servicesEntity.image,
                title: "Cultos de ${_servicesPreviewStore.servicesEntity.title}",
              ),
              Container(
                margin: const EdgeInsets.only(top: 24.7, left: 16),
                child: GuidelineWidget(
                  circleColor: AppColors.cardBallsGrey,
                  timelineColor: AppColors.timelineGuideTGreen,
                  liturgiesList: _servicesPreviewStore.serviceEntity.liturgiesList ?? [],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 24.7, left: 16),
                child: Text(
                  'Músicas de ${_servicesPreviewStore.servicesEntity.heading}',
                  style: AppFonts.defaultFont(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: AppColors.grey10,
                  ),
                ),
              ),
              Visibility(
                visible: _editLyricStore.lyricsFetched.isEmpty,
                child: Container(
                  margin: const EdgeInsets.only(top: 4, left: 16, bottom: 24),
                  width: context.sizeOf.width * 0.9,
                  child: Text(
                    'As músicas adicionadas aparecerão aqui. Adicione músicas para este culto:',
                    style: AppFonts.defaultFont(
                      fontSize: 13,
                      color: AppColors.grey8,
                    ),
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _editLyricStore,
                builder: (context, state, child) {
                  return LyricsListWidget(
                    entitiesList: _editLyricStore.lyricsFetched,
                    onTap: () {
                      pushNamed(
                        AppRoutes.lyricsRoute + AppRoutes.lyricRoute,
                        arguments: _lyricsListStore.lyricModel,
                      );
                    },
                    onLongPressStart: (s) {},
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 15.5,
                  right: 15.5,
                  bottom: 40,
                ),
                child: ButtonWidget(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  fixedSize: Size(context.sizeOf.width, 48),
                  action: () => pushNamed(
                    AppRoutes.servicesRoute + AppRoutes.searchLyricsRoute,
                  ),
                  backgroundColor: AppColors.darkGreen,
                  shadowColor: AppColors.grey0,
                  foregroundColor: AppColors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: const Text("Adicionar música"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingButtonWidget(
        iconColor: AppColors.white,
        backgroundColor: AppColors.warning,
        pngIcon: AppIcons.editIcon,
        size: 37,
        action: () {
          popAndPushNamed(
            AppRoutes.servicesRoute + AppRoutes.editLiturgiesRoute,
          );
        },
      ),
    );
  }
}
