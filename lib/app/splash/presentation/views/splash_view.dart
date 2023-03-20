import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/views/home_view.dart';
import 'package:provider/provider.dart';

import '../../../lyric/firestore_lyric_module.dart';
import '../../../shared/configs/app_configs.dart';
import '../../main_module.dart';
import '../blocs/database_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final DatabaseBloc bloc;
  late final List instances;
  @override
  initState() {
    super.initState();
    bloc = context.read<DatabaseBloc>();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        bloc.add(
          GetDataEvent(path: 'database-configs'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DatabaseBloc, DatabasesState>(
          listener: (context, state) {
            if (state is SuccessfullyFetchedDataState) {
                 state.entity.updateAt.toString() != "" ? instances = [...firestoreLyricModule] : [...mainModule];
             }
          },
          bloc: context.read<DatabaseBloc>(),
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.darkGreen,
                  ),
                ),
              );
            } else if (state is SuccessfullyFetchedDataState){
              return MultiProvider(
                  providers: [...instances],
                  child: const HomeView());
            } else{
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.darkGreen,
                  ),
                ),
              );
            }
          }
       ),
    );
  }
}
