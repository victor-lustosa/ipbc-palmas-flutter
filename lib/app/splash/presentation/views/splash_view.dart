import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../splash/presentation/view-models/database_view_model.dart';
import '../../../core/external/firestore_datasource.dart';
import '../../../exception/view/generic_error_view.dart';
import '../../../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../../../home/views/home_view.dart';
import '../../../shared/components/loading/loading_widget.dart';
import '../blocs/database_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final DatabaseBloc bloc;
  late final DatabaseViewModel databaseViewModel;
  late HiveDatabaseConfigsDTO data;
  late final DatabaseViewModel lyricsViewModel;
  final String fireDatabase = 'firebase';
  final String initialId = 'fdg33f345';
  @override
  initState() {
    bloc = context.read<DatabaseBloc>();
    bloc.add(GetDataEvent());
    databaseViewModel = context.read<DatabaseViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DatabaseBloc, DatabasesState>(
        listener: (context, state) async {
          if (state is FetchingDataState) {
            data = await databaseViewModel.validateDatabase(fireDatabase, context.read<FirestoreDatasource>(), state.entity, initialId);
            bloc.add(UpdateDataEvent(data: data));
          }
        },
        bloc: bloc,
        builder: (context, state) {
          if (state is LoadingState) {
            return const LoadingWidget();
          } else if (state is FetchingDataState) {
            return const LoadingWidget();
          } else if (state is SuccessfullyFetchedDataState) {
            return Provider(create: (_) => data, child: const HomeView());
          } else {
            return const GenericErrorView();
          }
        },
      ),
    );
  }
}
