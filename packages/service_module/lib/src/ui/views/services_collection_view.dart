import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../blocs/services_collection_bloc.dart';

class ServicesCollectionView extends StatefulWidget {
  const ServicesCollectionView({super.key, required this.entity});

  final ServicesEntity entity;

  @override
  State<ServicesCollectionView> createState() => _ServicesCollectionViewState();
}

class _ServicesCollectionViewState extends State<ServicesCollectionView>
    with DateMixin, FormatMixin {
  late final ServicesCollectionBloc _bloc;
  final Map<String, GlobalKey> _gestureKeys = {};
  late String path;

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<ServicesCollectionBloc>();
    _bloc.path = widget.entity.path;
    _bloc.manageServiceStore.servicesEntity = widget.entity;
    _bloc.add(GetDataEvent(context: context));
  }

  @override
  void dispose() {
    _gestureKeys.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loadingWidget = const LoadingWidget(
      androidRadius: 3,
      iosRadius: 14,
      color: AppColors.darkGreen,
    );
    return Scaffold(
      body: BlocBuilder<ServicesCollectionBloc, GenericState<ServicesCollectionState>>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is LoadingState<ServicesCollectionState>) {
            return loadingWidget;
          } else if (state is NoConnectionState<ServicesCollectionState>) {
            return NoConnectionView(
              action: () =>
                  nativePushReplacementNamed(AppRoutes.homeRoute, context),
            );
          } else if (state is DataFetchedState<ServicesCollectionState> ||
              state is UpdateServicesListState) {
            final currentIds = _bloc.entitiesList.map((e) => e.id!).toSet();
            _gestureKeys.removeWhere((key, _) => !currentIds.contains(key));

            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.dark,
              child: SafeArea(
                bottom: false,
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: context.sizeOf.width,
                    child: Column(
                      children: [
                        ServiceTopBarWidget(
                          image: widget.entity.image,
                          title: "Cultos de ${widget.entity.heading}",
                        ),
                        (state is UpdateServicesListState)
                            ? SizedBox(
                                height: context.sizeOf.height * .6,
                                child: loadingWidget,
                              )
                            : _bloc.entitiesList.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(
                                  top: 24,
                                  left: 16,
                                  right: 16,
                                  bottom: 30,
                                ),
                                child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                        return const SizedBox(height: 16);
                                      },
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: _bloc.entitiesList.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final ServiceEntity service =
                                        _bloc.entitiesList[index];
                                    final Key itemKey = Key(service.id!);
                                    final GlobalKey gestureKey = _gestureKeys
                                        .putIfAbsent(
                                          service.id!,
                                          () => GlobalKey(),
                                        );

                                    return GestureDetector(
                                      key: gestureKey,
                                      onTap: () {
                                        _bloc.toService(widget.entity, service);
                                      },
                                      onLongPressStart: (_) async {
                                        await showOptionsDialog(
                                          context: context,
                                          itemKey: gestureKey,
                                          popupHeightParam: 110,
                                          popupWidthParam: 160,
                                          popupWidthPositionParam: 160,
                                          verticalMarginParam: 3,
                                          buttons: Column(
                                            children: [
                                              actionButton(
                                                context: context,
                                                top: 12,
                                                bottom: 12,
                                                icon: AppIcons.edit,
                                                label: 'Editar',
                                                action: () {
                                                  _bloc.editItem(index: index);
                                                  pop(context);
                                                },
                                              ),
                                              Divider(
                                                height: 1,
                                                color: AppColors.dividerModal.withValues(alpha: .3),
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
                                                        _bloc.add(
                                                          DeleteItemEvent(
                                                            index: index,
                                                            context: context,
                                                          ),
                                                        );
                                                      },
                                                      title: "Deletar Culto",
                                                      message: "O culto será deletado permanentemente. Tem certeza?",
                                                      context: context,);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Container(
                                        key: itemKey,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: index == 0
                                              ? AppColors.highlightGreen.withValues(alpha: .1)
                                              : AppColors.grey0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 16,
                                                top: 16,
                                                bottom: 16,
                                              ),
                                              width: ResponsivityUtil(sm:context.sizeOf.width * .76, xl:context.sizeOf.width * .8).get(context),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    '${_bloc.entitiesList[index].title} ${formatDateToString(_bloc.entitiesList[index].serviceDate)} | ${formatHourToString(date: _bloc.entitiesList[index].serviceDate)}',
                                                    style: AppFonts.defaultFont(
                                                      fontWeight: FontWeight.w600,
                                                      color: AppColors.grey9,
                                                      fontSize: ResponsivityUtil<double>(sm: 15, xl: 16).get(context),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                          bottom: 4,
                                                          top: 4,
                                                        ),
                                                    child: Text(
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      'Mensagem: ${_bloc.entitiesList[index].theme}',
                                                      style:
                                                          AppFonts.description(
                                                            color: AppColors.grey8,
                                                            fontSize: ResponsivityUtil<double>(sm: 13, xl: 14).get(context),
                                                          ),
                                                    ),
                                                  ),
                                                  Text(
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    _bloc.entitiesList[index].preacher,
                                                    style:
                                                        AppFonts.description(
                                                          color: AppColors.grey8,
                                                          fontSize: ResponsivityUtil<double>(sm: 13, xl: 14).get(context),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                right: 16,
                                              ),
                                              child: IconButtonWidget(
                                                sizeIcon: ResponsivityUtil<double>(sm: 21, xl: 23).get(context),
                                                color: AppColors.darkGreen,
                                                iconFormat: IconFormat.svg,
                                                iconPath: AppIcons.arrowForward,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(top: 150),
                                child: SizedBox(
                                  width: context.sizeOf.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          'Não há cultos cadastrados.',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const GenericErrorView();
          }
        },
      ),
      floatingActionButton: FloatingButtonWidget(
        iconColor: AppColors.white,
        backgroundColor: AppColors.add,
        icon: Icons.add,
        action: () {
          _bloc.addItem();
        },
      ),
    );
  }
}
