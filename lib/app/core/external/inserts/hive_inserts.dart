import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

import '../../../lyric/infra/models/hive-dtos/hive_verse_dto.dart';
import '../../../lyric/infra/use-cases/lyrics_use_cases.dart';
import '../../../../firebase_options.dart';
import '../../../lyric/infra/models/hive-dtos/hive_lyric_dto.dart';
import '../../../lyric/presentation/blocs/lyric_bloc.dart';
import '../../../lyric/presentation/view-models/lyrics_view_model.dart';
import '../../../shared/components/loading/loading_widget.dart';
import '../../../shared/configs/app_configs.dart';
import '../../infra/repositories/repository.dart';
import '../firestore_datasource.dart';
import '../hive_datasource.dart';
//command to map hive entities
// flutter packages pub run build_runner build --delete-conflicting-outputs

Future<DateTime> dateNow() async {
  return Future.delayed(
    const Duration(seconds: 2),
    () => DateTime.now(),
  );
}

Future<void> firebaseInitialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (details) {
    log(
      details.exceptionAsString(),
      stackTrace: details.stack,
    );
  };
}

Future<void> main() async {
  firebaseInitialize();
  await Hive.initFlutter();
  HiveDatasource.initHive();
  //insert Service Hive DTO
//database configs insert
  // await Hive.openBox<DatabaseConfigsHiveDTO>('database-configs');
 // await Hive.openBox<List<ServiceHiveDTO>>('services');
  await Hive.openBox<List<HiveLyricDTO>>('lyrics');
  //HiveDatasource dataHive = HiveDatasource<DatabaseConfigsHiveDTO>(boxLabel: 'database-configs');
 // HiveDatasource serviceHive = HiveDatasource<List<ServiceHiveDTO>>(boxLabel: 'services');
  HiveDatasource lyricHive = HiveDatasource<List<HiveLyricDTO>>(boxLabel: 'lyrics');
/*  dataHive.add('database-configs',
    DatabaseConfigsHiveDTO(
      updateAt: DateTime.now(),
     ),
  );*/
  //dataHive.delete('database-configs');
  //serviceHive.delete('services');
  lyricHive.delete('lyrics');
  /*var entities = [
    ServiceHiveDTO(
        id: '1',
        title: 'dsfsf',
        guideIsVisible: true,
        heading: 'sdfd',
        liturgyList: [
          LiturgyHiveDTO(
              isAdditional: true,
              sequence: 'sequence',
              additional: 'additional',
          )
        ],
        lyricsList: [
          LyricHiveDTO(
              albumCover: 'albumCover',
              title: 'title',
              createAt: 'createAt',
              group: 'group',
              verses: [
                VerseHiveDTO(
                  id: '',
                  isChorus: true,
                  versesList: [],
                ),
              ],
              id: '1')
        ],
  ];*/

  //lyricHive.add('services', entities);
  //serviceHive.add('services', entities);

  /*ServiceBloc lyricBloc = ServiceBloc(
    fireServicesUseCases: FireServicesUseCases(
      repository: Repository<Stream<List<Map>>>(
        datasource: FirestoreDatasource(
          firestore: FirebaseFirestore.instance,
        ),
      ),
    ),
    hiveServicesUseCases: HiveServicesUseCases(
      repository: Repository(
        datasource: HiveDatasource<List<ServiceHiveDTO>>(boxLabel: 'services'),
      ),
    ),
  );*/
  LyricBloc lyricBloc = LyricBloc(
    fireLyricsUseCase: LyricsUseCases(
      repository: Repository<Stream<List<Map>>>(
        datasource: FirestoreDatasource(
          firestore: FirebaseFirestore.instance,
        ),
      ),
    ),
    hiveLyricsUseCase: LyricsUseCases(
      repository: Repository(
        datasource: HiveDatasource<List<HiveLyricDTO>>(boxLabel: 'lyrics'),
      ),
    ),lyricsViewModel: LyricsViewModel()
  );

  /*ServiceBloc lyricBloc = ServiceBloc(
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
      bloc: lyricBloc,
    ),
  );
}

class HiveTest extends StatefulWidget {
  const HiveTest({Key? key, required this.bloc}) : super(key: key);
  final LyricBloc bloc;

  @override
  State<HiveTest> createState() => _HiveTestState();
}

class _HiveTestState extends State<HiveTest> {
  late final List entitiesList;
  @override
  void initState() {
    //outra forma é passar list lyricEntity
    List<HiveLyricDTO> entities = [
      HiveLyricDTO(
          albumCover: 'albumCover',
          title: 'title',
          createAt: 'createAt',
          group: 'group',
          verses: [
            HiveVerseDTO(
              id: '1',
              isChorus: true,
              versesList: [],
            ),
          ],
          id: '1'),
      HiveLyricDTO(
          albumCover: 'albumCover',
          title: 'title',
          createAt: 'createAt',
          group: 'group',
          verses: [
            HiveVerseDTO(
              id: '2',
              isChorus: true,
              versesList: [],
            ),
          ],
          id: '2')
    ];
    widget.bloc.add(AddLyricsInHiveEvent(data: entities));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    widget.bloc.add(GetLyricsInHiveEvent());
    return MaterialApp(
      title: 'IPBC Palmas',
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: AppColors.white,
        primaryColor: AppColors.white,
      ),
      home: Scaffold(
        body: BlocBuilder<LyricBloc, LyricState>(
          bloc: widget.bloc,
          builder: (context, state) {
            if (state is InitialState) {
              return const LoadingWidget();
            } else if (state is SuccessfullyFetchedLyricsState) {
              entitiesList = state.entities;
              return Center(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: entitiesList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        entitiesList[index].heading,
                        style: AppFonts.lyricsTitleTile,
                      ),
                      onTap: () {},
                    );
                  },
                ),
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
/*class HiveTest extends StatelessWidget {
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
              return const LoadingWidget();
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
}*/
