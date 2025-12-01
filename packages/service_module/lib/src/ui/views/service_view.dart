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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: _store,
                        builder: (_, state, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ServiceTopBarWidget(
                                backAction: () {
                                  if (_store.updateServicesCollectionCallback !=
                                          null &&
                                      _store.isChanged.value) {
                                    _store.isChanged.value = false;
                                    _store.updateServicesCollectionCallback!(
                                      context,
                                    );
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
                          );
                        },
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
                            Container(
                              margin: const EdgeInsets.only(
                                top: 24,
                                bottom: 24,
                              ),
                              child: ValueListenableBuilder(
                                valueListenable: _store.manageLyricStore,
                                builder: (context, state, child) {
                                  return Column(
                                    children: [
                                      Visibility(
                                        visible:
                                            _store.entitiesList.isEmpty &&
                                            _store.isAdmin.value,
                                        child: SizedBox(
                                          width: context.sizeOf.width * .86,
                                          child: Text(
                                            'As músicas adicionadas aparecerão aqui. Adicione músicas para este culto.',
                                            style: AppFonts.defaultFont(
                                              fontSize: 13,
                                              color: AppColors.grey8,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: _store.entitiesList.isNotEmpty,
                                        child: LyricsListWidget(
                                          entitiesList: _store.entitiesList,
                                          isTitleVisible: false,
                                          onLongPressStart: (details) async {
                                            await showOptionsDialog(
                                              context: context,
                                              itemKey: _store
                                                  .lyricsListStore
                                                  .itemKey,
                                              popupHeightParam: 110,
                                              popupWidthParam: 160,
                                              popupWidthPositionParam: 160,
                                              verticalMarginParam: 5,
                                              buttons: Column(
                                                children: [
                                                  actionButton(
                                                    context: context,
                                                    top: 12,
                                                    bottom: 12,
                                                    icon: AppIcons.edit,
                                                    label: 'Editar',
                                                    action: () {
                                                      _store.editLyric(context);
                                                    },
                                                  ),
                                                  Divider(
                                                    height: 1,
                                                    color: AppColors
                                                        .dividerModal
                                                        .withValues(alpha: .3),
                                                  ),
                                                  actionButton(
                                                    context: context,
                                                    top: 12,
                                                    bottom: 12,
                                                    icon: AppIcons.trash,
                                                    label: 'Deletar',
                                                    action: () async {
                                                      await showConfirmationDialog(
                                                        confirmAction: () async {
                                                              _store.deleteLyric(context);
                                                            },
                                                        title: "Deletar Letra",
                                                        message: "O item será deletado da lista. Tem certeza?",
                                                        context: context,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                            _store
                                                    .lyricsListStore
                                                    .tappedIndex
                                                    .value =
                                                null;
                                          },
                                          margin: EdgeInsets.zero,
                                          onTap: () {
                                            pushNamed(
                                              AppRoutes.lyricsRoute +
                                                  AppRoutes.lyricRoute,
                                              arguments: _store
                                                  .lyricsListStore
                                                  .selectedLyric,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Visibility(
                              visible: _store.isAdmin.value,
                              child: ButtonWidget(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                fixedSize: Size(context.sizeOf.width, 48),
                                action: () {
                                  _store.addLyric();
                                },
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
            iconPath: AppIcons.editIcon,
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
