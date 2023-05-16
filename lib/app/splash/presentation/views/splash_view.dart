import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../blocs/database_bloc.dart';
import '../../../splash/presentation/view-models/database_view_model.dart';
import '../../../exception/views/generic_error_view.dart';
import '../../../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../../../home/views/home_view.dart';
import '../../../shared/components/loading/loading_widget.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final DatabaseBloc bloc;
  late HiveDatabaseConfigsDTO data;
  @override
  initState() {
    bloc = context.read<DatabaseBloc>();
    bloc.add(GetDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DatabaseBloc, DatabasesState>(
        listener: (context, state) async {
          if (state is FetchingDataState) {
            data = await context.read<DatabaseViewModel>().validateDatabase(context, state.entity);
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
            return Provider(
              create: (_) => data,
              child: const HomeView(),
            );
          } else {
            return const GenericErrorView();
          }
        },
      ),
    );
  }
}
