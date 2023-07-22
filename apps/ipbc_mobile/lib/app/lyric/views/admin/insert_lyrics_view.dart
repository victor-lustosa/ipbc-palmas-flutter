import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/components/search-bar/search_bar_widget.dart';
import '../../view-models/lyrics_view_model.dart';

class InsertLyricsView extends StatefulWidget {
  const InsertLyricsView({super.key});

  @override
  State<InsertLyricsView> createState() => _InsertLyricsViewState();
}

class _InsertLyricsViewState extends State<InsertLyricsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 19, top: 30),
            child: SearchBarWidget(
              formFieldController:
                  context.read<LyricsViewModel>().formFieldController,
              action: context.read<LyricsViewModel>().fetchingSearch,
            ),
          ),
        ],
      ),
    );
  }
}
