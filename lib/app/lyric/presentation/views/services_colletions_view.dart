import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipbc_palmas/app/lyric/presentation/views/service_view.dart';
import '../../../shared/components/button/button_widget.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/configs/app_routes.dart';
import '../../../splash/presentation/blocs/database_bloc.dart';
import '../../domain/entities/service_entity.dart';
import '../blocs/service_bloc.dart';
import '../../../splash/presentation/blocs/database_bloc.dart';
import '../../../shared/components/utils/validation_util.dart';

class ServiceCollectionsDTO {
  ServiceCollectionsDTO(
      {required this.image,
      required this.hour,
      required this.heading,
      required this.path});
  final String heading;
  final String path;
  final String image;
  final String hour;
}

class ServicesCollectionsView extends StatefulWidget {
  const ServicesCollectionsView({Key? key, required this.serviceCollections})
      : super(key: key);
  final ServiceCollectionsDTO serviceCollections;

  @override
  State<ServicesCollectionsView> createState() =>
      _ServicesCollectionsViewState();
}

class _ServicesCollectionsViewState extends State<ServicesCollectionsView> {
  bool loading = false;
  late final ServiceBloc serviceBloc;
  late final String database;
  late List<ServiceEntity> servicesList;
  late final DatabaseBloc databaseBloc;

  @override
  void initState() {
    serviceBloc = context.read<ServiceBloc>();
    databaseBloc = context.read<DatabaseBloc>();
    serviceBloc.add(GetServiceInFireEvent(path: widget.serviceCollections.path));
    //serviceBloc.add(GetServiceInHiveEvent(path: 'services/${widget.serviceCollections.path}'));
    database = ValidationUtil.validationDatasource();
    super.initState();
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
            child: BlocBuilder<ServiceBloc, ServicesState>(
              bloc: serviceBloc,
              builder: (context, state) {
                if (state is InitialState) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.darkGreen,
                        ),
                      ),
                    ),
                  );
                }
                if (state is LoadingServiceState) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.darkGreen,
                        ),
                      ),
                    ),
                  );
                } else if (state is SuccessfullyFetchedServiceState) {
                  servicesList = state.entities;
                  //if (database == firebaseDatabase) {
                  // }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 188,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          //    border: Border.all(color: Colors.black),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              widget.serviceCollections.image,
                            ),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 13, top: 129),
                              child: IconButtonWidget(
                                color: AppColors.white,
                                size: 30,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                iOSIcon: CupertinoIcons.chevron_back,
                                androidIcon: Icons.arrow_back_rounded,
                                action: () => Navigator.pop(
                                  context,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 7, top: 141),
                              child: SizedBox(
                                height: 25,
                                child: Text(
                                  "Cultos de ${widget.serviceCollections.heading}",
                                  style: AppFonts.headlineServices,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 25),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
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
                                    contentPadding: const EdgeInsets.only(),
                                    title: Container(
                                      margin:
                                          const EdgeInsets.only(left: 16, top: 8),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${servicesList[index].title} ${servicesList[index].createAt} | ${widget.serviceCollections.hour}',
                                            style: AppFonts.servicesTitleTile,
                                          ),
                                        ],
                                      ),
                                    ),
                                    subtitle: Container(
                                      margin: const EdgeInsets.only(left: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 5, top: 6),
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
                                    trailing: Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      child: IconButtonWidget(
                                        size: Platform.isIOS ? 29 : 36,
                                        color: AppColors.darkGreen,
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        iOSIcon: CupertinoIcons.chevron_forward,
                                        androidIcon: Icons.navigate_next_sharp,
                                        action: () => Navigator.pushNamed(
                                          context,
                                          AppRoutes.serviceRoute,
                                          arguments: ServiceViewDTO(
                                              service: servicesList[index],
                                              image: widget.serviceCollections.image),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.serviceRoute,
                                        arguments: ServiceViewDTO(
                                            service: servicesList[index],
                                            image: widget.serviceCollections.image),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text("error screen [services_list_view]"),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
