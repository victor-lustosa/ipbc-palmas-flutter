import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {

  int selectedIndex = 0;

  jumpToPage(int index){
    selectedIndex = index;
    notifyListeners();
  }

  fetchingSearch() {
    //print('chegueii');
  }
}