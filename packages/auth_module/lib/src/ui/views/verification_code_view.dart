import 'dart:developer';

import 'package:auth_module/src/ui/components/banner_error.dart';
import 'package:auth_module/src/ui/components/custom_text_verification_code.dart';
import 'package:auth_module/src/ui/components/textfield_code_numbers.dart';
import 'package:auth_module/src/ui/controller/code_controller.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

/*
VALIDAR O CODIGO DIGITADO;
COLOCAR COR VERMALHA NAS BORDAS DO TEXTFIELDS QUANDO CODIGO ERRADO;
INPLEMENTAR A VERIFICAÇÃO DE E-MAIL;
*/
class VerificationCodePage extends StatefulWidget {
  const VerificationCodePage({super.key});

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  final codeController = Modular.get<CodeController>();

  @override
  Widget build(BuildContext context) {
    validation() {
      if (codeController.textingCode.isNotEmpty) {
        log('TODOS OS Valores dos TextFields preechidos: $codeController.textingCode');
        log(codeController.textingCode + '\n' + codeController.code.join());

        if (codeController.textingCode == codeController.code.join()) {
          Navigator.pushNamed(
            context,
            AuthModule.initialRoute + AuthModule.creatingNewPassWordRoute,
          );
        } else {
          showCustomErrorDialog(
            context,
            'Código Inválido!',
            'Por favor, preencha o verifique o código, e tente novamente.',
          );
        }
      } else {
        showCustomErrorDialog(
          context,
          'Código não Preenchidos!',
          'Por favor, preencha o código de verificação e tente novamente.',
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
              Container(
                width: 100, // Definir largura
                height: 91, // Definir altura
                margin: const EdgeInsets.only(top: 110, bottom: 32),
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
              CustomTextVerificationCode(
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
              const TextfieldCodeNumbers(),
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
                  backgroundColor: codeController.textingCode.isNotEmpty
                      ? AppColors.darkGreen
                      : AppColors.disableButton,
                  shadowColor: AppColors.grey0,
                  foregroundColor: AppColors.white,
                  child: const Text(
                    "Verificar",
                  ),
                ),
              ),
              CustomTextVerificationCode(
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
    ));
  }
}
