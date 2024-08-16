
import 'package:flutter/material.dart';
import 'package:home_module/home_module.dart';

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
    bloc.add(GetInHiveEvent<DatabasesEvent>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DatabaseBloc, GenericState<DatabasesState>>(
        listener: (context, state) async {
          if (state is FetchingDataState<DatabasesState>) {
            if (state.isData) {
              navigate(InitModule.initialRoute);
            } else {
              navigate(AuthModule.authRoute + AuthModule.loginRoute);
            }
          }
        },
        bloc: bloc,
        builder: (context, state) {
          if (state is LoadingState<DatabasesState> || state is FetchingDataState<DatabasesState>) {
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
