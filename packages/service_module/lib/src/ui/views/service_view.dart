import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServiceView extends StatefulWidget {
  const ServiceView({super.key});

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> with DateMixin {
  late final ServiceStore _store;

  @override
  void initState() {
    super.initState();
    _store = Modular.get<ServiceStore>();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: ValueListenableBuilder(
                    valueListenable: _store,
                    builder: (_, state, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ServiceTopBarWidget(
                                backAction: () {
                                  if (_store.updateServicesCollectionCallback !=
                                          null &&
                                      _store.isChanged.value) {
                                    _store.isChanged.value = false;
                                    _store.updateServicesCollectionCallback!();
                                  }
                                  nativePop(context);
                                },
                                image: _store.serviceEntity.image!,
                                title:
                                    "Cultos de ${_store.serviceEntity.title}",
                                dateIsVisible:
                                    _store.serviceEntity.guideIsVisible,
                                createAt: formatDateToString(
                                  _store.serviceEntity.createAt,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 30,
                                  left: 16,
                                  right: 16,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      maxLines: 2,
                                      'Mensagem: ${_store.serviceEntity.theme}',
                                      style: AppFonts.defaultFont(
                                        fontSize: 17,
                                        color: AppColors.grey9,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 14),
                                      child: Text(
                                        maxLines: 2,
                                        'Preletor: ${_store.serviceEntity.preacher}',
                                        style: AppFonts.defaultFont(
                                          fontSize: 17,
                                          color: AppColors.grey9,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          _store.serviceEntity.guideIsVisible,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 15),
                                        child: GuidelineWidget(
                                          circleColor: AppColors.cardBallsGrey,
                                          timelineColor:
                                              AppColors.timelineGuideTGreen,
                                          liturgiesList:
                                              _store
                                                  .serviceEntity
                                                  .liturgiesList ??
                                              [],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 30),
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
                                      _store
                                          .manageLyricStore
                                          .lyricsFetched
                                          .isEmpty &&
                                      _store.isAdmin.value,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      top: 4,
                                      bottom: 25,
                                    ),
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
                                Visibility(
                                  visible: _store
                                      .manageLyricStore
                                      .lyricsFetched
                                      .isNotEmpty,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      bottom: 24,
                                      top: 24,
                                    ),
                                    child: ValueListenableBuilder(
                                      valueListenable: _store.manageLyricStore,
                                      builder: (context, state, child) {
                                        return LyricsListWidget(
                                          margin: EdgeInsets.zero,
                                          entitiesList: _store
                                              .manageLyricStore
                                              .lyricsFetched,
                                          onTap: () {
                                            pushNamed(
                                              AppRoutes.lyricsRoute +
                                                  AppRoutes.lyricRoute,
                                              arguments: _store
                                                  .lyricsListStore
                                                  .lyricModel,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: _store.isAdmin.value,
                                  child: ButtonWidget(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    fixedSize: Size(context.sizeOf.width, 48),
                                    action: () => pushNamed(
                                      AppRoutes.servicesRoute +
                                          AppRoutes.searchLyricsRoute,
                                    ),
                                    backgroundColor: AppColors.darkGreen,
                                    shadowColor: AppColors.grey0,
                                    foregroundColor: AppColors.white,
                                    child: const Text("Adicionar música"),
                                  ),
                                ),
                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
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
              _store.edit();
            },
          ),
        ),
      ),
    );
  }
}
