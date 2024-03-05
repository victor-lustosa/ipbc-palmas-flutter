import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';


class InsertServicesView extends StatefulWidget {
  const InsertServicesView({super.key});

  @override
  State<InsertServicesView> createState() => _InsertServicesViewState();
}

class _InsertServicesViewState extends State<InsertServicesView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.grey4,
        width: context.mediaQuery.size.width,
        child: SafeArea(
          child: ServiceTopBarWidget(
            entity: ServicesModel.empty(),
          ),
        ),
      ),
    );
  }
}
