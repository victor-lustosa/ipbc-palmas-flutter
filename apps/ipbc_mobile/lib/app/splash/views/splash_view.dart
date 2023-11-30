import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../blocs/database_bloc.dart';
import '../../exception/views/generic_error_view.dart';
import '../../shared/view-models/database_view_model.dart';
import '../main_module.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final DatabaseBloc _bloc;
  late final DatabaseViewModel _databaseViewModel;

  @override
  initState() {
    super.initState();
    _bloc = Modular.get<DatabaseBloc>();
    _databaseViewModel = Modular.get<DatabaseViewModel>();
    _bloc.add(GetDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DatabaseBloc, DatabasesState>(
        listener: (context, state) async {
          if (state is FetchingDataState) {
            var data = await _databaseViewModel.validate(state.entity);
            _bloc.add(UpdateDataEvent(data: data));
            Modular.to.navigate(MainModule.initRoute);
          }
        },
        bloc: _bloc,
        builder: (context, state) {
          if (state is LoadingState || state is FetchingDataState) {
            return const LoadingWidget();
          } else {
            return const GenericErrorView();
          }
        },
      ),
    );
  }
}
