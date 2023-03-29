
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipbc_palmas/app/lyric/presentation/view-models/lyrics_view_model.dart';
import 'package:provider/provider.dart';
import '../../../home/views/home_view.dart';
import '../../../lyric/lyric_module.dart';
import '../../../shared/configs/app_configs.dart';
import '../blocs/database_bloc.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final DatabaseBloc databaseBloc;
  late final LyricsViewModel lyricsViewModel;
  final String database = 'firebase';
  final String path = 'database-configs';
  @override
  initState() {
    super.initState();
    lyricsViewModel = LyricsViewModel();
    databaseBloc = context.read<DatabaseBloc>();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        //databaseBloc.add(GetDataEvent(path: path));
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DatabaseBloc, DatabasesState>(
        listener: (context, state) async {
          if (state is SuccessfullyFetchedDataState) {
            lyricsViewModel.createInstances(state.entity.updateAt);
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
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.darkGreen,
                ),
              ),
            );

          } else {
            return MultiProvider(
              providers: [...lyricModule],
              child: const HomeView(),
            
            );
          }
        },
      ),
    );
  }
}
