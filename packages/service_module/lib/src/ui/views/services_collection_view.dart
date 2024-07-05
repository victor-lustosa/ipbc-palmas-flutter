import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../service_module.dart';
import '../blocs/services_collection_bloc.dart';

class ServicesCollectionView extends StatefulWidget {
  const ServicesCollectionView({Key? key, required this.entity})
      : super(key: key);
  final ServicesEntity entity;

  @override
  State<ServicesCollectionView> createState() => _ServicesCollectionViewState();
}

class _ServicesCollectionViewState extends State<ServicesCollectionView> {
  late final ServicesCollectionBloc _bloc;
  late List<ServiceEntity> entitiesList;
  late String path;

  @override
  void initState() {
    super.initState();
    entitiesList = [];
    path = widget.entity.path;
    _bloc = Modular.get<ServicesCollectionBloc>();
    _bloc.add(CheckConnectivityEvent(path: path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ServicesCollectionBloc,
          GenericState<ServicesCollectionState>>(
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
              action: () => nativeNavigate(
                ServiceModule.servicesCollectionRoute,
                context,
              ),
            );
          } else if (state
              is DataFetchedState<ServicesCollectionState, ServiceEntity>) {
            entitiesList = state.entities;
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
                      Container(
                        margin: const EdgeInsets.only(
                          top:24,
                          left: 15.5,
                          right: 15.5,
                        ),
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 16);
                          },
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: entitiesList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Material(
                              borderRadius: BorderRadius.circular(16),
                              clipBehavior: Clip.hardEdge,
                              color: index == 0
                                  ? AppColors.highlightGreen.withOpacity(0.1)
                                  : AppColors.grey0,
                              child: InkWell(
                                onTap: () {
                                  nativePushNamed(
                                      ServiceModule.serviceRoute,
                                      arguments: ServiceViewDTO(
                                        service: entitiesList[index],
                                        image: widget.entity.image,
                                      ),
                                      context);
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                        left: 16,
                                        top: 12,
                                        bottom: 12,
                                      ),
                                      width:
                                          context.sizeOf.width * .77,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            '${entitiesList[index].title} ${DateFormat('dd/MM/yyyy').format(entitiesList[index].createAt)} | ${widget.entity.hour}',
                                            style: AppFonts.defaultFont(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.grey9,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 4, top: 4),
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              'Messagem: ${entitiesList[index].theme}',
                                              style: AppFonts.description(
                                                color: AppColors.grey8,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            entitiesList[index].preacher,
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
                                      iOSIcon: CupertinoIcons.chevron_forward,
                                      androidIcon: Icons.navigate_next_sharp,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
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
        action: () => pushNamed(
          ServiceModule.servicesRoute + ServiceModule.editLiturgiesRoute,
          arguments: EditLiturgyDTO(
            image: widget.entity.image,
            heading: widget.entity.heading,
          ),
        ),
      ),
    );
  }
}
