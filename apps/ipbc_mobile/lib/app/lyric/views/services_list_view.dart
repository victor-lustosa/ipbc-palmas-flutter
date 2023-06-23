import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../blocs/services_list_bloc.dart';
import '../view-models/lyrics_view_model.dart';
import '../../configs/app_routes.dart';
import '../../exception/views/no_connection_view.dart';
import '../../exception/views/generic_error_view.dart';
import '../../shared/components/button/button_widget.dart';
import '../../shared/components/loading/loading_widget.dart';
import '../../shared/components/utils/responsivity_util.dart';
import '../../shared/layout/top-bar/main_top_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ServicesListView extends StatefulWidget {
  const ServicesListView({super.key});

  @override
  State<ServicesListView> createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView>
    with AutomaticKeepAliveClientMixin {
  late final ServicesListBloc bloc;
  late List<ServicesEntity> servicesList;

  @override
  void initState() {
    context.read<LyricsViewModel>().initData(context);
    bloc = context.read<ServicesListBloc>();
    bloc.add(LoadingEvent());
    if (!context.read<LyricsViewModel>().data.isServicesUpdated) {
      bloc.add(CheckConnectivityEvent());
    } else {
      bloc.add(GetServiceInHiveEvent());
    }
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<ServicesListBloc, ServicesListState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is InitialState) {
                return const LoadingWidget();
              } else if (state is LoadingServiceState) {
                return const LoadingWidget();
              } else if (state is NoConnectionAvailableState) {
                return const NoConnectionView(index: 0);
              } else if (state is ServiceSuccessfullyFetchedState) {
                servicesList = state.entities;
                context.read<LyricsViewModel>().checkUpdateData(context, 'services');
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
                          style: MediaQuery.of(context).size.width >
                                  ResponsivityUtil.widthDevice
                              ? AppFonts.defaultFont(
                                  fontSize: 16,
                                  color: AppColors.grey9,
                                )
                              : AppFonts.defaultFont(
                                  fontSize: 15,
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
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 17);
                        },
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: servicesList.length,
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
                                  servicesList[index].image,
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
                                    '${servicesList[index].title} | ${servicesList[index].hour}',
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
                                      AppRoutes.servicesCollectionRoute,
                                      arguments: servicesList[index],
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
