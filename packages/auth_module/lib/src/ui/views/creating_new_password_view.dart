import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    suffixAction() => setState(() {
          _obscure = !_obscure;
        });
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: BackButtonWidget(
                    action: () => Modular.to.navigate(
                      AuthModule.authRoute + AuthModule.verificationCodeRoute,
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
            TemplateFormWidget(
              controller: _passwordController,
              titleMargin: EdgeInsets.only(
                top: _isPasswordValid ? 24 : 12,
              ),
              title: 'Crie sua senha',
              isValid: _isPasswordValid,
              errorText: _passwordErrorText,
              globalKey: _passwordKey,
              isPressed: _isPressed,
              obscure: _obscure,
              inputDecoration: fieldInputDecoration(
                isValid: _isPasswordValid,
                hintText: 'Senha',
                contentPadding: const EdgeInsets.only(
                  left: 16,
                  top: 9,
                ),
                suffixIcon: _obscure
                    ? IconButtonWidget(
                        action: suffixAction,
                        size: 24,
                        color: AppColors.grey7,
                        iOSIcon: CupertinoIcons.eye_slash,
                        androidIcon: Icons.visibility_off_outlined,
                      )
                    : IconButtonWidget(
                        action: suffixAction,
                        size: 24,
                        color: AppColors.grey7,
                        iOSIcon: CupertinoIcons.eye,
                        androidIcon: Icons.visibility_outlined,
                      ),
              ),
              validator: (data) {
                return _passwordValidation(data);
              },
              defaultHintColor: AppColors.hintInputForm,
            ),
            TemplateFormWidget(
              controller: _confirmPasswordController,
              titleMargin: EdgeInsets.only(
                top: _isConfirmPasswordValid ? 24 : 12,
              ),
              isValid: _isConfirmPasswordValid,
              errorText: _confirmPasswordErrorText,
              globalKey: _confirmPasswordKey,
              isPressed: _isPressed,
              obscure: _obscure,
              inputDecoration: fieldInputDecoration(
                isValid: _isConfirmPasswordValid,
                hintText: 'Repetir senha',
                contentPadding: const EdgeInsets.only(
                  left: 16,
                  top: 9,
                ),
                suffixIcon: _obscure
                    ? IconButtonWidget(
                        action: suffixAction,
                        size: 24,
                        color: AppColors.grey7,
                        iOSIcon: CupertinoIcons.eye_slash,
                        androidIcon: Icons.visibility_off_outlined,
                      )
                    : IconButtonWidget(
                        action: suffixAction,
                        size: 24,
                        color: AppColors.grey7,
                        iOSIcon: CupertinoIcons.eye,
                        androidIcon: Icons.visibility_outlined,
                      ),
              ),
              validator: (data) {
                return _confirmPasswordValidation(data);
              },
              defaultHintColor: AppColors.hintInputForm,
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
              child: ButtonWidget(
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
