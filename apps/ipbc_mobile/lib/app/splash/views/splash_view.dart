import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../blocs/database_bloc.dart';
import '../../exception/views/generic_error_view.dart';
import '../../splash/view-models/database_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final DatabaseBloc bloc;
  late HiveDatabaseConfigsDTO data;
  @override
  initState() {
    bloc = Modular.get<DatabaseBloc>();
    bloc.add(GetDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DatabaseBloc, DatabasesState>(
        listener: (context, state) async {
          if (state is FetchingDataState) {
            HiveDatabaseConfigsDTO data = await Modular.get<DatabaseViewModel>().validate(context, state.entity);
            bloc.add(UpdateDataEvent(data: data));
            GInstances.getIt.registerSingleton<HiveDatabaseConfigsDTO>(data);
            Modular.to.pushNamed('/home/lyrics');
          }
        },
        bloc: bloc,
        builder: (context, state) {
          if (state is LoadingState) {
            return const LoadingWidget();
          } else {
            return const GenericErrorView();
          }
        },
      ),
    );
  }
}
