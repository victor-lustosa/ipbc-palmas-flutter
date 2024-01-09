import 'dart:developer';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../components/password_fields.dart';

class CreatingNewPasswordView extends StatefulWidget {
  const CreatingNewPasswordView({super.key});

  @override
  State<CreatingNewPasswordView> createState() =>
      _CreatingNewPasswordViewState();
}

class _CreatingNewPasswordViewState extends State<CreatingNewPasswordView> {
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  bool passwordsMatch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            left: 16,
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  top: 108.11,
                  bottom: 53.89,
                ),
                child: Text(
                  "Criando uma nova senha",
                  style: AppFonts.defaultFont(
                      color: AppColors.grey10,
                      fontSize: 22,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Crie sua senha",
                  style: AppFonts.defaultFont(
                      color: AppColors.grey8,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 8, right: 16, bottom: 8),
                  child: Column(
                    children: [
                      CustomPasswordField(
                        controller: passwordController1,
                        textLabel: 'Senha',
                      ),
                      const SizedBox(height: 8),
                      CustomPasswordField(
                        controller: passwordController2,
                        textLabel: 'Repetir senha',
                        onChanged: (value) {
                          setState(() {
                            passwordsMatch = passwordController1.text ==
                                passwordController2.text;
                          });
                        },
                      )
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    " - Deve conter no mínimo 8 dígitos.",
                    style: AppFonts.defaultFont(
                        color: AppColors.grey8,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 87,
                ),
                child: ElevatedButtonWidget(
                  action: () {
                    print(passwordsMatch);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  fixedSize: const Size(364, 48),
                  backgroundColor: passwordsMatch
                      ? AppColors.darkGreen
                      : AppColors.disableButton,
                  shadowColor: AppColors.grey0,
                  foregroundColor: AppColors.white,
                  child: const Text(
                    "Redefinir senha",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
