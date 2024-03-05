import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../components/password_field_widget.dart';
import '../view_models/password_view_model.dart';

class CreatingNewPasswordView extends StatefulWidget {
  const CreatingNewPasswordView({super.key});

  @override
  State<CreatingNewPasswordView> createState() =>
      _CreatingNewPasswordViewState();
}

class _CreatingNewPasswordViewState extends State<CreatingNewPasswordView> {
  final passwordController = Modular.get<PasswordViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 33),
                    child: const BackButtonWidget(
                        route: AuthModule.initialRoute +
                            AuthModule.verificationCodeRoute),
                  ),
                ],
              ),
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
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Column(
                    children: [
                      PasswordFieldWidget(
                        borderSideColor: isPasswordValid(
                                passwordController.passwordControllerValue)
                            ? AppColors.grey8
                            : AppColors.delete,
                        controller: passwordController.passwordController,
                        textLabel: 'Senha',
                        onChanged: (value) {
                          setState(() {
                            passwordController.setValuePass(value);
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      PasswordFieldWidget(
                        borderSideColor: isPasswordValid(passwordController
                                    .passwordControllerValue) &&
                                arePasswordsEqual(
                                    passwordController.passwordControllerValue,
                                    passwordController
                                        .confirmPasswordControllerValue)
                            ? AppColors.grey8
                            : AppColors.delete,
                        controller:
                            passwordController.confirmPasswordController,
                        textLabel: 'Repetir senha',
                        onChanged: (value) {
                          setState(() {
                            passwordController.setValueConfirmPass(value);
                          });
                        },
                      )
                    ],
                  )),
              Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  " * Deve conter no mínimo 8 dígitos.",
                  style: AppFonts.defaultFont(
                      color: isPasswordValid(
                              passwordController.passwordControllerValue)
                          ? AppColors.darkGreen
                          : AppColors.grey8,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: arePasswordsEqual(
                        passwordController.passwordControllerValue,
                        passwordController.confirmPasswordControllerValue)
                    ? const SizedBox()
                    : Text(
                        " * Atenção! As senhas não correspondem.",
                        style: AppFonts.defaultFont(
                            color: AppColors.delete,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 87,
                ),
                child: ElevatedButtonWidget(
                  action: () {
                    passwordController.confirmPasswordControllerValue;
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  fixedSize: const Size(364, 48),
                  backgroundColor: isPasswordValid(
                              passwordController.passwordControllerValue) &&
                          arePasswordsEqual(
                              passwordController.passwordControllerValue,
                              passwordController.confirmPasswordControllerValue)
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

  bool isPasswordValid(String password) {
    return password.length > 7;
  }

  bool arePasswordsEqual(String password, String confirmPassword) {
    return password == confirmPassword;
  }
}
