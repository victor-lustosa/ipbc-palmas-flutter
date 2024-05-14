import 'package:flutter/material.dart';

class BannerController extends ChangeNotifier {
  bool isPix = true;

  void setPix() {
    isPix = true;
    notifyListeners();
  }

  void setTed(){
    isPix = false;
    notifyListeners();
  }
}
