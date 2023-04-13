import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../exception/view/generic_error_view.dart';
import '../../../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../../../lyric/presentation/view-models/lyrics_view_model.dart';
import '../../../home/views/home_view.dart';
import '../../../shared/components/loading/loading_widget.dart';
import '../../../shared/components/utils/validation_util.dart';
import '../blocs/database_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final DatabaseBloc bloc;
  late HiveDatabaseConfigsDTO data;
  late final LyricsViewModel lyricsViewModel;
  final String fireDatabase = 'firebase';
  final String initialId = 'fdg33f345';
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
            data = state.entity;
            if ((ValidationUtil.validationDatasource() == fireDatabase) || (data.hiveUpdateId != initialId)) {
              String fireUpdateId = await ValidationUtil.verifyUpdateFirebase(context);
              if (data.fireUpdateId != fireUpdateId) {
                data = data.copyWith(
                  fireUpdateId: fireUpdateId,
                  isServicesUpdated: false,
                  isLyricsUpdated: false,
                  isSaturdayCollectionUpdated: false,
                  isSundayEveningCollectionUpdated: false,
                  isSundayMorningCollectionUpdated: false,
                );
              }
            }
            if (data.isLyricsUpdated &&
                data.isSundayMorningCollectionUpdated &&
                data.isSaturdayCollectionUpdated &&
                data.isSundayEveningCollectionUpdated &&
                data.isServicesUpdated) {
              data = data.copyWith(isSystemUpdated: true);
            }
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
