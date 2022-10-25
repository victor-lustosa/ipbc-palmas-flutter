import 'package:flutter/material.dart';

import '../../lyric/blocs/lyric_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final LyricBloc _bloc;

  @override
  void initState() {
    super.initState();
    //_bloc = LyricBloc(getLyrics: getLyrics);
    _bloc.add(GetLyricsEvent());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("home view")),
    );
  }
}
