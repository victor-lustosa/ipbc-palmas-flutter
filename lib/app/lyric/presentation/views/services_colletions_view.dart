import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/back-button/back_button_widget.dart';
import '../../../shared/components/next-button/next_button_widget.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/configs/app_routes.dart';
import '../../../splash/presentation/blocs/database_bloc.dart';
import '../../domain/entities/service_entity.dart';
import '../blocs/service_bloc.dart';
import '../../../splash/presentation/blocs/database_bloc.dart';
import '../../../shared/components/utils/validation_util.dart';
class ServiceCollectionsDTO{
  ServiceCollectionsDTO({required this.heading, required this.path});
  final String heading;
  final String path;
}
class ServicesCollectionsView extends StatefulWidget {
  const ServicesCollectionsView(
      {Key? key, required this.serviceCollections})
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
    //serviceBloc.add(GetServiceInFireEvent(path: widget.serviceCollections.path));
    serviceBloc.add(GetServiceInHiveEvent(path:'services/${widget.serviceCollections.path}'));
    database = ValidationUtil.validationDatasource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: const Color(0x66C8C8C8),
        highlightColor: const Color(0x66BCBCBC),
      ),
      child: BlocBuilder<ServiceBloc, ServicesState>(
        bloc: serviceBloc,
        builder: (context, state) {
          if (state is InitialState) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.darkGreen,
                ),
              ),
            );
          } else if (state is SuccessfullyFetchedServiceState) {
            servicesList = state.entities;
            //if (database == firebaseDatabase) {

            // serviceBloc.add(AddServiceInHiveEvent(path: 'services/${widget.serviceCollections.path}', data: state.entities));
            // }
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 0.0,
                  ),
                  child: Align(
                    alignment: Alignment(-0.97, 0),
                    child: BackButtonWidget(
                      iOSIcon: CupertinoIcons.chevron_back,
                      androidIcon: Icons.arrow_back_rounded,
                      color: AppColors.darkGreen,
                      size: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Platform.isIOS ? 14 : 10),
                  child: Align(
                    alignment: Alignment(Platform.isIOS ? -0.4 : -0.15, 0),
                    child: SizedBox(
                      height: 25,
                      width: 350,
                      child: Align(
                        alignment: const Alignment(-1, 0),
                        child: Text(
                          "Cultos de ${widget.serviceCollections.heading}",
                          style: AppFonts.headline,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.93,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 4,
                      );
                    },
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: servicesList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Material(
                        borderRadius: BorderRadius.circular(10),
                        clipBehavior: Clip.hardEdge,
                        color: AppColors.white,
                        child: ListTile(
                          contentPadding: const EdgeInsets.only(
                            top: 2,
                            bottom: 2,
                            left: 8,
                            right: 0,
                          ),
                          dense: true,
                          minVerticalPadding: 0,
                          minLeadingWidth: 0,
                          horizontalTitleGap: 4,
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 4, left: 4),
                            child: Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              servicesList[index].title,
                              style: AppFonts.lyricsTitleTile,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              servicesList[index].preacher,
                              style: AppFonts.subtitleTile,
                            ),
                          ),
                          trailing: NextButtonWidget(
                              size: Platform.isIOS ? 29 : 36,
                              route: AppRoutes.serviceRoute,
                              arguments: servicesList[index],
                              color: AppColors.darkGreen),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.serviceRoute,
                              arguments: servicesList[index],
                            );
                          },
                        ),
                      );
                    },
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
    );
  }
}
