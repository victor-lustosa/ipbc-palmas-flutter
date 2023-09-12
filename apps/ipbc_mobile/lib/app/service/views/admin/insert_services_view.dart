import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../../shared/view-models/services_view_model.dart';

class InsertServicesView extends StatefulWidget {
  const InsertServicesView({super.key});

  @override
  State<InsertServicesView> createState() => _InsertServicesViewState();
}

class _InsertServicesViewState extends State<InsertServicesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 19, top: 30),
            child: SearchBarWidget(
              controller: Modular.get<ServicesViewModel>().controller,
              action: Modular.get<ServicesViewModel>().fetchingSearch,
            ),
          ),
        ],
      ),
    );
  }
}
