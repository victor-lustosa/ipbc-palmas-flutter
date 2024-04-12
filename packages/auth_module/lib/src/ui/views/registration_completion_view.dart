import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class RegistrationCompletionView extends StatefulWidget {
  const RegistrationCompletionView({super.key});

  @override
  State<RegistrationCompletionView> createState() =>
      _RegistrationCompletionViewState();
}

class _RegistrationCompletionViewState
    extends State<RegistrationCompletionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 72, left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButtonWidget(
                      action: () => Modular.to.navigate(
                          AuthModule.authRoute + AuthModule.createAccountRoute),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12.5),
                child: Text(
                  'Finalize sua conta',
                  style: AppFonts.defaultFont(
                    color: AppColors.grey10,
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
