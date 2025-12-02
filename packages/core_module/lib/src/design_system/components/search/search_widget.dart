import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'search_bar_widget.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key, required this.storeId});
  final int storeId;
  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late final SearchStore _store;

  @override
  void initState() {
    super.initState();
    _store = Modular.get<SearchStore>();
    _store.init(widget.storeId);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _store,
      builder: (_, state, child) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 13),
              child: SearchBarWidget(
                controller: _store.searchController,
                onChange: (value) {
                    _store.searchLyrics(value);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 21.5),
              child: OwnChoiceChipsWidget(
                hasEmptyOption: false,
                options: SearchParameters.values,
                action: (value) {
                  _store.selectOptions(value);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
