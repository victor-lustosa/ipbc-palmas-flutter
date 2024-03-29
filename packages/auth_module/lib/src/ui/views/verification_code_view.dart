import 'dart:developer';

import 'package:auth_module/src/ui/components/text_verification_widget.dart';
import 'package:auth_module/src/ui/components/text_code_widget.dart';
import 'package:auth_module/src/ui/view_models/password_view_model.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

/*
VALIDAR O CODIGO DIGITADO;
COLOCAR COR VERMALHA NAS BORDAS DO TEXTFIELDS QUANDO CODIGO ERRADO;
INPLEMENTAR A VERIFICAÇÃO DE E-MAIL;
*/
class VerificationCodeView extends StatefulWidget {
  const VerificationCodeView({super.key});

  @override
  State<VerificationCodeView> createState() => _VerificationCodeViewState();
}

class _VerificationCodeViewState extends State<VerificationCodeView> {
  final codeController = Modular.get<PasswordViewModel>();
  List<String> inputCode = [];
  final List<int> code = [1, 2, 3, 4, 5, 8]; // Code Mockado;

  @override
  Widget build(BuildContext context) {
    validation() {
      inputCode = codeController.controllers
          .map((controller) => controller.text)
          .toList();
      if (inputCode.every((value) => value.isNotEmpty)) {
        if (inputCode.join() == code.join()) {
          Navigator.pushNamed(
            context,
            AuthModule.initialRoute + AuthModule.creatingNewPassWordRoute,
          );
        } else {
          showCustomErrorDialog(
           context: context,
            title: 'Código Inválido!',
            message: 'Por favor, verifique o código, e tente novamente.',
          );
        }
      } else {
        showCustomErrorDialog(
          context: context,
          title: 'Código não Preenchidos!',
          message: 'Por favor, preencha o código de verificação e tente novamente.',
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: context.mediaQuery.size.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 17, top: 33),
                      child: BackButtonWidget(
                        action: () => Modular.to.navigate(
                          AuthModule.initialRoute + AuthModule.resetPasswordRoute,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 100,
                  // Definir largura
                  height: 91,
                  // Definir altura
                  margin: const EdgeInsets.only(bottom: 32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.35),
                    color: AppColors.badgeGreen,
                  ),
                  child: const Image(
                    image: AssetImage(
                      AppImages.emailVerification,
                    ),
                    width: 60,
                    height: 52,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    "Verifique o seu e-mail",
                    style: AppFonts.defaultFont(
                        color: AppColors.grey10,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                TextVerificationWidget(
                  textOne:
                      'Enviamos um código de recuperação de \n senha para o seu email. ',
                  styleOne: AppFonts.defaultFont(
                    color: AppColors.grey8,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  textTwo: 'Insira-o para \n continuar.',
                  styleTwo: AppFonts.defaultFont(
                      color: AppColors.grey10,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 26.99, bottom: 16),
                  child: Text(
                    "Código de Verificação",
                    style: AppFonts.defaultFont(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
                const TextCodeWidget(),
                Container(
                  margin: const EdgeInsets.only(
                    top: 16,
                  ),
                  child: ElevatedButtonWidget(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    fixedSize: const Size(343, 48),
                    action: validation,
                    backgroundColor: inputCode.isNotEmpty
                        ? AppColors.darkGreen
                        : AppColors.disableButton,
                    shadowColor: AppColors.grey0,
                    foregroundColor: AppColors.white,
                    child: const Text(
                      "Verificar",
                    ),
                  ),
                ),
                TextVerificationWidget(
                    textOne:
                        'Não recebeu o e-mail? Verifique na caixa de spam, \n ',
                    styleOne: AppFonts.defaultFont(
                        color: AppColors.fullBlack,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                    textTwo: 'tente novamente, clicando aqui.',
                    styleTwo: AppFonts.defaultFont(
                        color: AppColors.darkGreen,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                    onTapTextTwo: () {
                      log('Tentando Novamente');
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
