import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


//import '../../../shared/components/back-button/back_button_widget.dart';
import '../../../shared/components/next-button/next_button_widget.dart';
import '../../../shared/layout/top-bar/main_top_bar_widget.dart';
import '../../domain/entities/service_entity.dart';
import '../blocs/service_bloc.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/configs/app_routes.dart';

class ServicesListView extends StatefulWidget {
  const ServicesListView({super.key});

  @override
  State<ServicesListView> createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView>
    with AutomaticKeepAliveClientMixin {
  late final ServiceBloc bloc;
  late List<ServiceEntity> services;
  late String url = 'services/1';
  @override
  void initState() {
    bloc = context.read<ServiceBloc>();
    bloc.add(GetServiceEvent(url: url));
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: BlocBuilder<ServiceBloc, ServicesState>(
        bloc: bloc,
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
            services = state.entities;
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const MainTopBarWidget(),
                    /*const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Align(
                        alignment: Alignment(-0.97, 0),
                        child: BackButtonWidget(),
                      ),
                    ),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 17.0,
                            top: 33,
                          ),
                          child: Text(
                            "Cultos",
                            style: AppFonts.headHome,
                          ),
                        ), /*
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10.0,
                            right: 0,
                          ),
                          child: SizedBox(
                            height: 30,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.lyricRoute,
                                );
                              },
                              icon: const Icon(
                                size: 32,
                                Icons.navigate_next_sharp,
                                color: AppColors.darkGreen,
                              ),
                            ),
                          ),
                        ),*/
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 18.0,
                        top: 8,
                      ),
                      child: Text(
                        "Acompanhe a liturgia e as letras das músicas cantadas nos cultos.",
                        style: AppFonts.subHeadHome,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 28.0,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.93,
                        child: ListView.separated(
                          separatorBuilder:
                              (BuildContext context, int index) {
                            return SizedBox(
                              height: Platform.isIOS ? 17 : 16,
                            );
                          },
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: services.length,
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
                                    AppImages.servicesImagesList[index],
                                  ),
                                ),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.only(
                                  top: Platform.isIOS ? 13 : 12.2,
                                  bottom: Platform.isIOS ? 13 : 12.2,
                                  left: 25,
                                  right: 0,
                                ),
                                title: Text(
                                  services[index].title,
                                  style: AppFonts.titleTile,
                                ),
                                trailing: NextButtonWidget(
                                  size: Platform.isIOS ? 29 : 35,
                                  route: AppRoutes.lyricRoute,
                                  arguments: services[index],
                                  color: AppColors.white,
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.chosenLyricsRoute,
                                      arguments: services[index]);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
