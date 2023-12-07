import 'package:flutter/material.dart';

class BannerController extends ValueNotifier {
  BannerController() : super(true);

  void setPix() => value = true;
  void setTed() => value = false;
}
