import 'dart:ffi';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lyric_module/src/ui/blocs/type_filter.dart';

import '../../../lyric_module.dart';
import '../blocs/lyric_bloc.dart';

class LyricsListView extends StatefulWidget {
  const LyricsListView({super.key});

  @override
  State<LyricsListView> createState() => _LyricsListViewState();
}

class _LyricsListViewState extends State<LyricsListView>
    with TickerProviderStateMixin {
  late final LyricBloc _bloc;
  bool isSelected = false;
  String selectedValue = '';
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    setLightAppBar();
    _bloc = Modular.get<LyricBloc>();
    _bloc.add(CheckConnectivityEvent<LyricEvent>());
  }

  int selectedIndex = 0;

  int selectOptions(int index) {
    selectedIndex = index;
    return selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    // int selectedIndex = 0;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: BlocBuilder<LyricBloc, GenericState<LyricState>>(
            bloc: _bloc,
            builder: (context, state) {
              print(state);
              if (state is LoadingState<LyricState>) {
                return const LoadingWidget(
                  androidRadius: 3,
                  iosRadius: 14,
                  color: AppColors.darkGreen,
                );
              } else if (state is NoConnectionState<LyricState>) {
                return NoConnectionView(
                  action: () => nativeNavigate(
                    LyricModule.initialRoute,
                    context,
                  ),
                );
              } else if (state is DataFetchedState<LyricState, LyricEntity>) {
                // print(escrevendo);
                return RefreshIndicator(
                  color: AppColors.darkGreen,
                  onRefresh: () async {
                    _bloc.add(CheckConnectivityEvent());
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const TitleTopBarWidget(title: "Músicas"),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 38,
                            bottom: 13,
                          ),
                          child: SearchBarWidget(
                            controller: controller,
                            onChange: (value) {
                              bool writing = value.length > 1;
                              _bloc.add(
                                FilterEvent(controller.text, writing,
                                    FilterFactory(), selectedIndex),
                              );
                            },
                            action: () {
                              // _bloc.add(
                              //     FilterEvent(controller.text, selectedIndex));
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 21.5,
                          ),
                          child: OwnChoiceChipsWidget(action: selectOptions),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 24, left: 17),
                              child: Text(
                                "Adicionados recentemente",
                                style: AppFonts.defaultFont(
                                  color: AppColors.grey12,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 14),
                          child: LyricsListWidget(entitiesList: state.entities),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const GenericErrorView();
              }
            },
          ),
        ),
      ),
    );
  }
}
