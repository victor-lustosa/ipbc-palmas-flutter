import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../layout/top-bar/main_top_bar_widget.dart';
import '../../exception/views/generic_error_view.dart';
import '../../exception/views/no_connection_view.dart';
import '../blocs/home_bloc.dart';
import '../../shared/blocs/generics.dart';
import '../home_module.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin {
  late final HomeBloc _bloc;
  late List<ServicesEntity> _servicesList;

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<HomeBloc>();
    _bloc.add(CheckConnectivityEvent());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeBloc, GenericState<HomeState>>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is LoadingState<HomeState>) {
              return const LoadingWidget();
            } else if (state is NoConnectionState<HomeState>) {
              return const NoConnectionView(index: 0);
            } else if (state is DataFetchedState<HomeState, ServicesEntity>) {
              _servicesList = state.entities;
              return SingleChildScrollView(
                child: SizedBox(
                  width: context.mediaQuery.size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const MainTopBarWidget(),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              HomeModule.servicesListRoute,
                              arguments: _servicesList,
                            );
                          },
                          child: Column(
                            children: [
                              title(text: "Cultos"),
                              subtitle(
                                right: 17,
                                text: "Acompanhe a liturgia e as letras das músicas cantadas nos cultos.",
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        child: CarouselWidget(
                          fontStyle: AppFonts.defaultFont(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                          margin: const EdgeInsets.only(
                            left: 15.5,
                            right: 15.5,
                          ),
                          route: HomeModule.servicesCollectionRoute,
                          mainAxisAlignment: MainAxisAlignment.center,
                          width: context.mediaQuery.size.width,
                          services: _servicesList,
                          height: 167,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            HomeModule.servicesListRoute,
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 24),
                              child: title(text: "Eventos"),
                            ),
                            subtitle(
                              right: 18,
                              text: "Proximos cultos, conferências, acompanhe todos os eventos da IPBC Palmas!",
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 20),
                        height: 268,
                        child: SlideCardsWidget(
                          route: HomeModule.servicesCollectionRoute,
                          services: _servicesList,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const GenericErrorView();
            }
          },
        ),
      ),
    );
  }

  Widget title({required String text}) => Container(
        margin: const EdgeInsets.only(left: 17, right: 9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppFonts.title2,
            ),
            SizedBox(
              width: 35,
              height: 35,
              child: IconButtonWidget(
                size: Platform.isIOS ? null : 33,
                color: AppColors.darkGreen,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                iOSIcon: CupertinoIcons.chevron_forward,
                androidIcon: Icons.navigate_next_sharp,
              ),
            ),
          ],
        ),
      );

  Widget subtitle({required double right, required String text}) => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.only(left: 18, top: 4, right: right),
          child: Text(
            text,
            style: AppFonts.defaultFont(
              fontSize: 15,
              color: AppColors.grey9,
            ),
          ),
        ),
      );
}
