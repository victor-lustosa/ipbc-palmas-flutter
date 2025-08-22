import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../service_module.dart';
import '../blocs/services_collection_bloc.dart';

class ServicesCollectionView extends StatefulWidget {
  const ServicesCollectionView({super.key, required this.entity});

  final ServicesEntity entity;

  @override
  State<ServicesCollectionView> createState() => _ServicesCollectionViewState();
}

class _ServicesCollectionViewState extends State<ServicesCollectionView>
    with DateMixin, ValidationAndFormatMixin {
  late final ServicesCollectionBloc _bloc;
  late String path;

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<ServicesCollectionBloc>();
    _bloc.add(GetDataEvent(path: widget.entity.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ServicesCollectionBloc, GenericState<ServicesCollectionState>>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is LoadingState<ServicesCollectionState>) {
            return const LoadingWidget(
              androidRadius: 3,
              iosRadius: 14,
              color: AppColors.darkGreen,
            );
          } else if (state is NoConnectionState<ServicesCollectionState>) {
            return NoConnectionView(
              action: () => nativePushReplacementNamed(
                AppRoutes.servicesCollectionRoute,
                context,
              ),
            );
          } else if (state
              is DataFetchedState<
                ServicesCollectionState,
                List<ServiceEntity>
              >) {
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: SingleChildScrollView(
                child: SizedBox(
                  width: context.sizeOf.width,
                  child: Column(
                    children: [
                      ServiceTopBarWidget(
                        image: widget.entity.image,
                        title: "Cultos de ${widget.entity.heading}",
                      ),
                      _bloc.entitiesList.isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.only(
                                top: 24,
                                left: 15.5,
                                right: 15.5,
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
                                  final service = _bloc.entitiesList[index];
                                  final Key itemKey = Key('${service.id}');
                                  final GlobalKey gestureKey = GlobalKey();
                                  return GestureDetector(
                                    key: gestureKey,
                                    onTap: () {
                                      nativePushNamed(
                                        AppRoutes.serviceRoute,
                                        arguments: ServiceViewDTO(
                                          service: _bloc.entitiesList[index],
                                          image: widget.entity.image,
                                        ),
                                        context,
                                      );
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
                                                _bloc.editItem(
                                                  index: index,
                                                  servicesEntity: widget.entity,
                                                );
                                                pop(context);
                                              },
                                            ),
                                            Divider(
                                              height: 1,
                                              color: AppColors.dividerModal
                                                  .withValues(alpha: .3),
                                            ),
                                            actionButton(
                                              context: context,
                                              top: 12,
                                              bottom: 12,
                                              icon: AppIcons.trash,
                                              label: 'Deletar',
                                              action: () async {
                                                _bloc.add(
                                                  DeleteItemEvent(index: index),
                                                );
                                                if (context.mounted) {
                                                  pop(context);
                                                }
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
                                            ? AppColors.highlightGreen
                                                  .withValues(alpha: .1)
                                            : AppColors.grey0,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                              left: 16,
                                              top: 12,
                                              bottom: 12,
                                            ),
                                            width: context.sizeOf.width * .77,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  '${_bloc.entitiesList[index].title} ${formatDateToString(_bloc.entitiesList[index].serviceDate)} | ${formatHourToString(date: _bloc.entitiesList[index].serviceDate)}',
                                                  style: AppFonts.defaultFont(
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.grey9,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                    bottom: 4,
                                                    top: 4,
                                                  ),
                                                  child: Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    'Mensagem: ${_bloc.entitiesList[index].theme}',
                                                    style: AppFonts.description(
                                                      color: AppColors.grey8,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  _bloc
                                                      .entitiesList[index]
                                                      .preacher,
                                                  style: AppFonts.description(
                                                    color: AppColors.grey8,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButtonWidget(
                                            size: Platform.isIOS ? 28 : 32,
                                            color: AppColors.darkGreen,
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            iOSIcon:
                                                CupertinoIcons.chevron_forward,
                                            androidIcon:
                                                Icons.navigate_next_sharp,
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
          _bloc.addItem(servicesEntity: widget.entity);
        },
      ),
    );
  }
}
