import 'dart:io';

import 'package:core_module/core_module.dart';

import '../../external/repositories/event_repository.dart';

abstract class IGetLocationFromUrlUseCases {
  Future<dynamic> getLocationFromUrl({required String url});
}

abstract class IEventUseCases implements IGetLocationFromUrlUseCases {}

class EventUseCases implements IEventUseCases {
  final IEventRepository repository;

  EventUseCases({required this.repository});

  @override
  Future getLocationFromUrl({required String url}) {
    return repository.getLocationFromUrl(url: url);
  }
}
