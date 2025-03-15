import 'package:flutter/material.dart';

import '../../../core_module.dart';

class AppGlobalKeys extends ChangeNotifier{
  GlobalKey<AuthCircleAvatarWidgetState> _homeAuthAvatarKey = GlobalKey();
  //GlobalKey<AuthCircleAvatarWidgetState> _authAvatarKey = GlobalKey();

  GlobalKey<AuthCircleAvatarWidgetState> get homeAuthAvatarKey => _homeAuthAvatarKey;
  //G/lobalKey<AuthCircleAvatarWidgetState> get authAvatarKey => _authAvatarKey;

  void resetHomeAuthAvatarKey() {
    _homeAuthAvatarKey = GlobalKey<AuthCircleAvatarWidgetState>();
    notifyListeners();
  }

  notifyChanges(){
    notifyListeners();
  }
 // void resetAuthAvatarKey() {
 //   _authAvatarKey = GlobalKey<AuthCircleAvatarWidgetState>();
 //   notifyListeners();
 // }
}

