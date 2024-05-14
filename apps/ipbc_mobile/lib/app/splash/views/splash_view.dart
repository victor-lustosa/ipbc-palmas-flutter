import 'package:auth_module/auth_module.dart';
import 'package:core_module/core_module.dart' hide LoadingState;
import 'package:flutter/material.dart';

import '../../init/init_module.dart';
import '../blocs/database_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DatabaseBloc, DatabasesState>(
        listener: (context, state) async {
          if (state is FetchingDataState) {
            if (!state.isData) {
              navigate(InitModule.initialRoute);
            } else {
              navigate(AuthModule.authRoute + AuthModule.loginRoute);
            }
          }
        },
        bloc: bloc,
        builder: (context, state) {
          if (state is LoadingState || state is FetchingDataState) {
            return const LoadingWidget(
              androidRadius: 4,
              iosRadius: 14,
              color: AppColors.darkGreen,
            );
          } else {
            return const GenericErrorView();
          }
        },
      ),
    );
  }
}
