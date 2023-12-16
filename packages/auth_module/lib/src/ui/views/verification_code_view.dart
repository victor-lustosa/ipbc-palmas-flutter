import 'package:auth_module/src/ui/components/custom_text_verification_code.dart';
import 'package:auth_module/src/ui/components/textfield_code_numbers.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class VerificationCodePage extends StatelessWidget {
  const VerificationCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: [
            Stack(children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.35),
                    color: AppColors.badgeGreen),
                margin: const EdgeInsets.only(top: 100, bottom: 24),
                width: 100, // Define a largura como o máximo disponível
                height: 91, // Define a altura conforme necessário
              ),
              Positioned.fill(
                child: Container(
                  margin: const EdgeInsets.only(top: 110, bottom: 24),
                  child: const Image(
                    image: AssetImage(
                      AppImages.emailVerification,
                    ),
                    width: 60,
                    height: 52,
                  ),
                ),
              ),
            ]),
            Container(
              margin: const EdgeInsets.only(
                top: 8,
              ),
              child: Text(
                "Verifique o seu e-mail",
                style: AppFonts.defaultFont(
                    color: AppColors.grey8,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
            CustomTextVerificationCode(
              textOne:
                  'Enviamos um código de recuperação de \n senha para o seu email. ',
              styleOne: AppFonts.defaultFont(
                color: AppColors.grey8,
                fontSize: 15,
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
                )),
            const TextfieldCodeNumbers(),
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 36),
              child: ElevatedButtonWidget(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                fixedSize: const Size(343, 48),
                action: () {
                  Modular.to.navigate('/ ');
                },
                backgroundColor: AppColors.darkGreen,
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
                    color: AppColors.grey8,
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
                textTwo: 'tente novamente, clicando aqui.',
                styleTwo: AppFonts.defaultFont(
                    color: AppColors.darkGreen,
                    fontSize: 13,
                    fontWeight: FontWeight.w700),
                onTapTextTwo: () {
                  print('Text');
                }),
          ],
        ),
      ),
    ));
  }
}
