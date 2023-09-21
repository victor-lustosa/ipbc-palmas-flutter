import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../home/home_module.dart';
import '../../shared/blocs/generics.dart';
import '../../shared/view-models/database_view_model.dart';
import '../blocs/services_list_bloc.dart';
import '../../exception/views/no_connection_view.dart';
import '../../exception/views/generic_error_view.dart';
import '../../../layout/top-bar/main_top_bar_widget.dart';

class ServicesListView extends StatefulWidget {
  const ServicesListView({super.key});

  @override
  State<ServicesListView> createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView> {
  late final ServicesListBloc bloc;
  late List<ServicesEntity> entitiesList;

  @override
  void initState() {
    bloc = Modular.get<ServicesListBloc>();
    if (!Modular.get<DatabaseViewModel>().data.isServicesUpdated) {
      bloc.add(CheckConnectivityEvent());
    } else {
      bloc.add(GetInHiveEvent());
    }
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<ServicesListBloc, GenericState<ServicesListState>>(
            bloc: bloc,
            builder: (context, state) {
               if (state is LoadingState<ServicesListState>) {
                return const LoadingWidget();
              } else if (state is NoConnectionState<ServicesListState>) {
                return const NoConnectionView(index: 0);
              } else if (state is DataFetchedState<ServicesListState, ServicesEntity>) {
                entitiesList = state.entities;
                Modular.get<DatabaseViewModel>().checkUpdateData(context, 'services');
                return Column(
                  children: [
                    const MainTopBarWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 17, top: 33),
                          child: Text(
                            "Cultos",
                            style: AppFonts.title2,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(left: 18, top: 8),
                        child: Text(
                          "Acompanhe a liturgia e as letras das músicas cantadas nos cultos.",
                          style: AppFonts.defaultFont(
                            fontSize: context.mediaQuery.size.width >
                                    ResponsivityUtil.widthDevice
                                ? 16
                                : 15,
                            color: AppColors.grey9,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 28,
                        left: 16,
                        right: 16,
                      ),
                      width: context.mediaQuery.size.width,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 17);
                        },
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: entitiesList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  entitiesList[index].image,
                                ),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 13),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Container(
                                  margin: const EdgeInsets.only(left: 17),
                                  child: Text(
                                    '${entitiesList[index].title} | ${entitiesList[index].hour}',
                                    style: AppFonts.headline(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                trailing: Container(
                                  margin: const EdgeInsets.only(right: 3),
                                  child: IconButtonWidget(
                                    size: Platform.isIOS ? null : 33,
                                    color: AppColors.white,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    iOSIcon: CupertinoIcons.chevron_forward,
                                    androidIcon: Icons.navigate_next_sharp,
                                  ),
                                ),
                                onTap: () {
                                  Modular.to.pushNamed(
                                    HomeModule.servicesCollectionRoute,
                                    arguments: entitiesList[index],
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              } else {
                return const GenericErrorView();
              }
            },
          ),
        ),
      ),
    );
  }
}
