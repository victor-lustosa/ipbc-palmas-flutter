import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/ibpc_bloc_observer.dart';
import 'app/app_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = IpbcBlocObserver();
  runApp(const AppWidget());
}
