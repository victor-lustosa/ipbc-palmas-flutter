
import 'package:core_module/core_module.dart';

import '../../domain/use_cases/auth_use_cases.dart';


class OfflineAuthUseCases implements IOfflineAuthUseCases{

  final IRepository repository;

  OfflineAuthUseCases({required this.repository});

  @override
  void get() {
  }

}