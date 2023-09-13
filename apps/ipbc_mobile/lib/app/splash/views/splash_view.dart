import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../blocs/database_bloc.dart';
import '../../exception/views/generic_error_view.dart';
import '../../shared/view-models/database_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final DatabaseBloc bloc;

  @override
  initState() {
    bloc = Modular.get<DatabaseBloc>();
    bloc.add(GetDataEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DatabaseBloc, DatabasesState>(
        listener: (context, state) async {
          if (state is FetchingDataState) {
            var data = await Modular.get<DatabaseViewModel>().validate(state.entity);
            bloc.add(UpdateDataEvent(data: data));
            Modular.to.pushNamed('/home/');
          }
        },
        bloc: bloc,
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
