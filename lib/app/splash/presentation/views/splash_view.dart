
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipbc_palmas/app/lyric/infra/models/hive-dtos/database_configs_hive_dto.dart';
import 'package:provider/provider.dart';
import '../../../home/views/home_view.dart';
import '../../../lyric/firestore_lyric_module.dart';
import '../../../lyric/hive_lyric_module.dart';
import '../../../shared/configs/app_configs.dart';
import '../../utils/validation_util.dart';
import '../blocs/database_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final DatabaseBloc databaseBloc;
  late final List instances;
  final String database = 'firebase';
  final String url = 'database-configs';
  @override
  initState() {
    super.initState();
    databaseBloc = context.read<DatabaseBloc>();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        databaseBloc.add(
          GetDataEvent(path: url),
        );
      },
    );
  }

  createInstances(DateTime dataUpdateAt) async {
    if (ValidationUtil.validationDatasource() == database || DateFormat('y').format(dataUpdateAt) != '2000') {
      DateTime fireUpdateAt = await ValidationUtil.verifyUpdateFirebase(context, dataUpdateAt);
      if(dataUpdateAt.isBefore(fireUpdateAt)){
        databaseBloc.add(AddDataEvent(path: url, data: DatabaseConfigsHiveDTO(updateAt: fireUpdateAt)));
        instances = [...firestoreLyricModule];
      } else{
        instances = [...hiveLyricModule];
      }
    } else {
      instances = [...hiveLyricModule];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DatabaseBloc, DatabasesState>(
        listener: (context, state) async {
          if (state is SuccessfullyFetchedDataState) {
              createInstances(state.entity.updateAt);
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
          } else if (state is SuccessfullyFetchedDataState) {
            return MultiProvider(
                providers: [...instances],
                child: const HomeView(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.darkGreen,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
