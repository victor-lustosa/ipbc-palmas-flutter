import 'package:auth_module/src/ui/stores/login_state.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../stores/login_store.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginStore _store = Modular.get<LoginStore>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();

  final String _emailErrorText = 'por favor, insira um email válido.';
  final String _passwordErrorText = 'por favor, insira uma senha.';

  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _obscure = true;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _store,
      builder: (_, state, child) {
        if (state is LoadingLoginState) {
          _isPressed = true;
        }
        if (state is InitialLoginState) {
          _isPressed = false;
        }
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 60, bottom: 32),
                    child: const Image(
                      image: AssetImage(
                        AppImages.logoLoginImage,
                      ),
                      fit: BoxFit.cover,
                      width: 166,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Text(
                      'Fazer login',
                      style: AppFonts.defaultFont(
                        color: AppColors.grey10,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  TemplateFormWidget(
                    controller: _emailController,
                    title: 'Insira seu email',
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
                  TemplateFormWidget(
                    controller: _passwordController,
                    titleMargin: EdgeInsets.only(top: _isEmailValid ? 24 : 12),
                    title: 'Insira sua senha',
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
                        right: 0,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _obscure = !_obscure;
                          });
                        },
                        child: _obscure
                            ? const IconButtonWidget(
                                size: 24,
                                color: AppColors.grey7,
                                iOSIcon: CupertinoIcons.eye_slash,
                                androidIcon: Icons.visibility_off_outlined,
                              )
                            : const IconButtonWidget(
                                size: 24,
                                color: AppColors.grey7,
                                iOSIcon: CupertinoIcons.eye,
                                androidIcon: Icons.visibility_outlined,
                              ),
                      ),
                    ),
                    validator: (data) {
                      return _passwordValidation(data);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8, right: 15.5),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                style: AppFonts.defaultFont(
                                  color: AppColors.darkGreen,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  decorationColor: AppColors.darkGreen,
                                ),
                                text: "Esqueceu a senha? ",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (!_isPressed) {
                                      Modular.to.navigate(
                                          AuthModule.initialRoute +
                                              AuthModule.resetPasswordRoute);
                                    }
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  AnimatedContainer(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.only(
                      top: 40,
                      bottom: 24,
                      left: 16,
                      right: 16,
                    ),
                    width: _isPressed ? 48 : context.mediaQuery.size.width,
                    height: 48,
                    duration: const Duration(milliseconds: 750),
                    curve: Curves.fastOutSlowIn,
                    child: ElevatedButtonWidget(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      action: () async {
                        if (_emailController.text.isEmpty && !_isPressed) {
                          _emailBorderValidation(false);
                        }
                        if (_passwordController.text.isEmpty && !_isPressed) {
                          _passwordBorderValidation(false);
                        }
                        if (_emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            _isEmailValid &&
                            _isPasswordValid &&
                            !_isPressed) {
                          if (EmailValidator.validate(_emailController.text)) {
                            await _store.logIn(_emailController.text,
                                _passwordController.text, context);
                          } else {
                            _emailBorderValidation(false);
                          }
                        }
                      },
                      padding: EdgeInsets.zero,
                      backgroundColor: _isEmailValid && _isPasswordValid
                          ? AppColors.darkGreen
                          : AppColors.disableButton,
                      shadowColor: AppColors.grey0,
                      foregroundColor: AppColors.white,
                      child: _isPressed
                          ? const LoadingWidget(
                              androidRadius: 2,
                              iosRadius: 11,
                              size: 20,
                              color: AppColors.white,
                            )
                          : const Text(
                              "Entrar",
                            ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.loginLineDecoration),
                        ),
                        width: 159,
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                    ),
                    height: 48,
                    width: context.mediaQuery.size.width,
                    child: ElevatedButtonWidget(
                      backgroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadowColor: AppColors.grey0,
                      foregroundColor: AppColors.grey10,
                      textStyle: AppFonts.defaultFont(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      action: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 12),
                            child: Image.asset(
                              AppIcons.googleIcon,
                              width: 30,
                              height: 30,
                            ),
                          ),
                          const Text(
                            "Fazer login com o Google",
                          ),
                          const SizedBox(
                            width: 18,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 12,
                      left: 16,
                      bottom: 25,
                      right: 16,
                    ),
                    height: 48,
                    width: context.mediaQuery.size.width,
                    child: ElevatedButtonWidget(
                      backgroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      foregroundColor: AppColors.grey10,
                      textStyle: AppFonts.defaultFont(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      action: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 12),
                            child: Image.asset(
                              AppIcons.faceIcon,
                              width: 32,
                              height: 32,
                            ),
                          ),
                          const Text(
                            "Fazer login com o Facebook",
                          ),
                        ],
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Não possui conta?  ",
                          style: AppFonts.defaultFont(
                            color: AppColors.grey9,
                            fontSize: 15,
                          ),
                        ),
                        TextSpan(
                          style: AppFonts.defaultFont(
                            color: AppColors.darkGreen,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.darkGreen,
                          ),
                          text: "Criar conta ",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => setState(
                                  () {
                                    if (!_isPressed) {
                                      _store.toCreateAccount();
                                    }
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
      if (EmailValidator.validate(_emailController.text)) {
        _emailBorderValidation(true);
      } else {
        _emailBorderValidation(false);
      }
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
