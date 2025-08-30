import 'package:flutter/material.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/services.dart';
import '../blocs/events_list_bloc.dart';

class EventsListView extends StatefulWidget {
  const EventsListView({super.key});

  @override
  State<EventsListView> createState() => EventsListViewState();
}

class EventsListViewState extends State<EventsListView>
    with SingleTickerProviderStateMixin {
  late final EventsListBloc _bloc;
  late final AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1200));
    _bloc = Modular.get<EventsListBloc>();
    _bloc.add(GetDataEvent());
  }

  @override
  dispose() {
    _shimmerController.dispose();
    super.dispose();
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
              } else if (state is DataFetchedState<EventsListState> ||
                  state is LoadingEventsState) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BackAuthTopBarWidget(
                        action: () {
                          if (_bloc
                              .createEventStore
                              .updateHomeViewCallback !=
                              null &&
                              _bloc.createEventStore.isChangedOrAdded) {
                            _bloc
                                .createEventStore
                                .updateHomeViewCallback!();
                          }
                          nativePop(context);
                        },
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(left: 25),
                          child: Text("Eventos", style: AppFonts.title2),
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
                        margin: const EdgeInsets.only(bottom: 40),
                        child: SlideCardsWidget(
                          shimmerController: _shimmerController,
                          onLongPressStart: (details) async {
                            await showOptionsDialog(
                              isBackgroundSolid: true,
                              context: context,
                              itemKey: _bloc.slideCardsStore.itemKey,
                              popupHeightParam: 110,
                              popupWidthParam: 160,
                              popupWidthPositionParam: 160,
                              verticalMarginParam: -80,
                              buttons: Column(
                                children: [
                                  actionButton(
                                    context: context,
                                    top: 12,
                                    bottom: 12,
                                    icon: AppIcons.edit,
                                    label: 'Editar',
                                    action: () async {
                                      _bloc.createEventStore.isEditing = true;
                                      _bloc
                                          .createEventStore
                                          .updateEventListViewCallback = () =>
                                          _bloc.add(GetDataEvent());
                                      await pushNamed(
                                        AppRoutes.eventRoute +
                                            AppRoutes.createEventRoute,
                                        arguments: {
                                          "isEditing": true,
                                          "event":
                                          _bloc.slideCardsStore.eventEntity,
                                        },
                                      );
                                      if (context.mounted) {
                                        pop(context);
                                      }
                                    },
                                  ),
                                  Divider(
                                    height: 1,
                                    color: AppColors.dividerModal.withValues(
                                      alpha: .3,
                                    ),
                                  ),
                                  actionButton(
                                    context: context,
                                    top: 12,
                                    bottom: 12,
                                    icon: AppIcons.trash,
                                    label: 'Deletar',
                                    action: () {
                                      _bloc.add(DeleteItemEvent());
                                      if (context.mounted) {
                                        pop(context);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          margin: const EdgeInsets.only(
                            top: 16,
                            left: 16,
                            right: 16,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          width: context.sizeOf.width,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          entities: _bloc.eventsList,
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
          action: () async {
            _bloc.createEventStore.isEditing = false;
            _bloc.createEventStore.updateEventListViewCallback = () =>
                _bloc.add(GetDataEvent());
            await pushNamed(AppRoutes.eventRoute + AppRoutes.createEventRoute);
          },
          backgroundColor: AppColors.add,
          iconColor: AppColors.white,
          icon: Icons.add,
        ),
      ),
    );
  }
}
