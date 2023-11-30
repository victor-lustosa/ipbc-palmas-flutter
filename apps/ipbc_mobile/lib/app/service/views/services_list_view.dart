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

class ServicesListView extends StatefulWidget {
  const ServicesListView({super.key});

  @override
  State<ServicesListView> createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView> {
  late final ServicesListBloc _bloc;
  late List<ServicesEntity> entitiesList;
  late final DatabaseViewModel _databaseViewModel;
  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<ServicesListBloc>();
    _databaseViewModel = Modular.get<DatabaseViewModel>();
    if (!_databaseViewModel.data.isServicesUpdated) {
      _bloc.add(CheckConnectivityEvent());
    } else {
      _bloc.add(GetInHiveEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<ServicesListBloc, GenericState<ServicesListState>>(
            bloc: _bloc,
            builder: (context, state) {
               if (state is LoadingState<ServicesListState>) {
                return const LoadingWidget();
              } else if (state is NoConnectionState<ServicesListState>) {
                return const NoConnectionView(index: 0);
              } else if (state is DataFetchedState<ServicesListState, ServicesEntity>) {
                entitiesList = state.entities;
                _databaseViewModel.checkUpdateData(context, 'services');
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 17, top: 33),
                          child: IconButtonWidget(
                            size: Platform.isIOS ? null : 28,
                            color: AppColors.darkGreen,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            iOSIcon: CupertinoIcons.chevron_back,
                            androidIcon: Icons.arrow_back_rounded,
                            action: () => Navigator.pop(context),
                          ),
                        ),
                      ],
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
                                image: NetworkImage(
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
                                  Navigator.of(context).pushNamed(
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
