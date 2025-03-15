import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../../auth_module.dart';

class CreatingNewPasswordView extends StatefulWidget {
  const CreatingNewPasswordView({super.key});

  @override
  State<CreatingNewPasswordView> createState() =>
      _CreatingNewPasswordViewState();
}

class _CreatingNewPasswordViewState extends State<CreatingNewPasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _confirmPasswordKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();

  final String _confirmPasswordErrorText = 'por favor, insira um email válido.';
  final String _passwordErrorText = 'por favor, insira uma senha.';

  bool _isConfirmPasswordValid = true;
  bool _isPasswordValid = true;
  bool _obscure = true;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    suffixAction() => setState(() {
      _obscure = !_obscure;
    });
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: context.sizeOf.width,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 16, top: 60),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [BackButtonWidget(action: () => pop(context))],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.11, bottom: 53.89),
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
                TemplateFormWidget(
                  controller: _passwordController,
                  title: 'Crie sua senha',
                  isValid: _isPasswordValid,
                  titleMargin: const EdgeInsets.only(bottom: 4),
                  errorText: _passwordErrorText,
                  globalKey: _passwordKey,
                  isPressed: isPressed,
                  obscure: _obscure,
                  inputDecoration: fieldInputDecoration(
                    isValid: _isPasswordValid,
                    hintText: 'Senha',
                    contentPadding: const EdgeInsets.only(left: 16, top: 9),
                    suffixIcon: HideIconWidget(
                      isObscure: _obscure,
                      suffixAction: suffixAction,
                    ),
                  ),
                  validator: (data) {
                    return _passwordValidation(data);
                  },
                  defaultHintColor: AppColors.hintInputForm,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  child: TemplateFormWidget(
                    controller: _confirmPasswordController,
                    isValid: _isConfirmPasswordValid,
                    errorText: _confirmPasswordErrorText,
                    globalKey: _confirmPasswordKey,
                    isPressed: isPressed,
                    obscure: _obscure,
                    inputDecoration: fieldInputDecoration(
                      isValid: _isConfirmPasswordValid,
                      hintText: 'Repetir senha',
                      contentPadding: const EdgeInsets.only(left: 16, top: 9),
                      suffixIcon: HideIconWidget(
                        isObscure: _obscure,
                        suffixAction: suffixAction,
                      ),
                    ),
                    validator: (data) {
                      return _confirmPasswordValidation(data);
                    },
                    defaultHintColor: AppColors.hintInputForm,
                  ),
                ),
                Container(
                  width: context.sizeOf.width,
                  margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " * Deve conter no mínimo 8 dígitos.",
                        style: AppFonts.defaultFont(
                          color:
                              isPasswordValid(_passwordController.text)
                                  ? AppColors.darkGreen
                                  : AppColors.grey8,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Text(
                          " * Atenção! As senhas não correspondem.",
                          style: AppFonts.defaultFont(
                            color: AppColors.delete,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 93),
                  child: LoadingButtonWidget(
                    isPressed: isPressed,
                    action: () async {
                      //if (isValid) {
                      pushNamed(
                        AppRoutes.authRoute +
                            AppRoutes.resetPasswordSuccessRoute,
                      );
                      //}
                    },
                    isValid: true,
                    label: "Entrar",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  _passwordBorderValidation(bool value) {
    Future.delayed(Duration.zero, () async {
      if (mounted) {
        setState(() {
          _isPasswordValid = value;
        });
      }
    });
  }

  _confirmPasswordBorderValidation(bool value) {
    Future.delayed(Duration.zero, () async {
      if (mounted) {
        setState(() {
          _isConfirmPasswordValid = value;
        });
      }
    });
  }

  _confirmPasswordValidation(String? data) {
    if (data == null || data.isEmpty) {
      _confirmPasswordBorderValidation(false);
    } else {
      _confirmPasswordBorderValidation(true);
    }
  }

  _passwordValidation(String? data) {
    if (data == null || data.isEmpty) {
      _passwordBorderValidation(false);
    } else {
      _passwordBorderValidation(true);
    }
  }
}
