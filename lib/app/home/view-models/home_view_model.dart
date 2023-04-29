import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../configs/app_routes.dart';

class HomeViewModel extends ChangeNotifier{

  int selectedIndex = 0;

  Future<bool> systemBackButtonPressed() async {
    GlobalKey<NavigatorState> navigatorKey = AppRoutes.getAndroidNavigatorKey();
    if (navigatorKey.currentState != null && navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState?.pop(navigatorKey.currentContext);
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    }
    throw Exception();
  }

  jumpToPage(int index){
    selectedIndex = index;
    notifyListeners();
  }

}