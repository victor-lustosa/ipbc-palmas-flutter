import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../configs/app_configs.dart';
import '../blocs/database_bloc.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final DatabaseBloc databaseBloc;
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        databaseBloc.add(
          GetDataEvent(path: 'database-configs'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      //MultiBlocProvider(
      /*providers: [ Provider<LyricBloc>(
        create: (context) => LyricBloc(
          lyricsUseCase: LyricsUseCases(
            repository: context.read<Repository<LyricEntity>>(),
          ),
        ),
      ),
        Provider<ServiceBloc>(
          create: (context) => ServiceBloc(
            servicesUseCases: ServicesUseCases(
              repository: context.read<Repository<ServiceEntity>>(),
            ),
          ),
        ),],*/
     // child:
      Scaffold(
          body: BlocConsumer<DatabaseBloc, DatabasesState>(
            listener: (context, state) {
              if (state is SuccessfullyFetchedDataState) {
               /* if (state.user != null) {
                  context.read<EstablishmentViewModel>().user =
                      UserAdapter.user(state.user!);
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.establishmentRoute,
                  );
                } else {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.homeRoute,
                  );
                }*/
              }
            },
            bloc: context.read<DatabaseBloc>(),
            builder: (context, state) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.darkGreen,
                  ),
                ),
              );
            },
          ),
      //  )
    );
  }
}
