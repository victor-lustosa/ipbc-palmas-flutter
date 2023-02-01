import 'package:flutter/material.dart';
import 'package:ipbc_palmas/app/shared/layout/top-bar/main_top_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/lyric_bloc.dart';
import '../../../shared/components/back-button/back_button_widget.dart';
import '../../../shared/configs/app_configs.dart';
import '../../domain/entities/lyric_entity.dart';
import '../components/lyrics_list_widget.dart';

class ChosenLyricsListView extends StatefulWidget {
  const ChosenLyricsListView({super.key, required this.url});
  final String url;
  @override
  State<ChosenLyricsListView> createState() => _ChosenLyricsListViewState();
}

class _ChosenLyricsListViewState extends State<ChosenLyricsListView> {
  late LyricBloc bloc;
  @override
  void initState() {
    bloc = context.read<LyricBloc>();
    bloc.add(GetLyricsEvent(url: widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LyricBloc, LyricState>(
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
          } else if (state is SuccessfullyFetchedLyricsState) {
            //TODO: autor, ano de produçao
            //TODO: ADICIONAR MENSAGEM DE NENHUM RESULTADO ENCONTRADO
            return SafeArea(
              child: SingleChildScrollView(
                child: RefreshIndicator(
                  color: AppColors.darkGreen,
                  onRefresh: () async {
                    bloc.add(
                      GetLyricsEvent(url: widget.url),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const MainTopBarWidget(),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Align(
                          alignment: Alignment(-0.97, 0),
                          child: BackButtonWidget(
                            color: AppColors.darkGreen,
                            size: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Align(
                          alignment: const Alignment(-0.74, 0),
                          child: Text(
                            "Músicas de domingo de manhã",
                            style: AppFonts.headline,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                        ),
                        child: LyricsListWidget(
                          lyricsList: state.entities,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Text("erro na tela [chosen lyrics list view]"),
            );
          }
        },
      ),
    );
  }
}
