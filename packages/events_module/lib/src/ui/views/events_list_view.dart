import 'package:flutter/material.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/services.dart';

import '../../../events_module.dart';
import '../blocs/events_list_bloc.dart';

class EventsListView extends StatefulWidget {
  const EventsListView({
    super.key,
  });

  @override
  State<EventsListView> createState() => EventsListViewState();
}

class EventsListViewState extends State<EventsListView> {
  late final EventsListBloc _bloc;
  int activePage = 0;
  final List<int> imagesList = [1, 2, 3];
  List<EventEntity> _eventsList = [];

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<EventsListBloc>();
    _bloc.add(CheckConnectivityEvent());
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          body: SafeArea(
            child: BlocBuilder<EventsListBloc, GenericState<EventsListState>>(
              bloc: _bloc,
              builder: (context, state) {
                if (state is LoadingState<EventsListState>) {
                  return const LoadingWidget(
                    androidRadius: 3,
                    iosRadius: 14,
                    color: AppColors.darkGreen,
                  );
                } else if (state is NoConnectionState<EventsListState>) {
                  return NoConnectionView(
                    action: () => nativePushReplacementNamed(
                      AppRoutes.eventsListRoute,
                      context,
                    ),
                  );
                } else if (state
                    is DataFetchedState<EventsListState, List<EventEntity>>) {
                  _eventsList = state.entities;
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize:MainAxisSize.min,
                      children: [
                        ListenableBuilder(
                            listenable: Modular.get<MainTopBarManager>(),
                            builder: (_, __) {
                              return Modular.get<MainTopBarManager>().mainTopBarWidget;
                            }
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                top: 10,
                                left: 16,
                              ),
                              child: BackButtonWidget(
                                action: () => nativePop(context),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(left: 25, top: 10),
                            child: Text(
                              "Eventos",
                              style: AppFonts.title2,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 25,
                              top: 8,
                              right: 20,
                              bottom: 12,
                            ),
                            child: Text(
                              "Proximos cultos, conferências, acompanhe todos os eventos da IPBC Palmas!",
                              style: AppFonts.defaultFont(
                                fontSize: 15,
                                height: 1.2,
                                color: AppColors.grey9,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            bottom: 40),
                          child: SlideCardsWidget(
                            margin: const EdgeInsets.only(
                              top: 16,
                              left: 16,
                              right: 16,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            width: context.sizeOf.width,
                            scrollDirection: Axis.vertical,
                            entities: _eventsList,
                            route: AppRoutes.detailEventRoute,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const GenericErrorView();
                }
              },
            ),
          ),
          floatingActionButton: FloatingButtonWidget(
            action: () => pushNamed(
              AppRoutes.eventRoute + AppRoutes.createEventRoute,
            ),
            backgroundColor: AppColors.add,
            iconColor: AppColors.white,
            icon: Icons.add,
          ),
        ));
  }
}
