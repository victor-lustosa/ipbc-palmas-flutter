import 'package:flutter/material.dart';

import 'package:ipbc_palmas/app/home/views/home_view.dart';

import 'shared/configs/app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'IPBC Palmas',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const HomeView(),
        initialRoute: "/",
        onGenerateRoute: AppRoutes.onGenerateRoute,
        debugShowCheckedModeBanner: false);
  }
}
