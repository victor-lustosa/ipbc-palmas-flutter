import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/utils/validation_util.dart';
import '../../../exception/views/generic_error_view.dart';
import '../../../exception/views/no_connection_view.dart';
import '../../infra/models/firestore-dtos/services_collection_dto.dart';
import 'service_view.dart';
import '../../../shared/components/loading/loading_widget.dart';
import '../../../shared/components/button/button_widget.dart';
import '../../../configs/app_configs.dart';
import '../../../configs/app_routes.dart';
import '../../domain/entities/service_entity.dart';
import '../blocs/services_collection_bloc.dart';

class ServicesCollectionView extends StatefulWidget {
  const ServicesCollectionView({Key? key, required this.servicesCollection})
      : super(key: key);
  final ServicesCollectionDTO servicesCollection;

  @override
  State<ServicesCollectionView> createState() => _ServicesCollectionViewState();
}

class _ServicesCollectionViewState extends State<ServicesCollectionView> {

  late final ServicesCollectionBloc bloc;
  late List<ServiceEntity> servicesList;
  late String path;

  @override
  void initState() {
    super.initState();
    path = widget.servicesCollection.path;
    bloc = context.read<ServicesCollectionBloc>();
    bloc.add(LoadingEvent());
   if(context.read<ValidationUtil>().validateCollection(context, path)){
     bloc.add(CheckConnectivityEvent(path: path));
   } else {
     bloc.add(GetServicesCollectionInHiveEvent(path: path));
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
            child: BlocBuilder<ServicesCollectionBloc, ServicesCollectionState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is InitialState) {
                  return const LoadingWidget();
                } else if (state is LoadingServiceState) {
                  return const LoadingWidget();
                } else if (state is NoConnectionAvailableState) {
                  return const NoConnectionView(index: 0);
                } else if (state is SuccessfullyFetchedCollectionState) {
                  bloc.add(UpdateServicesCollectionInHiveEvent(entities: state.entities));
                  servicesList = state.entities;
                  context.read<ValidationUtil>().serviceType(context, path);
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
                              widget.servicesCollection.image,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        action: () => Navigator.pop(
                                          context,
                                        ),
                                      ),
                                      Text(
                                        "Cultos de ${widget.servicesCollection.heading}",
                                        style: AppFonts.headlineServices,
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
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 16,
                              );
                            },
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: servicesList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Material(
                                borderRadius: BorderRadius.circular(16),
                                clipBehavior: Clip.hardEdge,
                                color: index == 0
                                    ? const Color.fromRGBO(0, 232, 162, 0.1)
                                    : AppColors.secondaryLightGrey,
                                child: ListTile(
                                  horizontalTitleGap: 2,
                                  contentPadding: EdgeInsets.zero,
                                  title: Container(
                                    margin: const EdgeInsets.only(
                                      left: 16,
                                      bottom: 5,
                                      top: 8,
                                    ),
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      '${servicesList[index].title} ${servicesList[index].createAt} | ${widget.servicesCollection.hour}',
                                      style: AppFonts.servicesTitleTile,
                                    ),
                                  ),
                                  subtitle: Container(
                                    margin: const EdgeInsets.only(left: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 4),
                                          child: Text(
                                            'Messagem: ${servicesList[index].theme}',
                                            style: AppFonts.subtitleTile,
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Text(
                                            servicesList[index].preacher,
                                            style: AppFonts.subtitleTile,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: SizedBox(
                                    width: 50,
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
                                    Navigator.pushNamed(
                                        context, AppRoutes.serviceRoute,
                                        arguments: ServiceViewDTO(
                                          service: servicesList[index],
                                          image:
                                              widget.servicesCollection.image,
                                        ));
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
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
    );
  }
}
