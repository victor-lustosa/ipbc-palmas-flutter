import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../home/home_module.dart';
import '../../shared/blocs/generics.dart';
import '../../shared/view-models/database_view_model.dart';
import 'service_view.dart';
import '../blocs/services_collection_bloc.dart';
import '../../exception/views/generic_error_view.dart';
import '../../exception/views/no_connection_view.dart';

class ServicesCollectionView extends StatefulWidget {
  const ServicesCollectionView({Key? key, required this.entity})
      : super(key: key);
  final ServicesEntity entity;

  @override
  State<ServicesCollectionView> createState() => _ServicesCollectionViewState();
}

class _ServicesCollectionViewState extends State<ServicesCollectionView> {
  late final ServicesCollectionBloc bloc;
  late List<ServiceEntity> entitiesList;
  late String path;

  @override
  void initState() {
    super.initState();
    entitiesList = [];
    path = widget.entity.path;
    bloc = Modular.get<ServicesCollectionBloc>();
    if (Modular.get<DatabaseViewModel>().isNotUpdated(path)) {
      bloc.add(CheckConnectivityEvent(path: path));
    } else {
      bloc.add(GetInHiveEvent(path: path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Theme(
            data: ThemeData(
              splashColor: const Color(0x66C8C8C8),
              highlightColor: const Color(0x66BCBCBC),
            ),
            child: BlocBuilder<ServicesCollectionBloc, GenericState<ServicesCollectionState>>(
              bloc: bloc,
              builder: (context, state) {
               if (state is LoadingState<ServicesCollectionState>) {
                  return const LoadingWidget();
                } else if (state is NoConnectionState<ServicesCollectionState>) {
                  return const NoConnectionView(index: 0);
                } else if (state is DataFetchedState<ServicesCollectionState, ServiceEntity>) {
                  entitiesList = state.entities;
                  Modular.get<DatabaseViewModel>().checkUpdateData(context, path);
                  return Column(
                    children: [
                      Container(
                        height: 186,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              widget.entity.image,
                            ),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 5,
                            right: 8,
                            bottom: 8,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButtonWidget(
                                        size: Platform.isIOS ? null : 28,
                                        color: AppColors.white,
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        iOSIcon: CupertinoIcons.chevron_back,
                                        androidIcon: Icons.arrow_back_rounded,
                                        action: () => Navigator.pop(context),
                                      ),
                                      Text(
                                        "Cultos de ${widget.entity.heading}",
                                        style: AppFonts.defaultFont(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 25,
                          left: 16,
                          right: 16,
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ListView.separated(
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(height: 16);
                            },
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: entitiesList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Material(
                                borderRadius: BorderRadius.circular(16),
                                clipBehavior: Clip.hardEdge,
                                color: index == 0
                                    ? const Color.fromRGBO(0, 232, 162, 0.1)
                                    : AppColors.grey0,
                                child: ListTile(
                                  visualDensity: VisualDensity.comfortable,
                                  horizontalTitleGap: 2,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 9),
                                  title: Container(
                                    margin: const EdgeInsets.only(left: 16),
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      '${entitiesList[index].title} ${DateFormat('dd/MM/yyyy').format(entitiesList[index].createAt)} | ${widget.entity.hour}',
                                      style: AppFonts.defaultFont(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.grey9,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  subtitle: Container(
                                    margin: const EdgeInsets.only(left: 16, top: 4),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          'Messagem: ${entitiesList[index].theme}',
                                          style: AppFonts.description(
                                            color: AppColors.grey8,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 4),
                                          child: Text(
                                            entitiesList[index].preacher,
                                            style: AppFonts.description(
                                              color: AppColors.grey8,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: SizedBox(
                                    width: Platform.isIOS ? 40 : 45,
                                    child: IconButtonWidget(
                                      size: Platform.isIOS ? null : 33,
                                      color: AppColors.darkGreen,
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      iOSIcon: CupertinoIcons.chevron_forward,
                                      androidIcon: Icons.navigate_next_sharp,
                                    ),
                                  ),
                                  onTap: () {
                                    Modular.to.navigate(
                                      HomeModule.serviceRoute,
                                      arguments: ServiceViewDTO(
                                        service: entitiesList[index],
                                        image: widget.entity.image,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 40)
                    ],
                  );
                } else {
                  return const GenericErrorView();
                }
              },
            ),
          ),
        ),
      ),
      /*floatingActionButton: SizedBox(
        height: 58,
        width: 58,
        child: FloatingActionButton(
          elevation: 1.8,
          highlightElevation: 1.8,
          focusElevation: 1.8,
          hoverElevation: 1.8,
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.insertLyricsRoute
            );
          },
          backgroundColor: AppColors.add,
          child: const Icon(
            size: 45,
            Icons.add_rounded,
            color: AppColors.white,
          ),
          // icon: Icon(Icons.map, size: 15, color: Colors.white)
        ),
      ),*/
    );
  }
}