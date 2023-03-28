import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ipbc_palmas/app/lyric/infra/use-cases/lyrics_use_cases.dart';
import 'package:ipbc_palmas/app/lyric/infra/use-cases/services_use_cases.dart';
import 'package:ipbc_palmas/app/lyric/presentation/blocs/service_bloc.dart';
import '../../../lyric/infra/adapters/hive-dtos/database_configs_hive_adapter.dart';
import '../../../lyric/infra/adapters/hive-dtos/service_hive_adapter.dart';
import '../../../lyric/infra/models/hive-dtos/database_configs_hive_dto.dart';
import '../../../lyric/infra/models/hive-dtos/lyric_hive_dto.dart';
import '../../../lyric/infra/models/hive-dtos/service_hive_dto.dart';
import '../../../lyric/presentation/blocs/lyric_bloc.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../splash/infra/use-cases/databases_use_cases.dart';
import '../../../splash/presentation/blocs/database_bloc.dart';
import '../../infra/repositories/repository.dart';
import '../hive_datasource.dart';
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
  await Hive.openBox<ServiceHiveDTO>('services');
  await Hive.openBox<LyricHiveDTO>('lyrics');
  HiveDatasource dataHive = HiveDatasource<DatabaseConfigsHiveDTO>(boxLabel: 'database-configs');
  HiveDatasource serviceHive = HiveDatasource<ServiceHiveDTO>(boxLabel: 'services');
  HiveDatasource lyricHive = HiveDatasource<LyricHiveDTO>(boxLabel: 'lyrics');
/*  dataHive.add('database-configs',
    DatabaseConfigsHiveDTO(
      updateAt: DateTime.now(),
     ),
  );*/
  dataHive.delete('database-configs');
  serviceHive.delete('lyrics');
  lyricHive.delete('services');

  DatabaseBloc databaseBloc = DatabaseBloc(
      databasesUseCases: DatabasesUseCases(
          repository: Repository<Stream<List<Map>>>(
              datasource: dataHive,
          ),
      ),
  );
  /*ServiceBloc serviceBloc = ServiceBloc(
    servicesUseCases: ServicesUseCases(
      repository: Repository<Stream<List<Map>>>(
        datasource: serviceHive,
      ),
    ),
  );
  LyricBloc lyricBloc = LyricBloc(
    lyricsUseCase: LyricsUseCases(
      repository: Repository<Stream<List<Map>>>(
        datasource: lyricHive,
      ),
    ),
  );
  Stream<List<Map>> aa = dataHive.get('database-configs');
  Stream<List<Map>> se = dataHive.get('services');
  DatabaseConfigsHiveDTO? entity;
  aa.listen((event) { }).onData((data) {
    entity = DatabaseConfigsHiveAdapter.fromMap(data);
  });
  //print('data: ${entity!.updateAt}');
  List<ServiceHiveDTO>? servi;
  /*se.listen((event) { }).onData((data) {
    servi = serviceHive.getAdapter(data);
  });*/
  print('data: ${servi![0].title}');
  */
  runApp(
    HiveTest(
    bloc: databaseBloc,
     ),
  );
}

class HiveTest extends StatelessWidget {
  HiveTest({Key? key, required this.bloc}) : super(key: key);
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
            if (state is InitialDatasourceState) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.darkGreen,
                  ),
                ),
              );
            } else if (state is SuccessfullyFetchedDataState) {
              return Center(
                child: Text(state.entity.updateAt.toString() ?? ''),
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
