import 'package:flutter/material.dart';

import '../../../core_module.dart';

class AppGlobalKeys extends ChangeNotifier{
  GlobalKey<AuthCircleAvatarWidgetState> _homeAuthAvatarKey = GlobalKey();
  GlobalKey<AuthCircleAvatarWidgetState> _mainTopBarKey = GlobalKey();
  GlobalKey<AuthCircleAvatarWidgetState> _authAvatarKey = GlobalKey();

  GlobalKey<AuthCircleAvatarWidgetState> get homeAuthAvatarKey => _homeAuthAvatarKey;
  GlobalKey<AuthCircleAvatarWidgetState> get mainTopBarKey => _mainTopBarKey;
  GlobalKey<AuthCircleAvatarWidgetState> get authAvatarKey => _authAvatarKey;

  void resetHomeAuthAvatarKey() {
    _homeAuthAvatarKey = GlobalKey<AuthCircleAvatarWidgetState>();
    notifyListeners();
  }
  void resetAuthAvatarKey() {
    _authAvatarKey = GlobalKey<AuthCircleAvatarWidgetState>();
    notifyListeners();
  }
}

