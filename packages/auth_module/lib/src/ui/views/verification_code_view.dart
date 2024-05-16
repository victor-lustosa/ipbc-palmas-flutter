import 'dart:developer';

import 'package:auth_module/src/ui/components/text_verification_widget.dart';
import 'package:auth_module/src/ui/components/text_code_widget.dart';
import 'package:auth_module/src/ui/stores/reset_password_store.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../../auth_module.dart';

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
  final _store = Modular.get<ResetPasswordStore>();
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _store,
      builder: (_, state, child) {
        if (state is LoadingState<ResetPasswordState>) {
          _isPressed = true;
        }

        if (state is InitialState<ResetPasswordState>) {
          _isPressed = false;
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
                          margin: const EdgeInsets.only(
                            left: 17,
                            top: 60,
                          ),
                          child: BackButtonWidget(
                            action: () => pop(context),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 100,
                      height: 91,
                      margin: const EdgeInsets.only(bottom: 24),
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
                          fontWeight: FontWeight.w400,
                        ),
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
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 40,
                        bottom: 26,
                      ),
                      child: Text(
                        "Código de Verificação",
                        style: AppFonts.defaultFont(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const TextCodeWidget(),
                    LoadingButtonWidget(
                      isPressed: _isPressed,
                      marginTop: 26,
                      loadingWidth: 80,
                      marginBottom: 22,
                      action: () => _store.isListFull
                          ? _store.validateCode(context)
                          : null,
                      isValid: _store.isListFull,
                      label: "Verificar",
                    ),
                    TextVerificationWidget(
                        textOne:
                            'Não recebeu o e-mail? Verifique na caixa de spam, \n ',
                        styleOne: AppFonts.defaultFont(
                          color: AppColors.fullBlack,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        textTwo: 'tente novamente, clicando aqui.',
                        styleTwo: AppFonts.defaultFont(
                          color: AppColors.darkGreen,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                        onTapTextTwo: () {
                          log('Tentando Novamente');
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _store.isError = false;
    _store.isListFull = false;
    super.dispose();
  }
}
