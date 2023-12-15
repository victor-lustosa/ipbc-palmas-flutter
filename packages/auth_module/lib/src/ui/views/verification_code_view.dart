import 'package:auth_module/src/ui/components/textfield_code_numbers.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class VerificationCodePage extends StatelessWidget {
  const VerificationCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 60, right: 16, left: 16),
        child: Center(
          child: Column(
            children: [
              const Image(image: AssetImage(AppImages.lock)),
              const Text("Verifique o seu e-mail"),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'Enviamos um código de recuperação de \n senha para o seu email. ',
                      style: AppFonts.defaultFont(
                        color: AppColors.grey10,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: 'Insira-o para \n continuar.',
                      style: AppFonts.defaultFont(
                        color: AppColors.grey10,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const Text("Código de Verificação"),
              const TextfieldCodeNumbers(),
              ElevatedButtonWidget(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                fixedSize: const Size(343, 48),
                action: () {
                  Modular.to.navigate('/auth');
                },
                backgroundColor: AppColors.darkGreen,
                shadowColor: AppColors.grey0,
                foregroundColor: AppColors.white,
                child: const Text(
                  "Verificar",
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
