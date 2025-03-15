import 'package:flutter/material.dart';

import '../../../core_module.dart';

class MainTopBarManager extends ChangeNotifier {

  MainTopBarManager(){
    _mainTopBarWidget = MainTopBarWidget();
  }

  late final MainTopBarWidget _mainTopBarWidget;


  MainTopBarWidget get mainTopBarWidget => _mainTopBarWidget;

  void notifyChanges() {
    notifyListeners();
  }
}