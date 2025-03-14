import 'package:flutter/material.dart';

import '../../../core_module.dart';

class MainTopBarManager extends ChangeNotifier {

  MainTopBarManager(){
    _mainTopBarWidget = MainTopBarWidget();
  }

  late MainTopBarWidget _mainTopBarWidget;


  MainTopBarWidget get mainTopBarWidget => _mainTopBarWidget;

  void update() {
    _mainTopBarWidget = MainTopBarWidget(key: GlobalKey());
    notifyListeners();
  }
}