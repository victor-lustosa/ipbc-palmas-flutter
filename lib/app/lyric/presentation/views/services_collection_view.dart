import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'service_view.dart';
import '../view-models/lyrics_view_model.dart';
import '../blocs/services_collection_bloc.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/entities/services_entity.dart';
import '../../../configs/app_routes.dart';
import '../../../configs/app_configs.dart';
import '../../../exception/views/generic_error_view.dart';
import '../../../exception/views/no_connection_view.dart';
import '../../../shared/components/button/button_widget.dart';
import '../../../shared/components/loading/loading_widget.dart';

class ServicesCollectionView extends StatefulWidget {
  const ServicesCollectionView({Key? key, required this.servicesCollection})
      : super(key: key);
  final ServicesEntity servicesCollection;

  @override
  State<ServicesCollectionView> createState() => _ServicesCollectionViewState();
}

class _ServicesCollectionViewState extends State<ServicesCollectionView> {
  late final ServicesCollectionBloc bloc;
  late List<ServiceEntity> servicesCollectionList;
  late String path;

  @override
  void initState() {
    super.initState();
    servicesCollectionList = [];
    path = widget.servicesCollection.path;
    bloc = context.read<ServicesCollectionBloc>();
    bloc.add(LoadingEvent());
    if (context.read<LyricsViewModel>().isNotUpdated(path)) {
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
                } else if (state is CollectionSuccessfullyFetchedState) {
                  servicesCollectionList = state.entities;
                  context.read<LyricsViewModel>().checkUpdateData(context, path);
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
                                        action: () => Navigator.pop(context),
                                      ),
                                      Text(
                                        "Cultos de ${widget.servicesCollection.heading}",
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
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(height: 16);
                            },
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: servicesCollectionList.length,
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
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  title: Container(
                                    margin: const EdgeInsets.only(left: 16),
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      '${servicesCollectionList[index].title} ${DateFormat('dd/MM/yyyy').format(servicesCollectionList[index].createAt)} | ${widget.servicesCollection.hour}',
                                      style: AppFonts.defaultFont(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.grey9,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  subtitle: Container(
                                    margin:
                                        const EdgeInsets.only(left: 16, top: 4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          'Messagem: ${servicesCollectionList[index].theme}',
                                          style: AppFonts.description(
                                            color: AppColors.grey8,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 4),
                                          child: Text(
                                            servicesCollectionList[index]
                                                .preacher,
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
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.serviceRoute,
                                      arguments: ServiceViewDTO(
                                        service: servicesCollectionList[index],
                                        image: widget.servicesCollection.image,
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
    );
  }
}
