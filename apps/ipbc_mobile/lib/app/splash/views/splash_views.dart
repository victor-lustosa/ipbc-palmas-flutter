import 'package:core_module/core_module.dart' hide LoadingState;
import 'package:flutter/material.dart';

import '../../home/home_module.dart';
import '../blocs/database_bloc.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DatabaseBloc, DatabasesState>(
        listener: (context, state) async {
          if (state is FetchingDataState) {
            if(state.isData){
              Modular.to.navigate(HomeModule.initialRoute);
            } else {
              Modular.to.navigate(AuthModule.authRoute + AuthModule.loginRoute);
            }
          }
        },
        bloc: bloc,
        builder: (context, state) {
          if (state is LoadingState || state is FetchingDataState) {
            return const LoadingWidget(
              androidRadius: 4,
              iosRadius: 12,
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