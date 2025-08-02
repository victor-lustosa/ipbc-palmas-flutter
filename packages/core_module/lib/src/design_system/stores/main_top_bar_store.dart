import 'package:flutter/material.dart';

import '../../../core_module.dart';

class MainTopBarStore extends ChangeNotifier {

  MainTopBarStore(){
    _mainTopBarWidget = MainTopBarWidget();
  }

  late final MainTopBarWidget _mainTopBarWidget;

  MainTopBarWidget get mainTopBarWidget => _mainTopBarWidget;

  void updateAuthAvatarKey() {
    notifyListeners();
  }
}