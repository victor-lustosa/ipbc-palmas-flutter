import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../components/email_field_widget.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {

  static const String emailMock = "victor@gmail.com";

  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _resetPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: context.mediaQuery.size.width,
            child: Container(
              margin: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 33),
                        child: BackButtonWidget(
                          action: () => Modular.to.navigate(
                              AuthModule.initialRoute + AuthModule.authRoute),
                        ),
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
                      "Redefinir senha",
                      style: AppFonts.defaultFont(
                          color: AppColors.grey10,
                          fontSize: 22,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Insira seu e-mail ou telefone",
                      style: AppFonts.defaultFont(
                          color: AppColors.grey8,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    child: EmailFieldWidget(
                      onChanged: (value) {
                        setState(() {});
                      },
                      textLabel: 'Email',
                      inputTextColor: (emailMock == _resetPasswordController.text
                          ? AppColors.greenInputAccept
                          : AppColors.delete),
                      borderSideColor: _resetPasswordController.text.isEmpty
                          ? AppColors.grey8
                          : (emailMock == _resetPasswordController.text
                              ? AppColors.disableButton
                              : AppColors.delete),
                      controller: _resetPasswordController,
                      iconPath: emailMock == _resetPasswordController.text
                          ? AppIcons.emailSuccess
                          : AppIcons.emailNotValid,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 40,
                    ),
                    child: ElevatedButtonWidget(
                      action: () {
                        if (emailMock == _resetPasswordController.text) {
                          Modular.to.navigate(AuthModule.initialRoute + AuthModule.verificationCodeRoute);
                        } else {
                          //_showErrorDialog();
                          showCustomErrorDialog(
                            context: context,
                            title: 'E-mail inválido!',
                            message: 'Por favor, verifique seu e-mail e tente novamente.',
                          );
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      fixedSize: Size(MediaQuery.of(context).size.width, 48),
                      backgroundColor: emailMock == _resetPasswordController.text
                          ? AppColors.darkGreen
                          : AppColors.disableButton,
                      shadowColor: AppColors.grey0,
                      foregroundColor: AppColors.white,
                      child: const Text(
                        "Enviar",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
