import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class DetailEventStore extends ValueNotifier<GenericState<DetailEventState>>
    with ConnectivityMixin, FormatMixin {

  final IUseCases _useCases;
  String fromCalled = '';

  DetailEventStore({required IUseCases useCases})
    : _useCases = useCases,
      super(InitialState<DetailEventState>());

  late EventEntity? eventEntity;

  void init() {
  }

  Future<void> getInSupa(BuildContext context, int id) async {
    value = LoadingState();
    final result = await isConnected(context: context);
    if (result) {
      final response = await _useCases.get(
        params: SchemaUtil.eventParams(extra: {'filterColumn': 'id', 'filterValue': id, 'limit': 1}),
      );
      response.fold(
              (eventsResponse) {
            eventEntity = EventAdapter.fromMapList(eventsResponse).firstOrNull;
            if(eventEntity == null) {
              toastException(context);
            } else {
              pushNamed(
                AppRoutes.eventRoute +
                    AppRoutes.detailEventRoute,
                arguments: eventEntity,
              );

            }

          },
              (exception) =>
                  toastException(context)
      );
      await Future.delayed(const Duration(milliseconds: 2300));
       value = (DataFetchedState<DetailEventState>());
    } else {
     value = NoConnectionState<DetailEventState>();
    }
  }

  void toastException(BuildContext context){
    showCustomToast(
      type: .error,
      context: context,
      title: 'Erro',
      duration: const Duration(milliseconds: 2000),
      message:
      'Não foi possível abrir o evento.',
    );
  }
}

@immutable
abstract class DetailEventState {}