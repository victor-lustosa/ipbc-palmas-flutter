import 'package:flutter/material.dart';

import '../../../core_module.dart';

class MainTopBarManager extends ChangeNotifier {

  MainTopBarManager(){
    _mainTopBarWidget = MainTopBarWidget(key: Modular.get<AppGlobalKeys>().mainTopBarKey ,authKey: Modular.get<AppGlobalKeys>().authAvatarKey,);
  }

  late final MainTopBarWidget _mainTopBarWidget;

  MainTopBarWidget get mainTopBarWidget => _mainTopBarWidget;

  void updateAuthAvatarKey() {
    notifyListeners();
  }
}