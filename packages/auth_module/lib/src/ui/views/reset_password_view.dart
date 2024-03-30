import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  static const String emailMock = "victor@gmail.com";

  final String _emailErrorText = 'por favor, insira um email válido.';
  final _emailKey = GlobalKey<FormState>();

  final TextEditingController _resetPasswordController = TextEditingController();
  bool _isEmailValid = true;
  final bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 60,
            ),
            width: context.mediaQuery.size.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButtonWidget(
                      action: () => Modular.to.navigate(
                        AuthModule.authRoute + AuthModule.authRoute,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Redefinir senha",
                  style: AppFonts.defaultFont(
                    color: AppColors.grey10,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 32,
                    bottom: 200,
                  ),
                  child: TemplateFormWidget(
                    titleMargin: const EdgeInsets.only(bottom: 4),
                    horizontalSymmetric: EdgeInsets.zero,
                    controller: _resetPasswordController,
                    title: 'Insira seu e-mail ou telefone',
                    isValid: _isEmailValid,
                    errorText: _emailErrorText,
                    globalKey: _emailKey,
                    isPressed: _isPressed,
                    inputDecoration: fieldInputDecoration(
                      isValid: _isEmailValid,
                      hintText: 'Email',
                    ),
                    validator: (data) {
                      return _emailValidation(data);
                    },
                  ),
                ),
                ButtonWidget(
                  action: () {
                    if (_resetPasswordController.text.isEmpty && !_isPressed) {
                      _emailBorderValidation(false);
                    }
                    if (emailMock == _resetPasswordController.text) {
                      Modular.to.navigate(AuthModule.authRoute +
                          AuthModule.verificationCodeRoute);
                    } else {
                      showCustomErrorDialog(
                        context: context,
                        title: 'E-mail inválido!',
                        message:
                            'Por favor, verifique seu e-mail e tente novamente.',
                      );
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  fixedSize: Size(context.mediaQuery.size.width, 48),
                  backgroundColor: emailMock == _resetPasswordController.text
                      ? AppColors.darkGreen
                      : AppColors.disableButton,
                  shadowColor: AppColors.grey0,
                  foregroundColor: AppColors.white,
                  child: const Text(
                    "Enviar",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _emailBorderValidation(bool value) {
    Future.delayed(Duration.zero, () async {
      if (mounted) {
        setState(() {
          _isEmailValid = value;
        });
      }
    });
  }

  _emailValidation(String? data) {
    if (data == null || data.isEmpty) {
      _emailBorderValidation(false);
    } else {
      if (EmailValidator.validate(_resetPasswordController.text)) {
        _emailBorderValidation(true);
      } else {
        _emailBorderValidation(false);
      }
    }
  }
}
