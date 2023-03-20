
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import '../../shared/components/splash/infra/models/hive-dtos/database_configs_hive_dto.dart';
import '../../shared/components/splash/infra/use-cases/databases_use_cases.dart';
import '../../shared/components/splash/presentation/blocs/database_bloc.dart';
import '../../shared/configs/app_configs.dart';
import '../infra/repositories/repository.dart';
import 'hive_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//command to map hive entities
// flutter packages pub run build_runner build --delete-conflicting-outputs

Future<DateTime> dateNow() async {
  return Future.delayed(
    const Duration(seconds: 2),
    () => DateTime.now(),
  );
}

Future<void> main() async {
  await Hive.initFlutter();
  HiveDatasource.initHive();
  //insert Service Hive DTO
//database configs insert
  await Hive.openBox<DatabaseConfigsHiveDTO>('database-configs');
  HiveDatasource hive = HiveDatasource<Stream<List<DatabaseConfigsHiveDTO?>>>(boxLabel: 'database-configs');
  //HiveDatasource hive1 = HiveDatasource<ServiceHiveDTO>(boxLabel: 'services');
  hive.add('database-configs', DatabaseConfigsHiveDTO(updateAt: DateTime.now()));
  //hive.delete('database-configs');
  DatabaseBloc bloc = DatabaseBloc(
      databasesUseCases: DatabasesUseCases(
      repository: Repository<Stream<List<DatabaseConfigsHiveDTO>>>(
          datasource: hive
      )));
  //DatabaseConfigsHiveDTO? aa = data.get('database-configs');
  //print('data: ${aa!.updateAt}');
  runApp(HiveTest(bloc: bloc,));
}
class HiveTest extends StatelessWidget {
   HiveTest({Key? key,required this.bloc}) : super(key: key);
  DatabaseBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc.add(GetDataEvent(path: 'database-configs'));
    return MaterialApp(
      title: 'IPBC Palmas',
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: AppColors.white,
        primaryColor: AppColors.white,
      ),
      home: Scaffold(
        body: BlocBuilder<DatabaseBloc, DatabasesState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is InitialState) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.darkGreen,
                  ),
                ),
              );
            } else if (state is SuccessfullyFetchedDataState) {
              return Center(
                child: Text(state.entity.updateAt.toString()),
              );
            } else {
              return const Center(
                child: Text("error screen [services_list_view]"),
              );
            }
          },
        ),
      ),
    );
  }
}
