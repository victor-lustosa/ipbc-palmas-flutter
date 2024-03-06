import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../components/password_field_widget.dart';

class CreatingNewPasswordView extends StatefulWidget {
  const CreatingNewPasswordView({super.key});

  @override
  State<CreatingNewPasswordView> createState() =>
      _CreatingNewPasswordViewState();
}

class _CreatingNewPasswordViewState extends State<CreatingNewPasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
                    margin: const EdgeInsets.only(top: 60),
                    child: BackButtonWidget(
                      action: () => Modular.to.navigate(
                        AuthModule.initialRoute +
                            AuthModule.verificationCodeRoute,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  top: 10.11,
                  bottom: 53.89,
                ),
                child: Column(
                  children: [
                    Text(
                      "Criando uma nova senha",
                      style: AppFonts.defaultFont(
                        color: AppColors.grey10,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Crie sua senha",
                  style: AppFonts.defaultFont(
                    color: AppColors.grey8,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  children: [
                    PasswordFieldWidget(
                      borderSideColor: isPasswordValid(_passwordController.text)
                          ? AppColors.secondaryGrey
                          : AppColors.secondaryGrey,
                      controller: _passwordController,
                      textLabel: 'Senha',
                    ),
                    const SizedBox(height: 8),
                    PasswordFieldWidget(
                      borderSideColor: isValid
                          ? AppColors.secondaryGrey
                          : AppColors.secondaryGrey,
                      controller: _confirmPasswordController,
                      textLabel: 'Repetir senha',
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  " * Deve conter no mínimo 8 dígitos.",
                  style: AppFonts.defaultFont(
                    color: isPasswordValid(_passwordController.text)
                        ? AppColors.darkGreen
                        : AppColors.grey8,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: arePasswordsEqual(
                  _passwordController.text,
                  _confirmPasswordController.text,
                )
                    ? const SizedBox()
                    : Text(
                        " * Atenção! As senhas não correspondem.",
                        style: AppFonts.defaultFont(
                          color: AppColors.delete,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 93,
                ),
                child: ElevatedButtonWidget(
                  action: () {
                    if (isValid) {
                      Modular.to.navigate(AuthModule.authRoute +
                          AuthModule.resetPasswordSuccessRoute);
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  fixedSize: const Size(364, 48),
                  backgroundColor:
                      isValid ? AppColors.darkGreen : AppColors.disableButton,
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

  bool get isValid =>
      isPasswordValid(_passwordController.text) &&
      arePasswordsEqual(
        _passwordController.text,
        _confirmPasswordController.text,
      );

  bool isPasswordValid(String password) {
    return password.length > 7;
  }

  bool arePasswordsEqual(String password, String confirmPassword) {
    return password == confirmPassword;
  }
}
