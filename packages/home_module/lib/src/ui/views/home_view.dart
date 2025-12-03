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
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late final HomeBloc _bloc;
  late final AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<HomeBloc>();
    _bloc.createEventStore.updateHomeViewCallback = () =>
        _bloc.add(GetEventsDataEvent());
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1200));
    _bloc.add(GetDataEvent(context: context));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: .dark,
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, GenericState<HomeState>>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is DataFetchedState<HomeState> ||
                  state is InitialState<HomeState> ||
                  state is LoadingEventsState ||
                  state is LoadingServicesState) {
                return CustomReloadScrollWidget(
                  action: () async {
                    _bloc.add(GetDataEvent(context: context));
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        width: context.sizeOf.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 78),
                            InkWell(
                              onTap: () {
                                nativePushNamed(
                                  AppRoutes.servicesListRoute,
                                  context,
                                  arguments: {
                                    'servicesList': _bloc.servicesList,
                                    'shimmerController': _shimmerController,
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  const _TitleWidget(text: "Cultos"),
                                  const _SubtitleWidget(
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
                              margin: const EdgeInsets.only(left: 6, right: 6),
                              route: AppRoutes.servicesCollectionRoute,
                              mainAxisAlignment: MainAxisAlignment.center,
                              width: context.sizeOf.width,
                              services: _bloc.servicesList,
                            ),
                            InkWell(
                              onTap: () {
                                _bloc.createEventStore.fromCalled =
                                    'eventsList';
                                nativePushNamed(
                                  AppRoutes.eventRoute +
                                      AppRoutes.eventsListRoute,
                                  context,
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: _bloc.servicesList.isEmpty ? 29 : 15,
                                    ),
                                    child: const _TitleWidget(text: "Eventos"),
                                  ),
                                  const _SubtitleWidget(
                                    right: 18,
                                    text:
                                        "Proximos cultos, conferências, acompanhe todos os eventos da IPBC Palmas!",
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: SlideCardsWidget(
                                state: state,
                                action: () {
                                  _bloc.createEventStore.fromCalled = 'home';
                                  pushNamed(
                                    AppRoutes.eventRoute +
                                        AppRoutes.detailEventRoute,
                                    arguments: Modular.get<SlideCardsStore>()
                                        .eventEntity,
                                  );
                                },
                                shimmerController: _shimmerController,
                                width: context.sizeOf.width * .742,
                                scrollDirection: Axis.horizontal,
                                route:
                                    AppRoutes.eventRoute +
                                    AppRoutes.detailEventRoute,
                                entities: _bloc.eventsList,
                              ),
                            ),
                          ],
                        ),
                      ),
                      BackAuthTopBarWidget(isHome: true),
                    ],
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
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: AppFonts.title2),
          IconButtonWidget(
            sizeIcon: 20.5,
            height: 33,
            width: 33,
            color: AppColors.darkGreen,
            splashColor: Colors.transparent,
            iconFormat: IconFormat.svg,
            highlightColor: Colors.transparent,
            iconPath: AppIcons.arrowForward,
          ),
        ],
      ),
    );
  }
}

class _SubtitleWidget extends StatelessWidget {
  const _SubtitleWidget({required this.right, required this.text});

  final double right;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 18, top: 4, right: right), // Use 'const'
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
}
