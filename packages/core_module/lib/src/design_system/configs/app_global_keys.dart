import 'package:flutter/material.dart';

import '../../../core_module.dart';

class AppGlobalKeys extends ChangeNotifier{
  GlobalKey<AuthCircleAvatarWidgetState> _authAvatarKey = GlobalKey();

  GlobalKey<AuthCircleAvatarWidgetState> get authAvatarKey => _authAvatarKey;

  void resetAuthAvatarKey() {
    _authAvatarKey = GlobalKey<AuthCircleAvatarWidgetState>();
    notifyListeners();
  }
}

