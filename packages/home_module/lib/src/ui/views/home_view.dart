import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../home_module.dart';
import '../blocs/home_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late final HomeBloc _bloc;
  late final AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<HomeBloc>();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1200));
    _bloc.add(GetDataEvent());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, GenericState<HomeState>>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is LoadingState<HomeState>) {
                return const LoadingWidget(
                  androidRadius: 3,
                  iosRadius: 14,
                  color: AppColors.darkGreen,
                );
              } else if (state is NoConnectionState<HomeState>) {
                return NoConnectionView(
                  action: () => nativePushNamed(AppRoutes.homeRoute, context),
                );
              } else if (state is DataFetchedState<HomeState> ||
                  state is LoadingEvents ||
                  state is LoadingServices) {
                bool isSmallDevice = ResponsivityUtil.isSmallDevice(context);
                return SingleChildScrollView(
                  child: SizedBox(
                    width: context.sizeOf.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MainTopBarWidget(),
                        InkWell(
                          onTap: () {
                            nativePushNamed(
                              AppRoutes.servicesListRoute,
                              context,
                              arguments: _bloc.servicesList,
                            );
                          },
                          child: Column(
                            children: [
                              title(text: "Cultos"),
                              subtitle(
                                right: 17,
                                text:
                                    "Acompanhe a liturgia e as letras das músicas cantadas nos cultos.",
                              ),
                            ],
                          ),
                        ),
                        CarouselWidget(
                          shimmerController: _shimmerController,
                          fontStyle: AppFonts.defaultFont(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                          margin: const EdgeInsets.only(
                            top: 2,
                            left: 6,
                            right: 6,
                            bottom: 9,
                          ),
                          route: AppRoutes.servicesCollectionRoute,
                          mainAxisAlignment: MainAxisAlignment.center,
                          width: context.sizeOf.width,
                          services: _bloc.servicesList,
                          height: context.sizeOf.width * 0.49,
                        ),
                        InkWell(
                          onTap: () {
                            _bloc.createEventStore.updateHomeViewCallback =
                                () => _bloc.add(GetEventsDataEvent());
                            nativePushNamed(
                              AppRoutes.eventRoute + AppRoutes.eventsListRoute,
                              context,
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                child: title(text: "Eventos"),
                              ),
                              subtitle(
                                right: 18,
                                text:
                                    "Proximos cultos, conferências, acompanhe todos os eventos da IPBC Palmas!",
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12, bottom: 20),
                          height: isSmallDevice
                              ? context.sizeOf.width * 0.72
                              : context.sizeOf.width * 0.663,
                          child: SlideCardsWidget(
                            width: isSmallDevice
                                ? context.sizeOf.width * 0.8
                                : context.sizeOf.width * 0.742,
                            scrollDirection: Axis.horizontal,
                            route: AppRoutes.detailEventRoute,
                            entities: _bloc.eventsList,
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
      ),
    );
  }

  Widget title({required String text}) => Container(
    margin: const EdgeInsets.only(left: 17, right: 9),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: AppFonts.title2),
        IconButtonWidget(
          size: Platform.isIOS ? 30 : 35,
          color: AppColors.darkGreen,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          iOSIcon: CupertinoIcons.chevron_forward,
          androidIcon: Icons.navigate_next_sharp,
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
          height: 1.2,
          color: AppColors.grey9,
        ),
      ),
    ),
  );
}
