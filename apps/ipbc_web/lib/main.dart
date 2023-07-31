import 'package:flutter/material.dart';
import 'src/app_widget.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const AppWidget());
}

