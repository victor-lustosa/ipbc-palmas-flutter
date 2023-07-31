import 'package:core_module/core_module.dart';
import 'view_models/home_view_model.dart';

final homeModule = [
  Provider<HomeViewModel>(create: (context) => HomeViewModel()),
];
