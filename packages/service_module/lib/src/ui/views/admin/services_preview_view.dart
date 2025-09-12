import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class ServicesPreviewView extends StatefulWidget {
  const ServicesPreviewView({super.key});

  @override
  State<ServicesPreviewView> createState() => _ServicesPreviewViewState();
}

class _ServicesPreviewViewState extends State<ServicesPreviewView>
    with DateMixin {
  late final ServicesPreviewStore _store;

  @override
  void initState() {
    super.initState();
    _store = Modular.get<ServicesPreviewStore>();
    setLightAppBar();
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
                image: _store.serviceEntity.image!,
                title: "Cultos de ${_store.serviceEntity.title}",
                dateIsVisible: _store.serviceEntity.guideIsVisible,
                createAt: formatDateToString(_store.serviceEntity.createAt),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 4, top: 20, left: 20),
                child: Column(
                  children: [
                    Text(
                      maxLines: 2,
                      'Preletor: ${_store.serviceEntity.preacher}',
                      style: AppFonts.description(color: AppColors.grey8),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 14),
                      child: Text(
                        maxLines: 2,
                        'Mensagem: ${_store.serviceEntity.theme}',
                        style: AppFonts.description(color: AppColors.grey8),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _store.serviceEntity.guideIsVisible,
                child: Container(
                  margin: const EdgeInsets.only(top: 25, left: 16),
                  child: GuidelineWidget(
                    circleColor: AppColors.cardBallsGrey,
                    timelineColor: AppColors.timelineGuideTGreen,
                    liturgiesList: _store.serviceEntity.liturgiesList ?? [],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40, left: 16),
                child: Text(
                  'Músicas de ${_store.servicesEntity.heading}',
                  style: AppFonts.defaultFont(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: AppColors.grey10,
                  ),
                ),
              ),
              Visibility(
                visible:
                    _store.manageLyricStore.lyricsFetched.isEmpty &&
                    _store.isAdmin.value,
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
                valueListenable: _store.manageLyricStore,
                builder: (context, state, child) {
                  return LyricsListWidget(
                    entitiesList: _store.manageLyricStore.lyricsFetched,
                    onTap: () {
                      pushNamed(
                        AppRoutes.lyricsRoute + AppRoutes.lyricRoute,
                        arguments: _store.lyricsListStore.lyricModel,
                      );
                    },
                    onLongPressStart: (s) {},
                  );
                },
              ),
              Visibility(
                visible: _store.isAdmin.value,
                child: Container(
                  margin: const EdgeInsets.only(left: 16, right: 16),
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
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: _store.isAdmin.value,
        child: FloatingButtonWidget(
          iconColor: AppColors.white,
          backgroundColor: AppColors.warning,
          pngIcon: AppIcons.editIcon,
          size: 37,
          action: () {
            popAndPushNamed(
              AppRoutes.servicesRoute + AppRoutes.manageServicesRoute,
            );
          },
        ),
      ),
    );
  }
}
